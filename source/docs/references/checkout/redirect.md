---
title: Checkout Reference
layout: tutorial

summary: >
  A full API reference for Checkout.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.checkout_reference
  header_active: References

---

#  Redirect parameters
Transaction information is returned as key/value pairs of the query string passed in the URL of a GET request.

| Variable | Type | Description |
| -------- | ---- | ----------- |
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
| trnType | Up to 3 alphanumeric characters | The type of transaction. See table. |
| paymentMethod | 2 character alphanumeric | CC - credit card, IO - Interac Online. |
| ref1 | Up to 256 alphanumeric characters | Custom order reference. |
| ref2 | Up to 256 alphanumeric characters | Custom order reference. |
| ref3 | Up to 256 alphanumeric characters | Custom order reference. |
| ref4 | Up to 256 alphanumeric characters | Custom order reference. |
| ref5 | Up to 256 alphanumeric characters | Custom order reference. |
| eci | Single digit | See table. |

####  AVS
| Variable | Type | Description |
| -------- | ---- | ----------- |
| avsProcessed | Binary digit | 1 is a successful attempt, 0 is no attempt to perform AVS. |
| avsID | Single digit | ID number from an AVS response. See table. |
| avsResult | Binary digit | Both address and postal/ZIP code match. 1 is a match, 0 is a mismatch. |
| avsAddrMatch | Binary digit | Street address match. 1 is a match, 0 is different. |
| avsPostalMatch | Binary digit |  Postal/ZIP code match. 1 is a match, 0 is different. |
| avsMessage | Up to 128 alphanumeric characters | Description of the avsID. |

####  Interac Online
| Variable | Type | Description |
| -------- | ---- | ----------- |
| ioConfCode | Up to 15 alphanumeric characters | INTERAC Online confirmation
code. |
| ioInstName | Up to 30 alphanumeric characters | INTERAC Online financial institution. |

####  CAV
| Variable | Type | Description |
| -------- | ---- | ----------- |
| rspCavResult | Single digit | CAV. 1 - validation passed, 2 - validation failed. |
| rspCodeAddr*N* | 3 digits | CAV. Up to four address codes will be returned for each CAV item. (respCodeAddr1, rspCodeAddr2, etc) |
| rspCodeCav | 3 digits | If CAV service is enabled with service version 1.0, a single Equifax response message will be returned here. |
| rspCodeCredit*N* | 3 digits | CAV. Up to four address codes will be returned for each CAV item. (rspCodeCredit1, rspCodeCredit2, etc) CAV. |
| rspCodeDob | 4 digits | CAV. A Date of Birth match response code. |
| rspCodeSafeScan | Single character | 1 to 20 detailed SafeScan codes will be returned in this parameter. Requires service subscription. In SafeScan versions 1.1 and higher, multiple codes are appended with a separator. |
| rspCodeSafeScanID | Single character | 1 to 20 SafeScanID codes may be returned. Requires service subscription. In SafeScan ID version 1.1 and higher, multiple values are returned with a separator. |
| rspCustomerDec | Alphanumeric | Provides information specific to any consumer declaration recorded on the consumer’s credit file. |
