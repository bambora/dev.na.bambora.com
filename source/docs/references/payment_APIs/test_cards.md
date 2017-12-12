---
title: Test Cards
layout: tutorial

summary: >
  You can use the sample credit cards below to trigger different responses from our gateway.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.payment_apis
  header_active: Guides

---

# Test cards

You can use the sample credit cards below to trigger different responses from our gateway. You can use them on test accounts, but not on your live account.

### Approved

| Brand                     | Card number      | CVV  |
|:--------------------------|:-----------------|:-----|
| Visa                      | 4030000010001234 | 123  |
| Mastercard                | 5100000010001004 | 123  |
| Mastercard (2-series BIN) | 2223000048400011 | 123  |
| American Express          | 371100001000131  | 1234 |
| DISCOVER                  | 6011500080009080 | 123  |

### Declined

| Brand                     | Card number      | CVV  |
|:--------------------------|:-----------------|:-----|
| Visa                      | 4003050500040005 | 123  |
| Mastercard                | 5100000020002000 | 123  |
| American Express          | 342400001000180  | 1234 |
| DISCOVER                  | 6011000900901111 | 123  |

### 3D Secure

| Brand                      | Card number      | CVV  | Password |
|:---------------------------|:-----------------|:-----|:---------|
| Visa (Verified by Visa)    | 4123450131003312 | 123  | 12345    |
| Mastercard (SecureCode)    | 5105105105105100 | 123  | 12345    |
| American Express (SafeKey) | 71449635398431   | 1234 | 12345    |

### Test amounts

| Brand                     | Card number      | CVV  |
|:--------------------------|:-----------------|:-----|
| Visa                      | 4504481742333    | 123  |

- Approved for transactions less than $100
- Declined for transactions higher than $100

### AVS
All billing addresses in the Canada or the United States will trigger an AVS response. You can trigger an approved AVS response on all test cards with the same street address and postal code:

- Street address - 1407 Graymalkin Lane
- Postal code - 111 111
