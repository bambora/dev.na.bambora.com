---
title: Merchant Quickstart
layout: tutorial

summary: >
  Learn how to create, configure, and test your merchant account with our Payment APIs.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.merchant_quickstart
  header_active: Guides

---

# Merchant Quickstart

This guide is here to get your Merchant Account up and running quickly. You'll learn to create, configure, and test your account using our Payment APIs.

## Requirements

### Creating A Test Account

Fill out our [sign up form](https://dev.na.bambora.com/docs/forms/create_test_merchant_account) to instantly get a developer account with access to a sandbox.

### Merchant ID

All transactions through the API require your Merchant ID. It is permanently displayed at the top right corner of your [Member Area](https://web.na.bambora.com).

You can also find your Merchant ID by clicking on **administration** and then **Company Info**.

### Finding Passcodes

Depending on which API you intend to use for your business, you'll need a passcode to complete the call.

After logging into the [Member Area](https://web.na.bambora.com/), select **administration**,  then **account settings**, and finally **order settings**.

On the Order Settings page, you'll find the **Payment Gateway** section with the sub-header **Security/Authentication**. Here you can set an API access code by clicking the **Generate New Code** button. Once you have a new code, click **Update** at the bottom of the page.

You can set passcodes for **Recurring Billing**, **Reporting**, **Batch File Upload** the same way in each category on the Order Settings page.

To set a **Payment Profile** passcode, you'll need to navigate to **configuration**, then **payment profile configuration** from the left. Under **Security Settings**, you can click **Generate New Code**.


The next step is to accept a payment by [calling our API's](https://dev.na.bambora.com/docs/guides/merchant_quickstart/calling_APIs/).
