---
title: Batch Payment Report API Spec
layout: tutorial

summary: >
  API spec for our Batch Payment Report API.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.batch_payment
  header_active: References

---

# Batch Payment Report API

This document lists and describes the properties expected in the request and response objects.

- **URL** - https://na.bambora.com/scripts/reporting/report.aspx
- **Method** - POST

## Request

The API expects an XML document in the body of the request. The XML declaration should identify the version as "1.0" and the version as "UTF-8".

```
<?xml version="1.0" encoding="UTF-8"?>
```

The API requires the XML document to include `merchantId` and `passCode` elements for authorization, and, `serviceName` and `rptFormat` elements to identify the type and format of report to be returned. All other supported elements are filters to constrain the results in the report.

Filters are assembled as in groups containing a column name (`rptFilterBy*`), an operation type (`rptOperationType*`) and a value (`rptFilterValue*`). The API requires the XML document to include all three, if any one is included.

### Elements

- **merchantId** - The authorizing merchant ID. Numeric string. Length: 9 chars.
- **passCode** - The reporting passcode for the authorizing merchant. Alphanumeric string. Max length: 64 chars.
- **rptVersion** - Numeric string. API version. Current version: "2.0".
- **serviceName** - Type of report. Informed by the type of batch files that you want to report on. Enum.
  - **BatchPaymentsEFT** - EFT only
  - **BatchPaymentsACH** - ACH only
  - **BatchSettlement** - ACH or EFT
- **rptFormat** - Format of the response
  - **JSON**, **XML**, **CSV**, **TSV**, or **XLS**
- **rptFilterBy1**, **rptFilterBy2**, **rptFilterBy3**, **rptFilterBy4** - Enum
  - **batch_id** - Batch identifier. This is a unique identifier per merchant account.
  - **trans_id** - Batch transaction id. This is a unique identifier per transaction uploaded to a merchant account across all batch files. The unique transaction reference to a batch transaction is a combination of 'merchant_id', 'batch_id', and 'trans_id'.
  - **state_id** - The progress of valid transactions through the settlement process.
  - **status_id** - Our validation of the format of the request
  - **returned_date** - Date the bank has applied a return or reject against the transaction. YYYY-MM-DD
  - **noc_date** - ACH only
- **rptOperationType1**, **rptOperationType2**, **rptOperationType3**, **rptOperationType4** - Enum
  - **EQ** - Equal to
  - **LT** - Less than
  - **GT** - Greater than
  - **LE** - Less than or equal to
  - **GE** - Greater than or equal to
  - **NE** - Not equal to
- **rptFilterValue1**, **rptFilterValue2**, **rptFilterValue3**, **rptFilterValue4** - Value to filter against
- **rptAddCondition1**, **rptAddCondition2**, **rptAddCondition3**, **rptAddCondition4** - Enum
  - **AND**
  - **OR**
- **rptSortBy1**, **rptSortBy2** - Sort the results. Enum.
  - **batch_id** - Batch identifier. This is a unique identifier per merchant account.
  - **trans_id** - Batch transaction id. This is a unique identifier per transaction uploaded to a merchant account across all batch files. The unique transaction reference to a batch transaction is a combination of merchant_id, batch_id, and trans_id.
  - **state_id** - The progress of valid transactions through the settlement process.
  - **status_id** - Our validation of the format of the request
  - **returned_date** - Date the bank has applied a return or reject against the transaction. YYYY-MM-DD
  - **noc_date** - ACH only
- **rptFromDateTime** - Batch Processing Date and Time Start
- **rptToDateTime** - Batch Processing Date and Time End
- **rptStartRow** - Start row for paging
- **rptEndRow** - End row for paging
- **rptMerchantId** - Partners only. The sub-merchant ID to report against. Enum or number.
  - **All**
  - **AllLive**
  - A valid merchant ID

## Response

The format of the response object is relative to `rptFormat` element in the request in either JSON, XMl, TSV, CSV, or XLS formats.

JSON and XMl response object contains a "code" property" indicating the success of the request. This will be a number between 1 and 8, inclusive, where "1" indicates success. It also has a message property with a description of the code.

- Code: "**1**", Message:	"Report Generated"
- Code: "**2**", Message:	"Unknown error"
- Code: "**3**", Message:	"Malformed xml request"
- Code: "**4**", Message:	"Unsupported content type"
- Code: "**5**", Message:	"Unsecure connection"
- Code: "**6**", Message:	"Data validation failed"
- Code: "**7**", Message:	"Authentication failed"
- Code: "**8**", Message:	"Authorization failed"

## Report Fields

This section documents the fields returned for each of the 4 reports.

### BatchPaymentsEFT
- **merchant_id** - Authorizing merchant identifier. [Numeric. 9 digits.]
- **batch_id** - Batch identifier. This is unique per merchant account. [Numeric.]
- **trans_id** - Transaction identifier. This is unique per merchant account. [Numeric.]  
- **item_number** - This is the transaction's line number within a batch file. [Numeric.]
- **payee_name** - Merchant transaction reference field.
- **reference** -
- **operation_type** - Either 'C' to indicate a credit to the payee's account or 'D' to indicate a debit to the payee's account.
- **amount** -
- **state_id** - The progress of valid transactions through the settlement process.
- **state_name** - An enum relative to the state_id.
- **status_id** - Our validation of the format of the request
- **status_name** - An enum relative to the status_id.
- **bank_descriptor** - Text to display on the payee's bank statement associated with the debit/credit.
- **message_id** - Comma separated listing of message IDs. (what are the message IDs?)
- **customer_code** - Payee's Secure Payment Profile customer code.
- **settlement_date** - Date the credit/debit is expected to settle against the payee's bank account. YYYY-MM-DD.
- **returned_date** - Date the bank has applied a return or reject against the transaction. YYYY-MM-DD
- **return_type** - rejected or returned. Enum.
  - **REJ** -  The transaction was rejected.
  - **RET** -  The transaction was returned.
- **eft_id** - Globally unique identifier associated to a transaction that was processed with the bank.

### BatchPaymentsACH
- **merchant_id** - Merchant identifier
- **batch_id** - Batch identifier. This is a unique identifier per merchant account.
- **trans_id** - Batch transaction id. This is a unique identifier per transaction uploaded to a merchant account across all batch files. The unique transaction reference to a batch transaction is a combination of merchant_id, batch_id, and trans_id.
- **item_number** - Numeric line number within a the batch file for the transaction.
- **payee_name** - Name of the bank account holder that is being debited or credited.
- **reference** - Merchant transaction reference field. This is equivalent to order number on credit card transactions
- **operation_type** - Identifying the transaction as a credit or debit transaction to the payee's account.
  - **C** - a credit to the payee's account.
  - **D** - a debit to the payee's account.
- **amount** - Amount of the transaction to debit/credit to the payee's account in pennies.
- **bank_account_type** -
  - **PC** - US Personal Checking account
  - **PS** - US Personal Saving account
  - **CC** - US Corporate Checking account
  - **CS** - US Corporate Savings account
- **sec_code** - The transaction Standard Entry Code.
- **state_id** - The progress of valid transactions through the settlement process.
- **state_name** - An enum relative to the state_id.
- **status_id** - Our validation of the format of the request
- **status_name** - An enum relative to the status_id.
- **bank_descriptor** - Text to display on the payee's bank statement associated with the debit/credit.
- **message_id** - Comma separated listing of message IDs. (what are the message IDs?)
- **customer_code** - The payee's Secure Payment Profile customer code.
- **settlement_date** - Date that the credit/debit is expected to settle against the payee's bank account. YYYY-MM-DD
- **returned_date** - Date that the bank has applied a return or reject against the transaction. YYYY-MM-DD
- **eft_id** - The globally unique identifier associated to a transaction that was processed with the bank.
- **noc_date** - Date that the bank has returned a Notice of Change for the transaction. YYYY-MM-DD
- **noc_account_type** - If an ACH Notice of Change was received against the transaction this contains the account type text name/ID of the account type, e.g. Personal Checking (PC) or Corporate Checking (CC) etc.
  - **PC** - US Personal Checking account
  - **PS** - US Personal Saving account
  - **CC** - US Corporate Checking account
  - **CS** - US Corporate Savings account
- **noc_routing_number** - If an ACH Notice of Change was received against the transaction this contains the routing number the payee's bank account must be updated to.
- **noc_account_number** - If an ACH Notice of Change was received against the transaction this contains the account number the payee's bank account must be updated to.

### BatchSettlement
- **merchant_id** - Merchant identifier.
- **settlement_id** - Unique identifier to the settlement transaction.
- **batch_id** - Batch identifier. This is a unique identifier per merchant account.
- **operation_type** - Identifying the transaction as a credit or debit transaction to the payee's account.
  - **C** - a credit to the payee's account.
  - **D** - a debit to the payee's account.
- **amount** - The amount of the transaction to debit/credit to the payee's account in pennies.
- **sec_code** - ACH Standard Entry Class (SEC) Code to designate how the transaction was authorized by the originator.
- **state_id** - The progress of valid transactions through the settlement process.
- **state_name** - An enum relative to the state_id.
- **status_id** - Our validation of the format of the request
- **status_name** - An enum relative to the status_id.
- **bank_descriptor** - The text to display on the payee's bank statement associated with the debit/credit.
- **message_id** - Comma separated listing of message IDs. (but what are the IDs?)
- **settlement_date** - The date that the credit/debit is expected to settle against the payee's bank account. YYYY-MM-DD
- **returned_date** - Date the bank applied a return or reject against the transaction. YYYY-MM-DD
- **eft_id** - Globally unique identifier associated to a transaction that was processed with the bank. (is this for eft and ach both? is this for the first or second transaction in a funds transfer?)
- **noc_date** - ACH transaction only. Date the bank returned a Notice of Change for the transaction. YYYY-MM-DD
- **noc_account_type** - ACH transaction only.
  - **PC** - US Personal Checking account
  - **PS** - US Personal Saving account
  - **CC** - US Corporate Checking account
  - **CS** - US Corporate Savings account
- **noc_routing_number** - ACH transaction only.
- **noc_account_number** - ACH transaction only.
