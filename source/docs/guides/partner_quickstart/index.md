---
title: Partner Quickstart
layout: tutorial

summary: >
    Learn how to request your partner account, how to test the Onboarding API, and authenticate on behalf of sub-merchants.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.partner_quickstart
  header_active: Guides
---

# Partner Quickstart

With this guide, we'll quickly cover how to request a Partner account, and test the Onboarding API after creating your own sandbox account.

## Request a partner account

After you [request a partner account](https://dev.na.bambora.com/docs/forms/request_partner_account/), we'll supply you with API key for our sandbox environment.

## Authenticating customers

As a Partner, Payment API calls can be made on behalf of customers, if you're configured. Similarly to the [Merchant Quickstart Guide](https://dev.na.bambora.com/docs/guides/merchant_quickstart/),  you'll need an Authorisation header.

```
Authorization: Passcode Base64Encoded(your_partner_merchant_id:passcode)
```

When processing on behalf of a customer, you'll need a header that includes their merchant ID.

```
Sub-Merchant-Id: your_sub_merchant_id
```

## Creating a partial application

To reach our [Onboarding API endpoints](https://dev.na.bambora.com/docs/references/onboarding_API/), you'll need the authentication passcode provided with your partner sandbox account. The sample below outlines the account flow of PSP-CAD.

> You can read more about the PSP-CAD flow, and others in our [Onboarding Guide](https://dev.na.bambora.com/docs/guides/onboarding)

```shell
curl https://uat-onboarding-api.beanstream.com/v1/workflows/psp-cad/applications  \
  -H "Authorization: Passcode your_onboarding_passcode"  \
  -H "Content-Type: application/json" \
  -d '{
  "pricing_id":"your_pricing_ID",
  "applicant":{
    "first_name":"John",
    "last_name":"Doe",
    "phone_number":"222-222-2222",
    "date_of_birth":"2018-03-25T00:00:00.04399Z",
    "email":"person@email.com"
  }
}'
```

As a response, you'll receive an HTTP 201 confirming creation. The response body will contain an ID for the application, and an array for incomplete fields. Until you've completed all required fields, your application will be set as `in_progress`.

## Retrieve the application.

To retrieve the partially completed application, you'll complete a call using the ID from the response.

```
curl https://uat-onboarding-api.bambora.com/v1/workflows/psp-cad/applications/{applicationId}
```

## Learn about Onboarding

To read more about the application process, check out our [Onboarding Guide](https://dev.na.bambora.com/docs/guides/onboarding) and our [Onboarding API specifications.](https://dev.na.bambora.com/docs/references/onboarding_API/)
