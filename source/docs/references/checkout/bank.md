---
title: Bank response codes
layout: tutorial

summary: >
    Bank related response codes for our Payment API.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.checkout_reference
  header_active: References

includes:
  - na/bank_response_codes/gateway
  - na/bank_response_codes/desjardins
  - na/bank_response_codes/elavon
  - na/bank_response_codes/fd
  - na/bank_response_codes/global
  - na/bank_response_codes/chase
  - na/bank_response_codes/td
  - na/bank_response_codes/vital
  - na/bank_response_codes/emulator
  - na/bank_response_codes/iop

---

# Bank response codes
## Overview

This document lists the bank related response codes returned from the Payment API. The "Message ID" and "Cardholder message" columns correspond to the `messageID` and `messageText` properties returned by the API response object. The "Merchant message" column contains an additional detailed message that is not returned by the API.

Responses are broken into 3 groups: gateway, credit card and Interac Online.
Responses related to credit card transactions are sub-grouped by processor (Chase Paymentech, Desjardins, Elavon, First Data, Global, TD, Vital). If you are processing transactions against a test account you will receive responses from our emulator, rather than a processor.

You should only map your responses handlers against message IDs as message strings are not guaranteed to be consistent over time.
