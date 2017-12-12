---
title: Visa Checkout
layout: tutorial

summary: >
    You can use Visa Checkout to integrate Visa’s digital payment service with Bambora’s payment gateway.
    Visa Checkout is a digital payment service where consumers can store card information for Visa, MasterCard,
    Discover, and American Express. Visa Checkout provides quick integration for merchants to accept payments
    from these card holders.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# Visa Checkout

*Note: This is a draft document. All information is accurate, but some information may be missing.
It will completed soon.*

Visa Checkout simplifies and secures online payments by storing payment information.
It removes the need for a customer to re-enter and share card information.

Visa Checkout is a digital wallet. Customers load their digital wallet with their credit, debit and prepaid cards once. They can then retrieve their payment information at any checkout supporting the wallet.

Visa Checkout benefits users by securing their payment information and saving them
time checking out. MasterPass benefits merchants by reducing checkout abandonment.


## Standard integration

A Visa Checkout payment can involve either one or two steps for a merchant.

It will always begin with a user clicking on a Visa Checkout button. Visa Checkout's
SDK handles the event and pops a lightbox where the user can authenticate and select a payment card.
Visa checkout then calls a callback function on the merchant's webpage.

The one step process involves simply listening for a callback from Visa's SDK and calling our Payment API to complete the payment.

The two step process involves listening for a callback from Visa's SDK, calling
our API to retrieve addresses, and then calling our Payment API to complete the payment.

### Caveats

Bambora's Visa Checkout integration is not compatible with 3D Secure.

### Testing

Visa Checkout is not enabled by default on test accounts. Contact us at (support.northamerica@bambora.com)[mailto:support.northamerica@bambora.com]
and we will enable it.

You can test visa checkout on sandbox-web.na.bambora.com.

### Visa Checkout SDK

You will need to add Visa Checkout to your page and register a listener to handle
payments originating from it. You can find out more (here)[https://developer.visa.com/capabilities/visa_checkout/docs].


### Example requests:
The first sample request is optional. It is only required if you need to retrieve addresses.

#### First request

```shell
curl -X POST \
  'https://sandbox-web.na.bambora.com/scripts/process_transaction_info.asp?
  merchant_id=123456789&api_passcode=1q2w3e4r5t6y7u8i9o&requestType=STS&
  visaCheckoutCallID=6629877414595929001'
```

##### First response
```shell
HTTP/1.1 200 OK
Content-Type: text/html

responseType=I&visaCheckoutCallID=6629877414595929001&cardLastFour=1234&
trnCardOwner=Jane Doe&trnExpMonth=02&trnExpYear=20&ordName=Jane Doe
&ordAddress1=123 Main St.&ordAddress2=&ordCity=Victoria&ordProvince=BC&
ordCountry=CA&ordPostalCode=V8D 1A9&ordPhoneNumber=7789671234&
ordEmailAddress=aengusbates@gmail.com&shipName=Jane Doe&
shipAddress1=123 Main St.&shipAddress2=&shipCity=Victoria&
shipProvince=BC&shipCountry=CA&shipPostalCode=V8D 1A9&shipPhoneNumber=7789671234
```

#### Second request
```shell
curl -X POST \
  'https://sandbox-web.na.bambora.com/scripts/process_transaction.asp?
  merchant_id=123456789&api_passcode=1q2w3e4r5t6y7u8i9o&requestType=STS&
  trnAmount=10.00&visaCheckoutCallID=6629877414595929001'
```

##### Second response
```shell
HTTP/1.1 200 OK
Content-Type: text/html

trnStatus=1&trnId=10000010&trnOrderNumber=10000010&trnAuthCode=TEST&rspId=1&
rspMessage=Approved&rspDesc=Approved&responseType=T&avsProcessed=1&avsId=N&
avsResult=0&avsAddrMatch=0&avsPostalMatch=0&
avsMessage=Street+address+and+Postal%2FZIP+do+not+match%2E&cvdId=5&
ref1=&ref2=&ref3=&ref4=&ref5=&trnType=P&paymentMethod=CC&
trnDate=8%2F26%2F2017+11%3A54%3A32+PM&httpStatusCode=200&errorCategory=1&
cardType=VI&cardLastFour=1234&trnAmount=10.00&authorizingMerchantId=123456789
```

## Advanced integration

If you have integrated and certified to Visa’s Visa Checkout API and are handling the redirect to the Visa Checkout Portal
independently of Bambora’s internal integration, you will need to pass the Visa Checkout Call ID with your Payment REST API
request to Bambora. This ensures that your transaction is picked up by the Card Issuer as being a Visa Checkout transaction.

Note: This option must be enabled by us. Contact support if you want to use this method.

The Visa Checkout Call ID must be sent with the transaction request using the following system variable:

| Attribute | Description |
| --- | --- |
| visa_checkout_call_id | The payment request ID returned back from Visa Checkout. |


#### Request
```shell
curl https://api.na.bambora.com/v1/payments \
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYUQ4MkQ5MTk3YjRjYzRiNzBhMjIxOTExZUU5Zjcw" \
-H "Content-Type: application/json" \
-d '{
    "payment_method":"card",
    "order_number":"MyOrderId000011223344",
    "amount":15.99,
    "card":{
        "name":"John Doe",
		"number": "4030000010001234",
		"expiry_month": "12",
		"expiry_year": "18",
		"visa_checkout_call_id": "8102778486678528301"
    }
}'
```

##### Response
```shell
{
    "id": "10000026",
    "approved": "1",
    "message_id": "1",
    "message": "Approved",
    "auth_code": "TEST",
    "created": "2017-02-23T17:26:26",
    "order_number": "MyOrderId000011223344",
    "type": "P",
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
        "last_four": "1234",
        "address_match": 0,
        "postal_result": 0,
        "cvd_result": 1,
	    "eci": 7
    },
  "links": [
	    {
		    "rel": "void",
		    "href": "https://api.na.bambora.com/api/v1/payments/10000026/void",
		    "method": "POST"
	    },
	    {
		    "rel": "return",
		    "href": "https://api.na.bambora.com/api/v1/payments/10000026/returns",
		    "method": "POST"
	    }
  ]
}
```
