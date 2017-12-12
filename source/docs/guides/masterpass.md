---
title: Masterpass
layout: tutorial

summary: >
    You can use Masterpass to integrate Mastercard’s digital payment service with Bambora’s payment gateway.
    Masterpass is a digital payment service where consumers can store card information for Visa, Mastercard,
    Discover, and American Express. Masterpass provides quick integration for merchants to accept payments
    from these card holders.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# Masterpass

*Note: This is a draft document. All information is accurate, but some information may be missing.
It will completed soon.*

Masterpass simplifies and secures online payments by storing payment information.
It removes the need for a customer to re-enter and share card information.

Masterpass is a digital wallet. Customers load their digital wallet with their credit, debit and prepaid cards once. They can then retrieve their payment information at any checkout that supports Masterpass.

Masterpass benefits users by securing their payment information and saving them
time checking out. MasterPass benefits merchants by reducing checkout abandonment.

## Standard integration

A Masterpass payment involves three steps for a merchant.

1. Retrieve a redirect URL from our Payment API.
2. Redirect the user to Masterpass and handle the return redirect from Masterpass.
3. Complete the payment on our Payment API.

### Caveats

Bambora's Masterpass integration does not support 3D Secure.

### Testing

Masterpass is not enabled by default on test accounts. Contact us and we will enable it.

### Example requests:
The first sample request is optional. It is only required if you need to retrieve addresses.

#### (Step 1) First request

```shell
includeShipping=1&paymentMethod=MP&passcode=81B156fbD41540D08D254dF7061D4AB3&
requestType=BACKEND&termUrl=http://8df6431a.ngrok.io/payment/masterpass/callback&
merchant_id=123456789
```

##### First Response

```shell
responseType=R&merchantData=27330dbb10d9895283b18804c65eee43320ede34&pageContents=%3Chtml%3E%3Chead%3E%3C%2Fhead%3E%3Cbody%3E%3Cform%20action%3D%22https%3A%2F%2Fsandbox%2Emasterpass%2Ecom%2FCheckout%2FAuthorize%3Facceptable%5Fcards%3Damex%2Cjcb%2Cmaster%2Cdiscover%2Cvisa%2C%26checkout%5Fidentifier%3Dd492cead841f4ccf9887110d30de8192%26version%3Dv5%26auth%5Flevel%3Dbasic%26oauth%5Ftoken%3D27330dbb10d9895283b18804c65eee43320ede34%22%20method%3D%22post%22%20id%3D%22masterpass%22%20name%3D%22masterpass%22%20%2F%3E%3Cscript%20language%3D%22javascript%22%3Edocument%2Emasterpass%2Esubmit%28%29%3B%3C%2Fscript%3E%3C%2Fbody%3E%3C%2Fhtml%3E
```

#### (Step 2) Return redirect

```shell
oauth_token=27330dbb10d9895283b18804c65eee43320ede34&
oauth_verifier=c8495a0e749a79760a14cefabe8be7739922db3c&
checkoutId=7503921781901832211&
checkout_resource_url=https%3A%2F%2Fsandbox.api.mastercard.com%2Fonline%2Fv5%2Fcheckout%2F7503921781901832211&
mpstatus=success
```

#### (Step 3) Second request

```shell
vbvEnabled=0&
oauth_verifier=c8495a0e749a79760a14cefabe8be7739922db3c&
trnAmount=10.00&
oauth_token=27330dbb10d9895283b18804c65eee43320ede34&
passcode=81B156fbD41540D08D254dF7065D4AB6&
scEnabled=0&
requestType=BACKEND&
checkout_resource_url=https://sandbox.api.mastercard.com/online/v5/checkout/7503921781901832211&
sKeyEnabled=0&
requestType=123456789&
```

##### Second response
```shell
trnApproved=1&trnId=10000011&messageId=1&messageText=Approved&trnOrderNumber=10000011&authCode=TEST&errorType=N&errorFields=&responseType=T&trnAmount=10%2E00&trnDate=8%2F27%2F2017+12%3A43%3A02+AM&avsProcessed=1&avsId=N&avsResult=0&avsAddrMatch=0&avsPostalMatch=0&avsMessage=Street+address+and+Postal%2FZIP+do+not+match%2E&cvdId=5&cardType=MC&trnType=P&paymentMethod=CC&ref1=&ref2=&ref3=&ref4=&ref5=&hashValue=1e48a7346bac9cb6da3dfc4e26d2cd9b2a3e5c6b
```


## Advanced integration

If you have integrated and certified to Mastercard’s Masterpass API and are handling the redirect to the Masterpass Portal independently of Bambora’s internal integration, you will need to pass the Masterpass wallet ID with your Payment API request to Bambora. This ensures that your transaction is picked up by the Card Issuer as being a Masterpass transaction.

The Masterpass Wallet ID must be sent with the transaction request using the following system variable:

| Attribute | Description |
| --- | --- |
| masterpass_wallet_id | The Masterpass code related to the wallet that the card information was sent from. |


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
		"number": "5100000010001004",
		"expiry_month": "12",
		"expiry_year": "18",
		"masterpass_wallet_id": "101"
    }
}'
```


##### Response
```
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
        "card_type": "MC",
        "last_four": "1004",
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
