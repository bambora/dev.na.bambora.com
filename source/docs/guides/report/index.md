---
title: Batch Payment Report
layout: tutorial

summary: >
  Batch credit card, EFT and ACH transaction requests.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.payment
  header_active: Guides

---

# Report

You can get individual transactions by ID using the `/payments/{transId}` endpoint, or you can retrieve multiple transactions using the `/reports` endpoint.

You can report on batches of funds transfers using the `/scripts/reporting/report.aspx ` endpoint. This is covered in a separate document.

## Authorizing requests

## Request format

Request objects must contain a "name",  "start_date" and "end_date", "start_row" and "end_row". They can also contain "criteria" - an array of filters. Each filter object must contain a "field", an "operator" and a "value".

## Response format

The response body contains a JSON object. The structure of the object is dictated by the value passed for "name" property in the request ('Search' or 'TransHistoryMinimal').

## Examples

### Example batch requests

```bash
curl -X POST \
  https://api.na.bambora.com/v1/reports \
  -H 'authorization: Passcode {{passcode_encoded}}' \
  -H 'content-type: application/json' \
  -d '{
  "name": "Search",
    "start_date": "2017-01-01T01:01:03",
    "end_date": "2018-06-05T16:05:00",   
    "start_row": "1",
    "end_row": "1",
    "criteria": [
      {
        "field": "2",
          "operator": "%3D",
          "value": 100.00
      }
    ]
}'
```

### Example batch response

#### 'Search'

```javascript
{
    "records": [
        {
            "row_id": 1,
            "trn_id": 10000105,
            "trn_date_time": "2017-06-01T14:27:28.185-07:00",
            "trn_type": "P",
            "trn_order_number": "10000105",
            "trn_payment_method": "CC",
            "trn_comments": "",
            "trn_masked_card": "1234",
            "trn_amount": "100.00",
            "trn_returns": "0.00",
            "trn_completions": "0.00",
            "trn_voided": 0,
            "trn_response": 1,
            "trn_card_type": "VI",
            "trn_batch_no": 151,
            "trn_avs_result": "U",
            "trn_cvd_result": 1,
            "trn_card_expiry": "0619",
            "message_id": 1,
            "message_text": "Approved",
            "trn_card_owner": "Jo",
            "trn_ip": "72.2.4.128",
            "trn_approval_code": "TEST",
            "trn_reference": 0,
            "b_name": "",
            "b_email": "",
            "b_phone": "",
            "b_address1": "",
            "b_address2": "",
            "b_city": "",
            "b_province": "",
            "b_postal": "",
            "b_country": "",
            "s_name": "",
            "s_email": "",
            "s_phone": "",
            "s_address1": "",
            "s_address2": "",
            "s_city": "",
            "s_province": "",
            "s_postal": "",
            "s_country": "",
            "ref1": "",
            "ref2": "",
            "ref3": "",
            "ref4": "",
            "ref5": "",
            "product_name": "",
            "product_id": "",
            "customer_code": "",
            "currency_abbr": "CAD",
            "merchant_id": 300202779,
            "merchant_name": "foo_test",
            "entry_method": "N",
            "authorizing_merchant_id": 300202779
        }
    ]
}
```

#### 'TransHistoryMinimal'

```javascript
{
    "records": [
        {
            "row_id": 1,
            "trn_id": 10000105,
            "trn_date_time": "2017-06-01T14:27:28.185-07:00",
            "trn_type": "P",
            "trn_order_number": "10000105",
            "trn_masked_card": "1234",
            "trn_amount": "100.00",
            "trn_returns": "0.00",
            "trn_completions": "0.00",
            "trn_voided": 0,
            "trn_response": 1,
            "trn_card_type": "VI",
            "message_id": 1,
            "message_text": "Approved",
            "trn_card_owner": "Jo",
            "b_name": "",
            "b_email": "",
            "b_phone": "",
            "b_address1": "",
            "b_address2": "",
            "b_city": "",
            "b_province": "",
            "b_postal": "",
            "b_country": "",
            "s_name": "",
            "s_email": "",
            "s_phone": "",
            "s_address1": "",
            "s_address2": "",
            "s_city": "",
            "s_province": "",
            "s_postal": "",
            "s_country": "",
            "ref1": "",
            "ref2": "",
            "ref3": "",
            "ref4": "",
            "ref5": "",
            "tax1_amount": 0,
            "tax2_amount": 0,
            "tip_amount": "0.00",
            "notes": ""
        }
    ]
}
```
