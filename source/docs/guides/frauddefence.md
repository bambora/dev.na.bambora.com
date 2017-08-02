---
title: Fraud Defence
layout: tutorial

summary: A list of tools to help keep your business secure.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# Fraud Defence

## About Fraud Defence

Bambora's Fraud Defence represents a simple set of powerful tools that serve to protect your business from risks like fraud and chargebacks.

## Getting started

Before you implement any of our security features, you'll need an SSL Certificate to encrypt all HTTP requests to the API.

### Secure socket layer

Secure Socket Layer (SSL) is a way to encrypt connections between a server and client. SSL is considered as the standard for all internet encryption.

#### SSL certificates

To work with SSL, you need an SSL Certificate validating the connection. 

While we use [GeoTrust Local Certificate](https://www.geotrust.com/), SSL Certificates can be obtained from a variety of sources including your webmaster. 

#### OpenSSL

[OpenSSL](https://www.openssl.org/) is a commonly used way to verify an SSL certificate.

Since a server can have multiple connections, you'll use a `-servername` argument to specify your host.

```shell
openssel s_client -servername api.na.bambora.com -connect api.na.bambora.com:443
```

```shell
openssl s_client -servername www.bambora.com -connect www.bambora.com:443
```

#### Examples

When a connection is being verified, OpenSSL may encounter the following error:

```shell
...
depth=1 /C=US/O=GeoTrust Inc./CN=GeoTrust SSL CA - G3
verify error:num=20:unable to get local issuer certificate
verify return:0
...
---
```

This is resolved by [downloading the latest GeoTrust](https://www.geotrust.com/resources/root-certificates/index.html) **GeoTrust Global CA** as a .PEM file, and running OpenSSL with the `-CAfile` argument pointed at the dowloaded Global CA file.


```shell
openssl s_client -servername api.na.bambora.com -connect api.na.bambora.com:443 -CAfile "FILEPATH/GeoTrust_Global_CA.pem"
```
  
```shell
openssl s_client -servername www.beanstream.com -connect www.beanstream.com:443 -CAfile "FILEPATH/GeoTrust_Global_CA.pem"
```

## Address verification system

### About

The Address Verification System (AVS) is a validation for customers completing credit card transactions, using their own card's details to confirm identity. 

When enabled, AVS checks the billing address entered at the time of transaction with the address on file. If the two addresses do not match, the transaction is automatically declined, reducing the risk of fraud.

> While not all cards have an address stored on file, the vast majority will be able to verify the card holder's information.

### Enabling AVS

To enable AVS, log into the [Member Area](https://web.na.bambora.com). From the left menu, click **administration**, then **account settings**, and finally **order settings**.

Under **Payment Gateway**, you'll find the option to disable **Billing address optional**. By making Billing Address mandatory, all card holders will be required to enter their card's billing address.

### Response codes

When purchase and pre-authorisation transactions are returned from the [Payment API](https://dev.na.bambora.com/docs/references/merchant_API/), it will include response codes that explain the accuracy of the address.

You can also find the AVS response for a transaction in your [Member Area](https://web.na.bambora.com) by navigating to **Reporting/Analysis**, and selecting **Transaction Report**.

| ID | Result | Processed | Address Match | Postal/ZIP Match | Message |
| -- | ------- | --------- | ------------- | ---------------- | ------- |
| 0 | 0 | 0 | 0 | 0 | AVS was not performed on the transaction. |
| 5 | 0 | 0 | 0 | 0 | The response from AVS is invalid. |
| 9 | 0 | 0 | 0 | 0 | AVS data contains an edit error. |
| A | 0 | 1 | 1 | 0 | Street address matches, postal/ZIP does not. |
| B | 0 | 1 | 1 | 0 | Street address matches, postal/ZIP not verified. |
| C | 0 | 1 | 0 | 0 | Street address and postal/ZIP not verified. |
| D | 1 | 1 | 1 | 1 | Street address and postal/ZIP match. |
| E | 0 | 0 | 0 | 0 | The transaction is ineligible for AVS. |
| G | 0 | 0 | 0 | 0 | No address on file, information cannot be verified. |
| I | 0 | 0 | 0 | 0 | International transaction, address cannot be verified. |
| M | 1 | 1 | 1 | 1 | Street address and postal/ZIP match. |
| N | 0 | 1 | 0 | 0 | Street address and postal/ZIP do not match. |
| P | 0 | 1 | 0 | 1 | Postal/ZIP matches, street address not verified. |
| R | 0 | 0 | 0 | 0 | AVS system is unavailable or the request timed out. |
| S | 0 | 0 | 0 | 0 | AVS is not supported at this time. |
| U | 0 | 0 | 0 | 0 | Address information is unavailable. |
| W | 0 | 1 | 0 | 1 | Postal/ZIP matches, street address does not. |
| X | 1 | 1 | 1 | 1 | Street Address and postal/ZIP match. |
| Y | 1 | 1 | 1 | 1 | Street address and postal/ZIP match. |
| Z | 0 | 1 | 0 | 1 | Postal/ZIP matches, Street address does not. |

### Mismatched responses

When the result of an AVS check comes back as a mismatch between postal/ZIP and street address, the system will default to your transaction conditions.

On the same **Order Settings** page, you'll find Transaction Reversal Options. With **AVS Street Mismatch** and **AVS Postal/Zip Code Mismatch** enabled, approved transactions with response codes such as ID A or ID W will automatically decline.

> If you enable CVD Mismatch, approved transactions that do not match the CVD/CVV on file will be automatically declined.
> Enabling CVD Issuer Unable to Process Request will cause transactions to decline whenever a validation cannot be completed.

These options apply to all payment types you select through **Source Types**.
