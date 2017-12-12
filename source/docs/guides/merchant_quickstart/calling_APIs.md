---
title: Calling API's
layout: tutorial

summary: >
    This will guide you through quickly hitting each of our Payment APIs and verifying the success of the operation in the Back Office.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.merchant_quickstart
  header_active: Guides
---

# Calling Payment APIs
We'll now go through the process of performing and validating a transaction using our Payment APIs.

## Requirements

### cURL

We use the command-line tool cURL for all HTTP request examples in this guide. cURL allows you make API requests without a web application, just like you would with command prompts in Windows, or Terminal on Apple computers. You can read more on cURL <a href="https://help.zendesk.com/hc/en-us/articles/229136847-Installing-and-using-cURL">here</a>.

### Postman

For fans of of the HTTP Client [Postman](https://www.getpostman.com), we offer a comprehensive <a href="../../../../resources/postman/Bambora.postman_collection.json" download>collection</a> of requests and an <a href="../../../../resources/postman/Bambora.postman_environment.json" download>environment</a>. The collection uses the pre and post request scripts to set authentication headers and record transaction IDs. Before you run any queries, you'll need to update the environment with your Merchant ID and passcodes.

> Note: Most of your Postman queries containing variables are set to return the related variable: 'Get Token' will set the returned token in the environment.

## Authorization
With your Merchant ID in hand and your passcodes set, you're ready to combine them into the required Authorization header. You can use our encoder to create an authorisation header [here](../../../forms/encode_api_passcode/).

`Authorization: Passcode Base64Encoded(merchant_id:passcode)`

## Create a transaction

### Tokenize a card

To process credit card transactions online, you must be in compliance with standards set out by the Payment Card Industry (PCI). Tokenizing credit card details is the most effective way to reduce the scope of your PCI compliance by removing the interaction between your server and your customer's card details.

You can also use our hosted [Custom Checkout](https://github.com/bambora/na-customcheckout) library to validate and tokenize all card data to further reduce scope.

```shell
curl https://api.na.bambora.com/scripts/tokenization/tokens  \
  -H "Content-Type: application/json" \
  -d '{
     "number":"4030000010001234",
     "expiry_month":"02",
     "expiry_year":"20",
     "cvd":"123"
  }'
```

| Variable | Description |
| -------- | ----------- |
| number | The 16-digit credit card number. |
| expiry_month | The 2-digit month the card expires, as it appears on the card.
| expiry_year | The 2-digit year the card expires, as it appears on the card. |
| cvd | The 3 or 4-digit security code that appears on the back of Visa and MasterCard cards, and the front of American Express. |

### Create a Payment Profile

Once you have a single-use token with payment details, you can use it to store the credit card details as a Payment Profile (multi-use token) for future payments.

```shell
curl https://api.na.bambora.com/v1/profiles  \
  -H "Authorization: Passcode your_encoded_payment_profile_passcode"  \
  -H "Content-Type: application/json" \
  -d '{
      "token":{  
        "name":"John Doe",
        "code":"your_card_token",
      }
  }'
```

| Variable | Description |
| -------- | ----------- |
| name | The cardholder's first and last name as they appear on the card. |
| code | The single-use token ID. |

### Take a payment

With a single-use or multi-use token, you can charge the card.  The sample below displays a transaction for $100 using a Payment Profile.

```shell
curl https://api.na.bambora.com/v1/payments  \
  -H "Authorization: Passcode your_encoded_payment_passcode"  \
  -H "Content-Type: application/json" \
  -d '{
     "amount":100.00,
     "payment_method":"payment_profile",
     "payment_profile":{
       "customer_code":"John Doe",
       "card_id":"your_customer_token",
       "complete":"true"
     }
  }'
```

| Variable | Description |
| -------- | ----------- |
| amount | The total amount of the transaction in local currency. |
| payment_method | The method for the payment, either `card`, `token`, or `payment_profile`. |
| payment_profile | The stored information of the multi-use token. |

After your payment is sent, you can expect an HTTP response with a status code 200, and a payment response object with `code:1, message:approved`. This is your confirmation the payment was approved.

If your transaction was not approved, check the the HTTP response code along with the message in the object. You'll only receive one of two codes from our payment gateway emulator: 1 for approved, 7 for declined.
 >Note: HTTP status codes 200 and 402 mean your transaction reached the gateway. Any other response means your payment did not reach the emulator.

## Searching the transaction
Within the response body , you'll find a Transaction ID. You can perform a transaction request using the Transaction ID at any future date through the Payments API.

```shell
curl -X GET https://api.na.bambora.com/v1/payments/{your_transaction_id} \
  -H "Authorization: Passcode your_encoded_payment_passcode" \
  -H "Accept: application/json"
```

If you're searching for a transaction through the API, you can search by using the date and [up to 24 fields](https://dev.na.bambora.com/docs/references/payment_SDKs/analyze_payments/?shell#search-criteria-bbeb017c6f808baf89a073ba2ef7af68) from a transaction record.

```shell
curl https://api.na.bambora.com/v1/reports \
-H "Authorization: Passcode your_encoded_reporting_passcode"  \
-H "Content-Type: application/json" \
-d '{
     "name": "Search",
     "start_date": "2017-01-01T01:01:03",
     "end_date": "2018-06-05T16:05:00",   
     "start_row": "1",
     "end_row": "2"
   }'
```

Now that you're ready to accept payments, the final step is to access a full gateway and [Go Live](https://dev.na.bambora.com/docs/guides/merchant_quickstart/Boarding/).
