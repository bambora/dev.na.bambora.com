---
title: Onboarding API Overview
layout: tutorial

summary: >
  The Onboarding API allows you to build your own custom UI through which a sub-merchants sign up for a Beanstream account or to reuse the information already collected to create a lightweight integration.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: References
---

# Onboarding API

The Onboarding API allows you to build your own custom UI through which a sub-merchants sign up for a Beanstream account or to reuse the information already collected to create a lightweight integration.

You can submit either completed or partially completed applications. This means you can allow your sub-merchant to submit their application in stages or to submit supporting documentation at a later date.

The API allows the partner to specify which services the new merchant account should be provisioned with. The API supports the onboarding of merchants for card payments in Canada and the US, as well as funds transfer services in Europe, the UK and North America.

## Changelog


### **API Version 2016-08-18**

#### March 6th, 2017
* Changes to GW-USA and GW-CDN
    * New fields for first data terminals: discover_merchant_id and amex_merchant_id

#### November 28th, 2016
* New Gateway USA workflow added.

#### November 16th, 2016
* Extensive changes to PSP-USD workflow. See API spec for full details.
* New Gateway CDN workflow added.

#### September 10th, 2016
* Changes to all workflows:
    * agreement.personal_guarantee_accepted is **new** and is optional. The personal guarantee must be accepted where entity_type is "sole_proprietor" or "partnership".
    * Remove restriction on country fields so that full ISO 3166 list of country codes can be accepted.
    * address.region and address.postal_code are now optional.
    * pending_issues.message is new and contains a human readable message about the error.
    * Error responses have renamed field error.name.
    * Error responses have renamed field error.reason.
    * error.message is new and contains a human readable message about the error.
* Changes to PSP-CAD:
    * Owner fields are now optional. The fields must be supplied where business.entity_type is "non_profit" or "corporation".
    * business.has_existing_account is removed.
    * Owners percentage field is removed.
    * business.currency is removed.
* Changes to EFT-CAD:
    * Director all fields are now optional. Director fields must be supplied where business.entity_type is "non_profit" or "corporation" or "publicly_traded".
    * director.start_date is removed.
    * director.percentage is removed.
    * applicant.email is now required.
    * applicant.date_of_birth is **new** and required.
    * business.services_description is **new** and required.


### **API Version 2016-06-11**

#### June 11th, 2016
* Changes to all workflows:
    *  **API version is now required in the header attributes X-API-Version: 2016-06-11**
    * Additional Properties are no longer allowed. This means that no extra/undefined properties will be allowed to be passed in that are not already in the swagger specification.
    * The list of Countries for each flow is now more extensive for each of the flow a large list of countries is available.
    * Postal code is no longer a required field.
    * Region is now being collected in all flows, it was an enum in previous specific flows for provinces and is now a string maxlength 64.
    * Global Address Fields replace all existing address fields as follows: Address line 1, Address line 2, Region (includes: state/province/municipality/region), City, Postal Code (includes ZipCode), Country.
* Changes to PSP-USD:
    * applicant.social_security_number is now required.


### **API Version 2016-06-10 (Deprecated)**

#### November 16th, 2016
* API Version 2016-06-10 removed.

#### September 10th, 2016
* API Version 2016-06-10 deprecated and will be removed in the next release.

#### June 10th, 2016
* First release of the API specification.
