---
title: Payment Profile API response codes
layout: tutorial

summary: >
    Response codes related response codes for our Payment Profile API.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.payment_apis
  header_active: References


---

# Payment Profile response codes
## Overview

This document lists the response codes returned from the Payment Profile API. The "Code" and "Description" columns correspond to the response.code and response.message properties returned by the API response object.

You should only map your responses handlers against message IDs as message strings are not guaranteed to be consistent over time.

| Code | Description |
| ---- | ------- |
| 1 | Operation successful |
| 2 | Failed card verification |
| 3 | Secure connection required |
| 4 | Invalid service version |
| 5 | Invalid merchant id |
| 6 | Invalid operation type |
| 7 | Incorrect passcode |
| 8 | Invalid customer code |
| 9 | Session Timeout |
| 10 | Unexpected error – Contact support |
| 11 | Invalid XML message |
| 12 | Passcode authentication access lockout |
| 13 | Passcode authentication failure |
| 14 | Merchant account closed or disabled |
| 15 | Customer code to modify does not exist |
| 16 | Customer code already exists |
| 17 | Duplicate match on payment information |
| 18 | No fields to update in modification request |
| 19 | Customer address/payment information failed data validation |
| 20 | Invalid payment profile account status |
| 21 | User Cancelled |
| 22 | Order number already completed |
| 23 | No match found on Status Response lookup |
| 24 | Duplicate match on billing information |
| 25 | Velocity identifier not assigned to customer code |
| 26 | Fail send email message |
| 27 | Operation not enabled |
| 28 | Invalid profile group |
| 29 | Invalid transaction id |
| 30 | No payment information available |
| 31 | No access to EFT |
| 32 | An answer was provided without a question |
| 33 | No answer was provided |
| 34 | Configuration settings are incomplete |
| 35 | Maximum number of credit cards is reached |
| 36 | No credit card found for customer code and card id |
| 37 | Credit card new information has no changes |
| 38 | Date input format must be YYYYMMDDHHMM |
| 39 | AccountRef parameter must be numeric (18,0) |
| 40 | Payment profile only card cannot be set to non-default |
| 41 | Reporting services error |
| 42 | accountRef value is already assigned to another customer of this merchant |
| 43 | Operation failed, this card has already been added to the profile |
| 44 | Operation failed, no matching card id |
| 45 | Parameters received outside of hash validation. Partial hash must be enabled |
