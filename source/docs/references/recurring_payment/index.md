---
title: Recurring Payment API spec - Create endpoint
layout: tutorial

summary: API spec for Create endpoint on Recurring Payment API.

navigation:
    header: na.tocs.na_nav_header
    footer: na.tocs.na_nav_footer
    toc: na.tocs.recurring_payment_reference
    header_active: guides
---

# Create a recurring payment

##  Request parameters

**URL:** https://api.na.bambora.com/scripts/process_transaction.asp </br>
**Method:** POST

### Authorization
| Parameter | Format | Description |
|----------|--------|-------------|
| requestType | BACKEND | Always pass "BACKEND" (case sensitive). |
| merchant_id | 9 digits | Unique identifier for your Bambora merchant account (not "merchantId"). |
| passcode | 32 digits | Payment API Passcode (not the Recurring Payment API passcode) |

### Schedule
| Parameter | Format | Description |
|----------|--------|-------------|
| trnRecurring | Binary digit. | Always pass "1" to flag as a recurring transaction. |
| rbBillingPeriod | D, W, M, Y | Use with rbBillingIncrement to set billing frequency. Values: D – Days, W – Weeks, M – Months, Y – Years |
| rbBillingIncrement | Numeric. | Use with rbBillingPeriod to specify the billing frequency. For example, if rbBillingPeriod=W and rbBillingIncrement=2, the card is charged every two weeks. |
| rbEndMonth | 1 or 0 | Set to 1 to charge the card on the last day of the month (rbBillingPeriod must be M). |
| rbCharge | 1 or 0 | Set to "0" to delay the first charge until the rbFirstBilling date. Defaults to "1" meaning the card is charged the trnAmount immediately. |
| rbFirstBilling | MMDDYYYY | The date for the first payment. Defaults to the current date if no value is passed. rbCharge must be also be set. |
| rbSecondBilling | MMDDYYYY | The start date of the regular billing schedule. If different to rbFirstBilling, the first payment will be prorated. |
| rbExpiry | MMDDYYYY | The date the recurring billing account expires. If no value is passed the payment will continue indefinitely.  |

### Transaction
| Parameter | Format | Description |
|----------|--------|-------------|
| trnType |  | Always pass "P" for payment. |
| trnAmount |  0.00 | Total transaction amount value. Should include taxes and any other charges. Max 9 digits and max 2 decimal places |

### Card info
| Parameter | Format | Description |
|----------|--------|-------------|
| singleUseToken | 32 chars |  |
| customerCode | Max. 64 alphanumeric characters |  |
| trnCardOwner | Max. 64 chars | Full name of the card holder exactly as on the credit card. |
| trnCardNumber | Max. 20 digits | Customer’s credit card number. |
| trnExpMonth | 2 digits | Card expiry month e.g. March = 03 |
| trnExpYear | 2 digits | Card expiry years must be entered as a number less than 50 (2019=19). trnExpYear and trnExpMonth must be a date in the future. |
| trnCardCvd | 4 digits Amex, 3 digits all other cards | Include the 3 or 4-digit CVD number from the back of the customer's credit card. CVD numbers are not stored in the Bambora system and will only be used for a first recurring billing transaction if passed. |

### Billing address
| Parameter | Format | Description |
|----------|--------|-------------|
| ordName | Max. 64 alphanumeric characters | Capture the first and last name of the customer placing the order. May be different from trnCardOwner. |
| ordEmailAddress | Max. 64 alphanumeric characters. Format a@b.com | Email address for sending automated email receipts. |
| ordPhoneNumber | Max. 32 alphanumeric characters | Collect a customer phone number for follow-up. |
| ordAddress1 | Max. 64 alphanumeric characters | Collect a unique street address for billing. |
| ordAddress2 | Max. 64 alphanumeric characters | Optional variable for longer addresses. |
| ordCity | Max. 32 alphanumeric characters | Customer's billing city. |
| ordProvince | 2 characters | Must match a valid Province or State code. |
| ordPostalCode | 16 alphanumeric characters | Customer’s postal code for billing. |
| ordCountry | 2 characters | Must match a valid ISO Country Code |


### Schedule

| Account setup option | Required variables |
|------------------------------------|---------------------------------------------------|
| Basic account, billing immediately | trnRecurring, rbBillingPeriod, rbBillingIncrement |
| Bill on the last day of month | rbEndMonth, rbBillingPeriod—must be M for monthly |
| Delay first payment | rbCharge, rbFirstBilling |
| Prorate a first payment | rbFirstBilling, rbSecondBilling |
| Set an expiry date | rbExpiry=(date), rbNeverExpires=0 |


##  Response parameters
Transaction information is returned as key/value pairs of the query string passed in the URL of a GET request.

| Variable | Type | Description |
| -------- | ---- | ----------- |
| rbAccountId |  |  |
| trnApproved | Binary digit | 1 - transaction is approved, 0 - transaction is declined. |
| trnId | 8 digits | The unique identifier the transaction. |
| authCode | Up to 32 alphanumeric characters | The unique identifier from the bank for approved transaction. |
| messageID | Up to 3 digits | The response code from the bank. See table. |
| messageText | Characters | Description of the messageID. |
| responseType | Single character | Always "T" as a completed transaction response. |
| trnAmount | Up to 9 digits | The amount of the transaction. |
| trnDate | 20 alphanumeric  | The date and time the transaction was processed. |
| trnOrderNumber | Up to 30 alphanumeric characters | The order number. Defaults to the trnId value. |
| trnLanguage | 3 alpha chars | **eng** - English, **fre** - French. |
| trnCustomerName | - | Always blank for Checkout transactions. |
| trnEmailAddress | - | Always blank for Checkout transactions. |
| trnPhoneNumber | - | Always blank for Checkout transactions |
| cvdID | Single digit | See table. |
| cardType | 2 alpha chars | See table. |
| trnType | Up to 3 alphanumeric characters | Always "P" as a completed purchase. |
| paymentMethod | 2 character alphanumeric | CC - credit card |
| ref1 | Up to 256 alphanumeric characters | Custom order reference. |
| ref2 | Up to 256 alphanumeric characters | Custom order reference. |
| ref3 | Up to 256 alphanumeric characters | Custom order reference. |
| ref4 | Up to 256 alphanumeric characters | Custom order reference. |
| ref5 | Up to 256 alphanumeric characters | Custom order reference. |

###  AVS
| Variable | Type | Description |
| -------- | ---- | ----------- |
| avsProcessed | Binary digit | 1 is a successful attempt, 0 is no attempt to perform AVS. |
| avsID | Single digit | ID number from an AVS response. See table. |
| avsResult | Binary digit | Both address and postal/ZIP code match. 1 is a match, 0 is a mismatch. |
| avsAddrMatch | Binary digit | Street address match. 1 is a match, 0 is different. |
| avsPostalMatch | Binary digit |  Postal/ZIP code match. 1 is a match, 0 is different. |
| avsMessage | Up to 128 alphanumeric characters | Description of the avsID. |
