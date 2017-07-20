---
title: 3D Secure
layout: tutorial

summary: >
    Verified by Visa (VbV), MasterCard SecureCode, and AMEX SafeKey are security features that prompt customers to enter a 
    passcode when they pay by Visa, MasterCard, or AMEX. Merchants that want to integrate VbV, SecureCode, or SafeKey must 
    have signed up for the service through their bank merchant account issuer. This service must also be enabled by our 
    support team.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# 3D Secure

## About 3D Secure

3D Secure is a collection of security measures offered by the three major credit card companies to fight fraudulent transactions. Verified by Visa (VbV), MasterCard SecureCode, and American Express SafeKey require the cardholder to enter a secure Private Identification Number (PIN) directly through a card issuer portal.

After the cardholder's identity is confirmed, the issuer authenticates with a response allowing the transaction to be processed.

> If you have any questions about 3D Secure, our [Customer Experience Team](https://www.bambora.com/en/ca/contact/support/) are always happy to help.

## Requirements

3D Secure is a free service for any of our Merchant Account holde and enabled [on request](https://www.bambora.com/en/ca/contact/support/). You can get immediate access by giving us a call at 1 (888) 472-0811.

> To gain access to the fully integrated process, please let our team know while on the phone.

<!-- Use one of these two options to implement 3D Secure: -->

## Two-step process

With the standard 3D Secure process, two requests must be made to complete a transaction. With this standard set of POSTs, we'll cover VbV, SecureCode, and SafeKey.

### Submit a payment request

When you submit transaction details to our REST API, you'll POST using a request that includes not only the payment and token details, but also the special variable, `term_url`. This URL allows you to direct the response from the issuer's VbV, SecureCode, or SafeKey to a specific location.

```shell
Definition
POST /v1/payments HTTP/1.1

Request
curl https://api.na.bambora.com/v1/payments \
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYUQ4MkQ5MTk3YjRjYzRiNzBhMjIxOTExZUU5Zjcw" \
-H "Content-Type: application/json" \
-d '{
    "payment_method":"token",
    "order_number":"MyOrderId000011223344",
    "amount":15.99,
    "token":{
        "code":"gt7-0f2f20dd-777e-487e-b688-940b526172cd",
        "name":"John Doe",
		"3d_secure":{
			"enabled":true
		}
    },
    "term_url": "https://my.merchantserver.com/redirect/3d-secure"
}'

Response (HTTP status code 302 redirect)

{
  "merchant_data": "2ccd7715-9e97-4f11-9fff36e6584e3200",
  "contents": "%3cHTML%3e%3cHEAD%3e%3c%2fHEAD%3e%3cBODY%3e%3cFORM+action%3d%22https%3a%2f%2fapi.na.bambora.com%2factiveMerchantEmulator%2fgateway.asp%22+method%3d%22POST%22+id%3d%22form1%22+name%3d%22form1%22%3e%3cINPUT+type%3d%22hidden%22+name%3d%22PaReq%22+value%3d%22TEST_paRaq%22%3e%3cinput+type%3d%22hidden%22+name%3d%22merchant_name%22+value%3d%22Seven+Sparrow+Inc.%22%3e%3cinput+type%3d%22hidden%22+name%3d%22trnDatetime%22+value%3d%222%2f23%2f2017+5%3a05%3a42+PM%22%3e%3cinput+type%3d%22hidden%22+name%3d%22trnAmount%22+value%3d%22100.00%22%3e%3cinput+type%3d%22hidden%22+name%3d%22trnEncCardNumber%22+value%3d%22XXXX+XXXX+XXXX+3312%22%3e%3cINPUT+type%3d%22hidden%22+name%3d%22MD%22+value%3d%222CCD7715-9E97-4F11-9FFF36E6584E3200%22%3e%3cINPUT+type%3d%22hidden%22+name%3d%22TermUrl%22+value%3d%22http%3a%2f%2f10.240.9.64%3a5000%2fpayment%2fenhanced%2fredirect%2f3d-secure%22%3e%3c%2fFORM%3e%3cSCRIPT+language%3d%22JavaScript%22%3edocument.form1.submit()%3b%3c%2fSCRIPT%3e%3c%2fBODY%3e%3c%2fHTML%3e",
  "links": [ 
    {
      "rel": "continue",
      "href":"https://api.na.bambora.com/v1/payments/2ccd7715-9e97-4f11-9fff36e6584e3200/continue","method":"POST"
    }
  ]
}
```

Once the 302 response is returned from the issuer portal, the `merchant_data` will need to be saved to the cardholder's current session.

The merchant process URL will decode the response redirect, displaying the information for the cardholder's web browser and forwarding them to their issuer portal. Once there, they will be prompted to enter their secure PIN.

Next, the card issuer will forward a response to the `term_url` using two variables.

| Variable | Description |
| -------- | ----------- |
| PaRes | Transaction authentication code |
| merchant_data | Unique payment ID (MD) |

### Submit a Continue request

Next, you'll take the data from `term_url`, and post it along with the returned `PaRes` and `merchant_data` to our Payments API on the 'continue' endpoint.

If the transaction was declined, or failed to pass VbV, SecureCode, or SafeKey, it will immediately be declined with `messageID=311` .

When the transaction is approved, the `term_url` will be called with the following encoded name and value parameters.

| Parameter | Description |
| ----- | ----------- |
| trnAmount | Transaction amount. |
| merchant_name | The title of your business. |
| merchant_data | The unique payment ID. |
| trnDatetime | The date and time of the transaction: 2017-02-23T17:26:26 |
| pa_res | The PaRes authentication code. |
| term_url | The location for the issuer response. |
| trnEncCardNumber | The obfuscated 16-digit card number. |
| password | An encoded response from the issuer. | 
|opResponse | An encoded response from the issuer. |
| pac | The pre-authorisation completion status. |
| retryAttempt | The number of transaction attempts allowed. |

```shell
Request

https://api.na.bambora.com/v1/payments/2ccd7715-9e97-4f11-9fff36e6584e3200/continue

{
  "payment_method": "credit_card", 
  "card_response": {
    "pa_res": "TEST_PaRes"
  }
}

Response

{
  "id": "10000026",
  "approved": "1",
  "message_id": "1",
  "message": "Approved",
  "auth_code": "TEST",
  "created": "2017-02-23T17:26:26",
  "order_number": "MyOrderId000011223344",
  "type": "PA",
  "payment_method": "CC",
  "amount": 15.99,
  "custom": {
    "ref1": "",
    "ref2": "",
    "ref3": "",
    "ref4": "",
    "ref5": ""
  },
  "card": {
    "card_type": "VI",
    "last_four": "3312",
    "address_match": 0,
    "postal_result": 0,
    "cvd_result": 1,
	"eci": 5
  },
  "links": [
    {
      "rel": "complete",
      "href": "https://api.na.bambora.com/v1/payments/10000026/completions",
      "method": "POST"
    }
  ]
}
```

## Integrated process

If you'd prefer to handle the 3D Secure authentication in a server-to-server environment, you'll need to be certified by Visa, MasterCard, and American Express to handle authentication on your servers. The issuer results of the VbV, SecureCode, or SafeKey authentication can be sent straight to our API with your standard transaction.

All 3D Secure results must be sent with the transaction using the variables below.

| Variable | Description |
| -------- | ----------- |
| xid | The 3D Secure transaction identifier, up to 20 digits. |
| eci | The single digit status code; 5 - authentication completed, 6 - authentication attempted but not completed. |
| cavv | The 40-character cardholder authentication verification value. |

```shell
Definition
POST /v1/payments HTTP/1.1

Request
curl https://api.na.bambora.com/v1/payments \
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYUQ4MkQ5MTk3YjRjYzRiNzBhMjIxOTExZUU5Zjcw" \
-H "Content-Type: application/json" \
-d '{
    "payment_method":"token",
    "order_number":"MyOrderId000011223344",
    "amount":15.99,
    "token":{
        "code":"gt7-0f2f20dd-777e-487e-b688-940b526172cd",
        "name":"John Doe",
		"3d_secure":{
			"enabled":true,
			"xid":"1368023",
			"cavv":"AAABAXlHEQAAAAGXAEcRAAAAAAA=",
			"eci":5
		}
    },
    "term_url": "https://my.merchantserver.com/redirect/3d-secure"
}'

Response

{
  "id": "10000026",
  "approved": "1",
  "message_id": "1",
  "message": "Approved",
  "auth_code": "TEST",
  "created": "2017-02-23T17:26:26",
  "order_number": "MyOrderId000011223344",
  "type": "PA",
  "payment_method": "CC",
  "amount": 15.99,
  "custom": {
    "ref1": "",
    "ref2": "",
    "ref3": "",
    "ref4": "",
    "ref5": ""
  },
  "card": {
    "card_type": "VI",
    "last_four": "3312",
    "address_match": 0,
    "postal_result": 0,
    "cvd_result": 1,
	"eci": 5
  },
  "links": [
    {
      "rel": "complete",
      "href": "https://api.na.bambora.com/v1/payments/10000026/completions",
      "method": "POST"
    }
  ]
}
```

Just as with our two-step process, you'll receive a response back containing encoded name and value parameters.
