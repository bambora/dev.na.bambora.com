---
title: Android Pay
layout: tutorial

summary: >
    Our Payments API now exposes a new 'android_pay' payment method and associated parameters to accept a base 64 encoded Android Pay payment token.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# Android Pay

**Android Pay for Bambora is currently in closed Beta. Contact your Account Manager for early access.**

[https://grow.na.bambora.com/android-pay-beta](https://grow.na.bambora.com/android-pay-beta)

## About Android Pay

Our Payments API allows your mobile app and online store to accept payments through Android devices or from a desktop using Google Chome.

When your customers use Android Pay, a virtual account number is used to represent their payment. No card details are sent with the transaction, keeping them safe and secure.

## Getting started

If this is your first time implementing our APIs we recommend reviewing our [Reference guide](/docs/references/payment_APIs/), to get familiar with Bambora's Payment APIs.

You can find more about Bambora and Android Pay on [Github](https://github.com/bambora/na-payment-apis-demo).

## Requirements

### Registering your Android Pay Merchant ID

Before you accept Android Pay, you'll need to turn on and register an Android Merchant ID with Bambora. Start by logging into your [Member Area](https://web.na.bambora.com). Under **configuration**, click on **mobile payments**. From the Mobile Payments screen, you can enable Android Pay and add an Android Pay Merchant ID.

<img src="/docs/guides/android_pay/android-mobile-payments-screenshot.png" alt="mobile-payments-screenshot">

Enter a unique string and click **ADD ANDROID MERCHANT ID** to create your Android Pay Merchant ID. The ID comes with a newly created Public Key will be used as the `publicKey` parameter in your Android app.

<img src="/docs/guides/android_pay/android-input.png" alt="apple-credentials">

After you've added your Android Pay Merchant ID to your account, you can start integrating to your app.

### Accepting Android Pay

Now that you're ready to accept Android Pay, you'll find plenty of code samples and instructions on integrating to your app through [Google's documentation](https://developers.google.com/android-pay/). To learn more about the basics of Android Pay, [click here](https://www.android.com/pay/).

## API requests

When you make an `android_pay` request to our Payments API, it'll be formatted in JSON, calling to https://api.na.bambora.com/v1/payments/.

```shell
  curl https://api.na.bambora.com/v1/payments \
    -H "Authorization: Passcode XXX1XXx11Xxx1xX1XxxxXxXXXXx1XXX1XxX1XXXxXXXxXxxxX11XXXxX1" \
    -H "Content-Type: application/json" \
    -d '{
          "amount": 1.00,
          "payment_method": "android_pay",
          "android_pay": {
            "android_pay_merchant_id": "<your_android_pay_merchant_id>",
            "payment_token": "<android_pay_base64_encoded_token>",
            "complete": true
          }
        }'
```

| Variable | Description |
| -------- | ----------- |
| amount | The amount of the transaction. |
| payment_method | The method of payment for the transaction. For Android Pay, this will always be `android_pay` |
| android_pay | The object needed to pass an Android Pay token including the Android Pay Merchant ID, and the base64 payment token. |
| android_pay_merchant_id | Your Android Pay Merchant ID found in your Bambora Member Area under **configuration** and then **mobile payments**. |
| payment_token | The encrypted Android Pay token containing card holder details, generated from within your Android app. |
| complete | The type of transaction being performed. True indicates a Purchase, and false is a Pre-Authorisation. |

## Additional examples

### Payment button

The sample below shows the action taken by a payment button in an Android app, generating a payment request.

```java
SupportWalletFragment walletFragment = SupportWalletFragment.newInstance(walletFragmentOptions);

MaskedWalletRequest maskedWalletRequest = WalletUtil.createMaskedWalletRequest(
        itemsToPurchase,
        getString(R.string.public_key));

WalletFragmentInitParams.Builder startParamsBuilder = WalletFragmentInitParams.newBuilder()
        .setMaskedWalletRequest(maskedWalletRequest)
        .setMaskedWalletRequestCode(REQUEST_CODE_MASKED_WALLET);

walletFragment.initialize(startParamsBuilder.build());

getSupportFragmentManager().beginTransaction()
        .replace(R.id.android_pay_container, walletFragment)
        .commit();
```

### Process payment token

Your app will receive a payment token once the payment request has been successfully authorised. You then need to send the payment token to your server, and then from there send it to the Bambora Payments API.

**Note:** You can view additional source code examples for a demo Android client & payment server that implements sending a payment token to the Bambora Payments API here: [Payments API Demo on Github](https://github.com/bambora/na-payment-apis-demo).
