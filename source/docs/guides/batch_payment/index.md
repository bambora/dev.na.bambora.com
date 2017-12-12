---
title: Introduction to batched payments
layout: tutorial

summary: >
  Introduction to batched credit card, EFT and ACH payments.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.batch_payment
  header_active: Guides

---

# Batch payment

The Batch Payment API allows you to batch transactions together into a single a API call. This reduces the number of HTTP connections your client has to make.

You can batch credit card transactions and funds transfer (ACH/EFT) transactions. You can use funds transfer transactions to push funds to a creditor, or pull funds from a debtor. The most common use cases for funds transfer transactions is payroll or Accounts Payable, and synchronized subscription models where multiple people are charged on a certain day each month, or each year.

The Batch Payment API is compatible with our Payment Profiles service. This allows you to securely store credit card and bank account details on our servers.

The Batch Report API allows you to query the status of batches and individual transactions.


## Settlement flow

Batches of credit card transactions can be processed immediately, on upload, or they can be scheduled to be processed on a certain date. Scheduled batches of credit card transactions are processed at 0600 PST (AM) each day.

Batches of funds transfer transactions take multiple days to process. Batches submitted before 1100 PST (AM) can be scheduled to begin processing on the same day. Batches submitted after this time will be processed the following day.

### Funds transfers

We process funds transfers in 2 steps. We pull funds from the payer's bank account into our bank account and then we push them to the payee's bank account. For direct debit transactions, you are the recipient.

We add a lag between receiving and re-sending the funds to mitigate the risk associated with returned transfers. This lag is usually 3 to 5 business days and is set relative to the risk associated with your business. Funds transfers can be returned due to closed or invalid bank accounts, insufficient funds, or disputes. We usually receive returns within 2 to 4 business days.

This means that if you have a 3 day lag and you need funds to be deposited in a payee's account on Friday, 5 May, you will need to submit the batch before 1100 on Tuesday, 3 May. Or if you have a 5 day lag and you need funds to be deposited in a creditor's account on Friday, 8 June, you will need to submit the batch before 1100 on Friday, 1 June.

#### 3 day lag
1. Day 1 - We submit a transaction request to the bank and funds are removed from payer's bank account.
1. Day 2 - The bank completes processing the debit and the funds are settled to our bank account.
1. Day 3 - We submit a second transaction request to the bank and funds are removed from our bank account.
1. Day 4 - The bank completes processing the credit and the funds are settled to the payee's account.

#### 5 day lag
1. Day 1 - We submit a transaction request to the bank and fund are removed from payer's bank account.
1. Day 2 - The bank completes processing the debit and the funds are settled to our bank account.
1. Day 3 - We wait for returns.
1. Day 4 - We wait for returns.
1. Day 5 - We submit a second transaction request to the bank and funds are removed from our bank account.
1. Day 6 - The bank completes processing the credit and the funds are settled to the payee's account.

###  Credit card transactions

Batched credit card transactions are processed and settled in the same manner as individual card transactions. Settlement timing is relative to the card type and the processor.

## Transaction fees

Funds transfers are settled in full without a transaction fee being deducted at the time. They are aggregated and charged to your account monthly. Fees are charged at a flat rate per transaction.

A batch of 5 direct debits will involve 5 debit transactions and 1 credit transaction. You will be charged for a total of 6 transactions.

Transactions fees for credit card payments are deducted before settlement.
