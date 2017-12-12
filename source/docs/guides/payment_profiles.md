---
title: Payment Profiles
layout: tutorial

summary: >
    Our Secure Payment Profile service allows merchants to create secure payment profiles — or just "profiles" — for storing confidential contact and/or credit details on our server.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# Payment Profiles

Our Secure Payment Profile service allows merchants to create secure payment profiles, or just "profiles", for storing confidential contact and/or credit details on our server. Transactions can then be processed against these profiles without the need to recollect payment information from the customer. Also, you do not need to store payment information on your systems. Each profile can store multiple cards.

When you save a payment profile you will be given a customer code ID in return. This ID can be used for retrieving the profile information, updating it, and also for making payments.

Payment Profiles can be created with a plain credit card number, however we recommend that you first tokenize the card data in the client-side application and then use that token to create the profile.

Creating and modifying Secure Payment Profiles requires you use your Profiles API Key. If you get an authentication error you might be using your Payments API Key, so double check!

## Processing Steps

### Create Profile (Single-Use Token)

You should create a profile with a single-use token instead of a credit card. This is the suggested method of creating profiles since the card number never has to touch your servers, thus lowering your PCI scope.

```shell
curl -X POST https://api.na.bambora.com/v1/profiles
-H "Content-Type: application/json"
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
-d '{
      "language":"en",
      "comments":"hello",
      "token": {  
        "name":"Bill Smith",
        "code":"1eCe9480a7D94919997071a483505D17"
      }
    }'
```

### Create Profile (Card)

With this action, you can create a new payment profile tied to one individual, assigning, and validating a credit card.

```shell
curl -X POST https://api.na.bambora.com/v1/profiles
-H "Content-Type: application/json"
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
-d '{
      "language":"en",
      "comments":"hello",
      "card":{  
        "name":"Bill Smith",
        "number":"4030000010001234",
        "expiry_month":"12",
        "expiry_year":"23",
        "cvd":"123"
      }
    }'
```

### Retrieve Profile

```shell
curl -X GET https://api.na.bambora.com/v1/profiles/{id}
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
```

### Update a Profile

```shell
curl -X PUT https://api.na.bambora.com/v1/profiles/{id}
-H "Content-Type: application/json"
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
-d '{
      "billing": {
        "name": "joh doe",
        "address_line1": "123 main st",
        "address_line2": "111",
        "city": "victoria",
        "province": "bc",
        "country": "ca",
        "postal_code": "V8T4M3",
        "phone_number": "25012312345",
        "email_address": "bill@smith.com"
      },
      "comment": "updated account"
    }'
```

### Delete a Profile

```shell
curl -X DELETE https://api.na.bambora.com/v1/profiles/{id}
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
```

### Add a Card

You can add a Card with a single-use token instead of a credit card. This is the suggested method of creating profiles since the card number never has to touch your servers, thus lowering your PCI scope.

We recommended that you add cards with a Single Use Token.

```shell
curl -X POST https://api.na.bambora.com/v1/profiles/{id}/cards
-H "Content-Type: application/json"
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
-d '{
      "token": {  
        "name":"John Doe",
        "code":"1eCe9480a7D94919997071a483505D17"
      }
  }'
```

You can also add a card using the card details.

```shell
curl -X POST https://api.na.bambora.com/v1/profiles/{id}/cards
-H "Content-Type: application/json"
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
-d '{
      "card":{
        "name":"Bill Smith",
        "number":"5100000010001004",
        "expiry_month":"02",
        "expiry_year":"14"    
      }
    }'
```

### Retrieve Cards

```shell
curl -X GET https://api.na.bambora.com/v1/profiles/{id}/cards
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
```

### Update a Card

Only the card expiry fields can be updated.

```shell
curl -X PUT https://api.na.bambora.com/v1/profiles/{id}/cards/{card_id}
-H "Content-Type: application/json"
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
-d '{
      "card":{
        "expiry_month":"02",
        "expiry_year":"14"    
      }
    }'
```
### Delete a Card

```shell
curl -X DELETE https://api.na.bambora.com/v1/profiles/{id}/cards/{card_id}
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
```

### Errors

You can read the errors returned by the API [here](/docs/references/payment_APIs).
