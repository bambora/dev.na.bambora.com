---
title: Batch Payment API - Overview
layout: tutorial

summary: >
  Overview of Batch Payment API for credit card, EFT and ACH transaction.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.batch_payment
  header_active: Guides

---

# Batch payment

A batch request is a single API call to upload a file containing a list of transactions. This section describes the batch syntax in detail. The next section contains sample calls.

The number of transactions that you can include in a single batch is limited by the size of the file upload. The maximum file size is 40MB. You should limit the number of transactions in a single batch request to 10,000, as you will encounter longer upload times when uploading larger files. If you need to make more calls than that, use multiple batch requests.

Transactions can reference raw bank or card data, or Payment Profile IDs.

### Test accounts

[Test accounts](../../../forms/create_test_merchant_account) need to be configured to enable Batch Payment functionality. We enable the functionality on request. You just need to email [support.northamerica@bambora.com](mailto:support.northamerica@bambora.com) with your test account ID.

## Authorizing requests

All requests to the Batch Payment API must be authorized. You can authorized a request by passing your merchant ID and API passcode in the Authorization header.

> You can generate an API key for the Batch Payment API in the [Member Area](https://web.na.bambora.com/). After logging in, select **administration**,  then **account settings**, and finally **order settings**.

> On the Order Settings page, you'll find the **Batch File Upload*** section. Here you can set an API access code by clicking the **Generate New Code** button. Once you have a new code, click **Update** at the bottom of the page.


The authorization string is a base64 encoded concatenation of merchant_id, ":", and api_key. You Authorization header will be formatted like this.

`Authorization: Passcode Base64Encoded(merchant_id:passcode)`

### Authorizing as an Integrated Software Vendor (ISV)

If you have a partner account with us, you can specify the sub-merchant account on which to process the batched transactions.

- Authorize the API request as by passing your merchant ID and API passcode in the Authorization header.
- Specify the sub-merchant account id in the body.

## Request format

A batch request is a single HTTP request containing data for multiple transactions, using the `multipart/form-data` content type. The transaction data is passed in .csv format. You can read more about the `content-type` and `boundary` directives on [MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type).

The JSON object and file data are passed on a Content-Disposition headers. You can read more about them on [MDN](https://developer.mozilla.org/es/docs/Web/HTTP/Headers/Content-Disposition).

In addition to the content type and authorization headers, you will need to specify the filetype as 'STD'.

### Format of batched data

The API expects a single CSV file with one transaction per row. It does not expect a header row - this means that you cannot omit any of the expected rows.

## Response format

The server's response is a single HTTP response using the text content type. The response body is formatted as JSON and refers to the success of the batch request itself, not the success of the individual transactions it contained.

You can query individual transactions from a batch through the Batch Payment Report API and the Report API.

The response object contains a "code" property indicating the success of the request. This will be a number between 1 and 23, inclusive, where "1" indicates success. It has a "message" property with a description of the code. It also has a "process_date" property indicating the date that the batch will be sent to the bank to begin processing.

## Examples

This section includes a sample HTTP request that references a file to be uploaded and a sample request where the data is declared inline within the request. It also includes formatted sample data for batched funds transfer and credit card payments.

### Example batch requests

The following two examples show the use of the Batch Payment API. You can run these cURL examples in your Terminal. You can create your authorization header encoder to create an authorization header [here](https://dev.na.bambora.com/docs/forms/encode_api_passcode/). You can also find these example batch requests in our Postman Collection.

#### Vanilla file upload
```shell
curl -X POST \
  https://api.na.bambora.com/v1/payments \
  -H 'authorization: Passcode {{passcode_encoded}}' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F file=@transactions.csv
```

#### File declared inline
```shell
curl -X POST \
  https://api.na.bambora.com/v1/batchpayments \
  -H 'authorization: Passcode your_encoded_passcode' \
  -H 'content-type: multipart/form-data; boundary=WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -H 'filetype: STD' \
  -d '--WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="criteria"
Content-Type: application/json

{
    "process_now": 1
}
--WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="testdata"; filename="transactions.csv"
Content-Type: text/plain

E,C,001,99001,09400313371,10000,1000070001,ACME Corp
E,C,002,99002,09400313372,20000,1000070002,John Doe
E,C,003,99003,09400313373,30000,1000070003,Jane Doe
--WebKitFormBoundary7MA4YWxkTrZu0gW--
'
```

#### Payment authorized by partner and processed on sub-merchant
```shell
curl -X POST \
  https://api.na.bambora.com/v1/batchpayments \
  -H 'authorization: Passcode your_encoded_passcode' \
  -H 'content-type: multipart/form-data; boundary=WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -H 'filetype: STD' \
  -d '--WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="criteria"
Content-Type: application/json

{
    "process_now": 1,
    "sub_merchant_id: {{sub_merchant_id}}"
}
--WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="testdata"; filename="transactions.csv"
Content-Type: text/plain

E,C,001,99001,09400313371,10000,1000070001,ACME Corp
E,C,002,99002,09400313372,20000,1000070002,John Doe
E,C,003,99003,09400313373,30000,1000070003,Jane Doe
--WebKitFormBoundary7MA4YWxkTrZu0gW--
'
```

### Example batch response

```javascript
{
    "code": 1,
    "message": "File successfully received",
    "batch_id": 10000001,
    "process_date": "20170721",
    "process_time_zone": "GMT-08:00"
}
```

### Example EFT file

```bash
E,C,001,99001,09400313371,10000,1000070001,ACME Corp
E,C,002,99002,09400313372,20000,1000070002,John Doe
E,C,003,99003,09400313373,30000,1000070003,Jane Doe
```

### Example EFT file (Payment Profile)

```bash
E,C,,,,10000,,,the_profile_id,dynamic descriptor
```

### Example ACH file

```bash
A,C,256072691,2025621034,PS,10000,0,Patrick Star
A,C,256072691,2025463767,PC,20000,0,Spongebob Squarepants
A,C,021200339,381036789124,PC,30000,0,Krusty Krab
```

### Example Credit card file

```bash
C,P,,4030000010001234,0619,1000,reference_01,Daffy Duck,daffy@example.com,0
C,P,,4030000010001234,0520,2000,reference_01,Bugs Bunny,bugs@example.com,0
C,P,,4030000010001234,0421,3000,reference_01,Porky Pig,porky@example.com,0
```
