---
title: Interac Online
layout: tutorial

summary: >
    Interac Online is a transaction for Canadian merchants, allowing customers to approve debit transactions without sharing their card details with the merchant.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# Interac Online  

Interac Online is a Canadian service allowing cardholders to authenticate direct debit transactions without sharing their card details. Using this process, the cardholder is redirected to their bank's Interac portal, where they authenticate the transaction using a secure password. Similar to the [3D Secure](/docs/guides/3D_secure/) payment flow, Interac Online takes place with three steps. 

1. Submitting an initial Interac payment request to Bambora.
2. Redirecting the customer to their bank portal using the initial response.
3. Submitting the authenticated payment request to Bambora to the Continue endpoint.

## API requests

The intitial request is made through a POST to our Payments API.

`https://api.na.bambora.com/v1/payments`

The final request is completed using our Continue endpoint.

`https://api.na.bambora.com/v1/payments/{id}/continue`

## Initial request

To start the Interac Online process, you'll send a request to our Payments API with the order number and transaction amount with the `payment_method` set to `interac`.

```shell
POST /v1/payments

curl https://api.na.bambora.com/v1/payments
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYU..."
-H "Content-Type: application/json"
-d '{
      "order_number":"MyOrderId-01234",
      "amount":100.00,
      "payment_method":"interac"     
    }'
```

> Interac Online does not support saving customer details with a multi-use token. 

### First response

The response to the request will provide you with the redirect HTML code to be rendered in the cardholder's browser.

```javascript
// Response object (JSON)
{
  merchant_data (string, max length 32): ,
  contents (string): ,
  links (JSON):
}
```

You'll need to save the `merchant_data` to the cardholder's session before returning the response to the HTML client. This value will also be used later for the `{id}` in the Continue endpoint URL.

## Redirecting the cardholder

The HTML in the `contents` from the first response needs to be embedded and displayed in the cardholder's browser. This will redirect them to their bank's Interac login portal, and prompt them to enter their credentials and accept the transaction.

```html
<!-- Sample URL Decoded Response -->

<HTML>
<HEAD></HEAD>
<BODY>
<FORM action="https://iOnlinegateway.asp" method=POST id=frmIOnline name=frmIOnline>
<input type="hidden" name="IDEBIT_MERCHNUM" value="12345678911">
<input type="hidden" name="IDEBIT_AMOUNT" value="10000">
<input type="hidden" name="IDEBIT_TERMID" value="12345678">
<input type="hidden" name="IDEBIT_CURRENCY" value="CAD">
<input type="hidden" name="IDEBIT_INVOICE" value="">
<input type="hidden" name="IDEBIT_MERCHDATA" value="2F86D946-5531-4495-9D82D7E6D83BA93">
<input type="hidden" name="IDEBIT_FUNDEDURL" value="http://www.myCompany.asp?funded=1">
<input type="hidden" name="IDEBIT_NOTFUNDEDURL" value="http.www.myCompany.asp?funded=0">
<input type="hidden" name="merchant_name" value="Test Company">
<input type="hidden" name="referHost" value="http://www.myCompany.asp">
<input type="hidden" name="referHost2" value="">
<input type="hidden" name="referHost3" value="www.myCompany.asp">
<input type="hidden" name="IDEBIT_MERCHLANG" value="en">
<input type="hidden" name="IDEBIT_VERSION" value="1">
</FORM>
<SCRIPT language="JavaScript">document.frmIOnline.submit();</SCRIPT>
</BODY>
</HTML>
```

When the transaction is approved or declined, the cardholder will be forwarded to the respective URL you've set through the **order settings** in your [Member Area](https://web.na.bambora.com).

### Redirect response

When the redirect from the bank is received, you'll collect the `idebit_` variables, a collection of encrypted strings with transaction details. These strings will be used for `interac_response` in the Continue endpoint URL.

```javascript
InteracResponse {
  funded (string, max length 20): ,
  idebit_track2 (string, max length 256): ,
  idebit_isslang (string, max length 2): ,
  idebit_version (number, max length 1): ,
  idebit_issconf (string, max length 32): ,
  idebit_issname (string, max length 32): ,
  idebit_amount (number, max length 9): ,
  idebit_invoice (string, max length 20):
}
```

## Continue endpoint URL

The final step is to submit a request to our Continue endpoint, completing the transaction. Several variables that you post to the Continue endpoint will use information that you've already collected.

| Variable | Use |
| -------- | --- |
| {id} | merchant_id |
| interac_response | idebit_ | 

```shell
POST /v1/payments/{id}/continue
Content-Type: application/json

curl https://api.na.bambora.com/v1/payments/{id}/continue
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYU..."
-H "Content-Type: application/json"
-d '{
      "payment_method": "interac",
      "interac_response": {
        "idebit_track2": "<string, max length 256)" ,
        "idebit_isslang": "<string, max length 2)" ,
        "idebit_version": "<number, max length 1)" ,
        "idebit_issconf": "<string, max length 32)" ,
        "idebit_issname": "<string, max length 32)" ,
        "idebit_amount": "<number, max length 9)" ,
        "idebit_invoice": "<string, max length 20)"
      }
    }'
```

> The `idebit_amount` is the transaction amount without the decimal, including cents. $123.00 becomes 12300.

### Final Response

```javascript
PaymentResponse {
  payment_method (string): ,
  id (number, max length 9): ,
  approved (number, max length 1): ,
  message_id (number, max length 3): ,
  message (string, max length 32): ,
  auth_code (string, max length 32): ,
  created (date): ,
  order_number (string, max length 30): ,
  type (string, max length 16): ,
  interac_online (json):
  {
    idebit_issconf (string, max length 32): ,
    idebit_issname (string, max length 32): 
  } ,
  links (json):
}
```

In addition to this guide feel free to check out our [Payment APIs Demo implementation](https://github.com/bambora/na-payment-apis-demo) on GitHub.
