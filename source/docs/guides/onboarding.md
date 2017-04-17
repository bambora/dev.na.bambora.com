---
title: Onboarding API
layout: tutorial

summary: >
    A guide for partners to integrate directly to the Onboarding API so that they can build their own user interface as
    an alternative to using the Bambora hosted screens, a user interface for onboarding merchants.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# Onboarding

This guide is for partners who want to use their own customized user interface instead of using the pre-built Bambora 
hosted screen or a branded hosted screen for onboarding merchants.

If you are interested in using a branded hosted screen, please contact your Account Manager.

This guide contains instructions and examples for integrating with the Onboarding API so that you can:

* Create, update, and manage Merchant Applications programmatically
* Create, update, and manage Documents attached to Merchant Applications
* Request the appropriate Terms and Conditions for your flow
* Have applicants accept the Terms and Conditions when submitting the Merchant Application


## Building your Integration

To make use of the Onboarding API with a custom interface, an integration to our Sandbox environment must be built and
then approved by our Onboarding team.

**Step 1:** Request a [partner account](/docs/forms/request_partner_account).
   Once accepted into our partner program, you will be emailed an API access token for testing in our Sandbox
   environment. You will also be provided with a Pricing Package id that will set the rate that the customers are charged
   for processing.   

**Step 2:** Build an API Integration using the Sandbox environment.
   Using the API access token issued to you by your Account Manager you can build an integration with the Sandbox. Please
    see the most recent [Onboarding API Reference](/docs/references/onboarding_API) and the sections below for documentation
    and examples to help you build your integration.   

**Step 3:** Review and Approval.
   Once an integration has been built against the Sandbox environment, you can request a review. Contact your Account
   Manager to start the review and please submit to them a link to your interface and any information they need in order to
   test the integration. Review usually can be completed within a single business day.   

The reviewer will be checking for the following:

* The integration submits complete and correct applications.
* The integration displays or links to the Terms and Conditions.
* The integration displays or links to the prices for card processing.

Once an integration is approved, you will be emailed an API key for the Production environment.

**Step 4:** Update to Production.
   Update your integration for Production using your Production API key. A test application should be completed on the
   Production environment. Please produce a sample test application and then send to your Account Manager the application
   id and the flow used in the test. When the test is complete, we will remove the test data.   

Once a sample test application has been completed in the Production environment, the integration is ready for live data!

## Environments

### Sandbox

You will have access to a Sandbox environment for testing and building your Onboarding integration. The Sandbox 
environment is a clone of the Production environment and allows for testing of the Onboarding Flow. _At this time, the 
Sandbox environment is limited to Onboarding and does not have the ability to test payments._

API calls to the Sandbox environment can be made with this base URL:

`https://sandbox-api.na.bambora.com/`

For example, a request to GET an application created in the PSP-CAD flow would look like:

`https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/applications/{applicationId}`

While developing in the Sandbox, you will probably want to test different application states. The possible application 
states are:

* `in_progress` - An application has been created but is not complete. Applications stay in this state until all of 
their required fields are populated.
* `in_review` - An application has been created and is complete. Applications with all of their required fields 
are automatically moved into the `in_review` state. Once an application is `in_review` data cannot be changed.
* `on_hold` - An application that was previously `in_review` has been set to on hold by an Onboarding reviewer.
* `approved` - An application that was previously `in_review` has been approved. The application is now complete.
* `rejected` - An application that was previously `in_review` has been rejected. To re-submit you will need to create a 
whole new application with the incorrect data fixed.

 
You can force an application to transition to either the `approved` or `rejected` state by submitting a complete set 
of application data (such that it would be `in_review`) and setting a magic string in the `company_name` field on 
a  POST or PUT request:

* **TEST_APPROVED** - will set the application to the 'approved' state
* **TEST_REJECTED** - will set the application to the 'rejected' state

These 'magic strings' will only work in the Sandbox environment and can't be used in the Production environment.
        
### Production

Once your integration has been approved and you have been given a Production API key, you can access the Production 
environment. The Sandbox and Production environments are identical in functionality, except you can't use the 'magic string' 
to force a specific application state. At this time, any accounts created in the Sandbox environment can't be 
automatically transferred to the Production environment and would have to be recreated in Production.

API calls to the Production environment can be made with this base URL:

`https://api.na.bambora.com/`

For example, a request to GET an application created in the PSP-CAD flow would look like:

`https://api.na.bambora.com/v1/boarding/workflows/psp-cad/applications/{applicationId}`


## Request Headers

When making an HTTP request to the Onboarding API, headers are required for Authentication and the API Version.

### Authentication
An Authorization Header with an API access token is required for every request to the API.

Your token can be included in the Authorization Header:

```
Authorization: Bearer YOUR_TOKEN_HERE
```

### API Version
All supported versions of the API are listed on the [Onboarding API Reference](/docs/references/onboarding_API). 
New integrations are required to use the most recent version.

To use a specific API version, add the version number to the Header of your API request. For example, to make requests 
using the most recent version of the API, the headers would include:

```
X-API-Version: 2016-08-18
```

In the event that either an existing API is updated or a new API is introduced, it will be documented in the Changelog 
section of the [Onboarding API Reference](/docs/references/onboarding_API). If a currently supported API version becomes 
deprecated, we will notify all affected partners via email and provide assistance in updating to the most recent version.

   
## Making Requests

The API endpoints are organised according to the functionality being requested, called a 'workflow' or 'flow'.

You can create, read, and update applications for all flows. Some flows support creating and reading documents attached 
to the application. All flows support requesting Terms and Conditions. The API does not support application deletion. 

Each application created is associated with and restricted to a single flow. If the same merchant wants to be able to work 
with two different flows then you will need to create two applications, one for each flow. 

For example, lets say a merchant wants to process both card payments and funds transfers in Canada. Using the API you 
will need to create an application through the `/v1/boarding/workflows/psp-cad/applications` endpoint and the 
`/v1/boarding/workflows/eft-cad/applications` endpoint.

Currently the Onboarding API supports the following types of flows:

### Funds transfer

Funds transfer flows are used for financial transactions between banks such as for direct deposit, payroll, and batch 
transactions. Accounts created with these flows will have the ability to perform funds transfers for the region specified.

Some of the fund transfer flows we support are:

* **SEPA-EUR** 'Single Euro Payments Area' for bank transfers in Euros.
* **BACS-GBP** Bacs Payment Schemes Limited/Bankers Automated Clearing Service in the United Kingdom
* **ACH-USD** Automated Clearing House in the United States
* **EFT-CAD** Electronic Funds Transfer in Canada

### Card payments

Card payment flows are used for processing payments transactions such as credit cards. Accounts created with these flows 
will have the ability to perform payment transactions for the region specified.

Some of the card payment flows we support are:

* **PSP-CAD** for Payment Service Providers in Canada
* **PSP-USD** for Payment Service Providers in the United States

### Gateway

Gateway flows are similar to card payments but the merchant account is held with another acquiror. Accounts created with these 
flows will have the ability to perform gateway transactions for the region specified.

Some of the gateway flows we support are:

* **GW-CDN** for Gateway Services in Canada
* **GW-USA** for Gateway Services in the United States

For a complete list of all supported flows and their specific requirements, please see the [Onboarding API Reference](/docs/references/onboarding_API). 
The most recent version of the API Specifications for each flow for Applications and Documents can be found [here](/docs/references/onboarding_API/v2016-08-18) 
and the most recent version of the Terms and Conditions specification can be found [here](/docs/references/onboarding_API/tac_v2016-08-18).


## Sample Integration Calls

Let’s look at a flow of API for an application for a merchant account provisioned to accept card payments in 
Canadian dollars (PSP-CAD). 

### 1. Terms and Conditions
**GET** `/v1/boarding/workflows/psp-cad/terms/{partner}/{file_type}/version`

You need to either display or link to the Terms and Conditions in your user interface. The API requires that you specify 
the exact version of the Terms And Conditions that your sub-merchant has agreed to, as well as the date and time at 
which they agreed. On the same page that you display the Terms you must also either display or link to the pricing. 
You must clearly tell the customer what rate they are paying. This can just be your regular pricing page, but it must 
state that there are processing fees and what the fees are.

There is an API endpoint for requesting the id of the most recent version of the Terms and Conditions and an API endpoint 
for requesting the Terms and Conditions by that version id. You will need to make two API calls to fetch the Terms and 
Conditions page. You can request the Terms and Conditions in either HTML or PDF format.

This example requests the default Bambora Terms and Conditions as HTML. For the default Terms and Conditions, set the 
value of `partner` to `default`. 

If you would like to arrange for a custom Terms and Conditions page, please contact your Account Manager.

You can execute the following cURL command. _With Terms and Conditions calls only, the version and authorization header 
are optional._

```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/terms/default/html/version \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE"
```

A JSON object will be returned from this call, for example:

```json
{ 
  "version": "o5xq2r8JtnqYUWr1mURrOEZVXyx_fihe",
  "name": "psp-cad/default/html/2017-04-03_21:25:10"
}
```

From the response to the first call you will need to extract the `version`. With that information you can make the 
second API call to fetch the content of the Terms and Conditions:

```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/terms/default/html/version/o5xq2r8JtnqYUWr1mURrOEZVXyx_fihe \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE"
```

This second API Call will return to you the raw HTML or PDF of the Terms and Conditions for the version requested.

When you next **_Create an application_**, you will need to include the JSON data referencing the `version` and `name` of the 
Terms and Conditions that was provided to the applicant. Make sure that you use the `name` from the JSON returned in the 
first API call, and _not_ the name returned in the header data from the second call.

**_When the Onboarding team reviews your user interface and integration, they will ensure that your integration displays 
the Terms and Pricing correctly. This must be completed before you are given an API key for the Production environment._**


### 2. Create an application
**POST** `/v1/boarding/workflows/psp-cad/applications`

There are no 'required' fields in order to make an HTTP request, however when looking at the [Onboarding API Reference](/docs/references/onboarding_API) 
page, fields marked with a red asterix are required in order to get an application to the `in_review` state. Applications 
can't transition to `approved` without first being in the `in_review` state.

You can execute the following cURL request by filling in your version, authorization header, and pricing package id. 
This example does not include all of the fields required to submit a PSP-CAD application, and would result in an 
`in_progress` application:

```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/applications \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE" \
-d '{
    "pricing_id": "123_YOUR_ID_123",
    "applicant": {
      "first_name": "John",
      "last_name": "Doe",
      "phone_number": "222-222-2222"
    }
}'
```

This example includes all of the fields required to submit a PSP-CAD application. In the Sandbox environment, it would 
force an application to the `approved` state. Take special note of the `agreement` attributes, which will be set from 
data gathered in the first step, **_Terms and Conditions_**:


```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/applications \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE" \
-d '{
    "pricing_id": "123_YOUR_ID_123",
    "applicant": {
      "first_name": "Jane",
      "last_name": "Doe",
      "date_of_birth": "1988-03-25T22:00:00.00000Z",
      "phone_number": "222-222-2222",
      "email": "test@example.com",
      "agreement": {
        "name": "psp-cad/default/html/2017-04-03_21:25:10",
        "version": "o5xq2r8JtnqYUWr1mURrOEZVXyx_fihe",
        "timestamp": "2017-03-25T22:04:10.04399Z"
      },
      "address": {
        "address_line1": "123 Main Street",
        "city": "Victoria",
        "country":"CA"
      }
    },
    "business": {
      "company_name": "TEST_APPROVED",
      "annual_sales": 800000.00,
      "merchant_category": "5813",
      "entity_type": "partnership",
      "start_date": "2013-06-01T22:06:00.00000Z",
      "address": {
        "address_line1": "123 Main Street",
        "city": "Victoria",
        "country":"CA"
      },
      "bank_account": {
        "owner_name": "Jane Doe",
        "transit_number": "69877",
        "institution_number": "345",
        "account_number": "3453"
      } 
    }
}'
```

### 3. Read an application
**GET** `/v1/boarding/workflows/psp-cad/applications`

Each workflow provides GET endpoints to fetch an application by its id. You can get the application id from the data 
returned in the POST request.
 
You can execute the following cURL command by filling in your version, authorization header, and application id:

```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/applications/{applicationId} \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE" \
```

When an application is `approved`, you will get back in the response a merchant id for the sub merchant. This merchant 
id will be needed when you start processing payments for that sub merchant.

### 4. Update an application
**PUT** `/v1/boarding/workflows/psp-cad/applications/{applicationId}`

Each workflow provides a PUT endpoint to update application data by its id. You can get the application id from the 
data returned in the POST request. Only applications that are `in_progress` can be updated.

You can update just the applicant `phone_number` for an application by passing only data for the `phone_number` field. 
If you want to leave data as it was first submitted, then do not include those fields in the PUT request.

You can execute the following cURL command by filling in your version, authorization header, and application id:

```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/applications/{applicationId} \
-X PUT \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE" \
-d '{"applicant": {
      "phone_number": "222-867-5309"
      }
    }'
```

If there are fields that you previously passed, but now want removed, then you can set their value to empty string or zero.
 
This example removes the applicants first and last name. You can execute the following cURL command by filling in your 
version, authorization header, and application id:


```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-cad/applications/{applicationId} \
-X PUT \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE" \
-d '{"applicant": {
      "first_name": "",
      "last_name": ""
      }
    }'
```

### 5. Upload supporting documents to an application
**POST** `/v1/boarding/workflows/psp-usd/applications/{applicationId}/documents`

Some workflows provide endpoints to POST, GET, and DELETE documents. The PSP-CAD flow does not currently 
support documents, but the PSP-USD flow does. These examples will use the PSP-USD flow. Only applications `in_progress` 
can have documents added to them. 
 
This example adds a document to an existing in progress application. You can execute the following cURL command by 
filling in your version, authorization header, and an in progress application id.
 
```curl
curl https://sandbox-api.na.bambora.com/v1/boarding/workflows/psp-usd/applications/{applicationId}/documents \
-H "Authorization: Bearer YOUR_TOKEN_HERE" \
-H "Content-Type: application/json" \
-H "X-API-Version : SELECTED_VERSION_HERE" \
-d '{"name": "bank_statement",
     "type": "pdf",
     "base64": "XXxx_PUT_BASE_64_ENCODED_STRING_OF_DOCUMENT_HERE_xxXX" 
    }'
```

## Next Steps: Processing payments
Currently payment processing is only available in the Production environment and cannot be tested with the Onboarding Sandbox environment.

In order to process payments, you will also need to integrate with the [Payments API](/docs/references/merchant_API). To build that integration and gain access to the Back Office, please refer to the [Merchant Quickstart Guide](/docs/guides/merchant_quickstart).

When an application is approved your sub account will be activated, which will allow you to process payments and send money on behalf of a sub-merchant.

## Frequently Asked Questions

* **What date format do I use?**
  * All dates must be in ISO-8601 format with a time: `YYYY-MM-DDThh:mm:ssTZD`. For example a valid time would be `1994-11-05T08:15:30-05:00` For birthdays or dates that you don’t know the exact time you can set the time to zeros.
* **How do I get my integration up and running?**
  * When you have finished testing your integration, contact your Bambora account manager to arrange for a review of your onboarding pages. We need to ensure you have the right Terms and Conditions listed and have the price for any fees listed. Once approved, you will receive a production API key and can begin using the API to onboard customers.
* **How long does it take to approve a merchant once their application goes into the in_review status?**
  * This usually occurs within the day. If there are missing files, such as photo ID, then our team will reach out to the customer and ensure all the information needed is collected.
* **Can I re-use data from one application type to another for the same customer?**
  * Yes! It is common to enable several payment options for a single customer. You can re-use the information from one application for another. Many of the fields are the same, but there are different Terms and Conditions, so you will need to make sure that the user is able to see and agree to all Terms and Conditions.
* **How do I know if an application has been approved?**
  * Currently you must query the API using an HTTP GET request and the application id in order to get the application state.
