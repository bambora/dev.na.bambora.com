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

## About Profiles

Payment Profiles give you the ability to securely save card and cardholder details to process additional future transactions without collecting details each time.

When you save a customer or cardholder's information, you receive a customer code. This unique ID can be used to view or edit the profile through the API, search for previous transactions, and also complete new transactions.

If you're a Bambora Partner, you can read more about using Shared Profiles [here](/docs/guides/partner_quickstart/).

## Requirements

While Profile API relies on the Payment API, you'll need your own Profile API Key to save and edit cardholder information.

To access your Profile API key, log into you [Member Area](https://web.na.bambora.com), click on **configuration**, and select **payment profile configuration**. You'll be able find and manage your passcode under **Security Settings**.

## Creating a Profile

The easiest way to create a new profile is right after the cardholder's first transaction. Using the single-use token created during the [Checkout process](https://dev.na.bambora.com/docs/guides/custom_checkout/), you can create a full profile with the customer's name and the tokenization code returned from the API.

In the sample below, a profile for Bill Smith will be created using their previous transaction details. This will be done with a post to the RESTful API using cURL.

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

### Retrieving a profile

If you need to review or verify any information in a Profile, you can perform a get with the Profile ID to view the saved address, email, or phone number.

```shell
curl -X GET https://api.na.bambora.com/v1/profiles/{id}
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
```

## Editing a Profile

When a cardholder's address or email changes, you can update the details in the Profile by posting the updated fields with the `{id}` using their customer code.

Both the `postal_code` and `province`  fields support ZIP and State codes using [standard ISO format](https://en.wikipedia.org/wiki/ISO_3166-2:US).

```shell
curl -X PUT https://api.na.bambora.com/v1/profiles/{id}
-H "Content-Type: application/json"
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
-d '{
      "billing": {
        "name": "Bill Smith",
        "address_line1": "123 Main St",
        "address_line2": "BSMT",
        "city": "Victoria",
        "province": "BC",
        "country": "CA",
        "postal_code": "V8T4M3",
        "phone_number": "25012312345",
        "email_address": "billsmith@realemail.com"
      },
      "comment": "Updated 15/05/2018"
    }'
```

### Editing a card

To maintain PCI security, we only allow you to update the expiration date of the card. Replacing a card's 16-digit number requires a new card be added. 

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

### Deleting a card

If you need to remove a card from a profile, you can add the card ID to the `{card_id}` variable in the Delete request.

```shell
curl -X DELETE https://api.na.bambora.com/v1/profiles/{id}/cards/{card_id}
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
```

### Deleting a Profile

If you need to completely remove a profile and any card associated, you can do so with the customer ID in the `{id}` variable of the Delete request.

```shell
curl -X DELETE https://api.na.bambora.com/v1/profiles/{id}
-H "Authorization: Passcode bWVyY2hhbnRfaWQ6cGFzc2NvZGU="
```

## More from the Profile API

For more information about Profiles and the API including gets, posts, and errors [here](/docs/references/payment_APIs).
