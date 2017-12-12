---
title: Recurring Payment API - Overview
layout: tutorial

summary: The Recurring Payment API allows you to schedule series of payments to automatically charge your customers every day, week, month or year.

navigation:
    header: na.tocs.na_nav_header
    footer: na.tocs.na_nav_footer
    toc: na.tocs.recurring_payment_guide
    header_active: guides
---

# Recurring Payment

The Recurring Payment API allows you to schedule series of payments to automatically charge your customers every day, week, month or year.

Note: The Recurring Payment API supports basic use cases only. For all other recurring payments we recommend that you handle scheduling on your side while using our Payment Profiles to store card data.

## Create

Create from a Payment Profile or with a single-use token returned by Custom Checkout.


Scheduling is set by both `rbBillingPeriod` and `rbBillingIncrement` parameters. The period is unit of measurement for  the frequency of the payment: day, week, month or year. The increment is the number of periods between each payment. For example, you may want a payment to recur once a month or every 3 months.

A billing cycle can begin on any day or date. If you are setting a monthly billing cycle, you can set the last day of each month as the billing date with the `rbEndMonth` parameters.

You can set an end date for a billing cycle using the `rbExpiry` parameter, or you can set the payment to continue indefinitely with the `rbNeverExpires`.

You can defer the first charge by setting both `rbCharge` and `rbFirstBilling` parameters. The first parameter controls whether or not to charge the card immediately. The second sets the date for the first charge.

You can prorate the first payment by setting both `rbFirstBilling` and `rbSecondBilling` parameters. The value of the first payment will be calculated according to the difference between the first and second payment dates and the set interval for the payment.

### Sample request
```curl
curl -X POST \
  'https://web.na.bambora.com/scripts/process_transaction.asp?requestType=BACKEND&merchant_Id=your_merchant_id&passcode=your_payment_api_passcode&trnType=P&singleUseToken=any_single_use_token&trnAmount=10&trnRecurring=1&rbBillingPeriod=D&rbBillingIncrement=30&trnCardOwner=Rosanna%20Sylvester'
```

### Sample response
```curl
trnApproved=1&trnId=10000677&messageId=1&messageText=Approved&trnOrderNumber=10000677&authCode=TEST&errorType=N&errorFields=&responseType=T&trnAmount=10&trnDate=9%2F12%2F2017+8%3A49%3A34+PM&rbAccountId=6217641&avsProcessed=0&avsId=U&avsResult=0&avsAddrMatch=0&avsPostalMatch=0&avsMessage=Address+information+is+unavailable%2E&cvdId=1&cardType=VI&trnType=P&paymentMethod=CC&ref1=&ref2=&ref3=&ref4=&ref5=&hashValue=fa879fac34852060e908899b9c634608931f97ad
```

## Modify

You can modify a recurring payment to change its amount or schedule. You can put a payment on hold or you can close it.

If a recurring payment is disabled and later reactivated back, payments will be charged unless the `processBackPayments` parameter is passed.

You can only use actual card data when updating the payment card associated with a recurring payment account. Using either a single-use token, or a Payment Profile customer code will not work. We recommend that you create a new recurring payment if you need to change card data.


You cannot update the payment card a recurring payment account using either a using a single-use token, or a Payment Profile. We recommend that you create a new recurring payment if you need to change card data.

### Sample request
```curl
curl -X POST \
  'https://web.na.bambora.com/scripts/recurring_billing.asp?serviceVersion=1.0&operationType=M&merchantId=your_merchant_id&passCode=your_recurring_payment_api_passcode&rbAccountId=6217641&amount=12.00'
```

### Sample response
```curl
<?xml version="1.0" encoding="ISO-8859-1"?>
<response>
    <accountId>6217641</accountId>
    <code>1</code>
    <message>Request successful</message>
</response>
```

## Notifications
You can register for a callback when recurring payments are processed. The callback URL is set in the [Member Area](https://web.na.bambora.com). Click **administration**, then **account settings**, and then **order settings**, under **Response Notification**.

The parameters posted to the webhook are the same as those returned by the API when first creating a Recurring Account.

**Caveat:** The callback is made over HTTPS using TLS 1.0 (rather than TLS 1.2).

### Testing redirects
You may find it helpful while testing to use tools that allow you to inspect and debug webhook requests like [PutsReq](http://putsreq.com).
