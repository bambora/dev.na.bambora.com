---
title: Onboarding API Overview
layout: tutorial

summary: >
  The Onboarding API allows partners to build their own custom interface through which sub-merchants can sign up for an account.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: References
---

# Onboarding API

The Onboarding API allows partners to build their own custom interface through which sub-merchants can sign up for an account.

Applications can be submitted completed or as partial updates. This allows flexibility for partners and allows full control of how integrators upload sub-merchant data to the API. Partners can integrate to different **workflows** of the API to sign sub-merchants up for various services.

The following workflows are currently supported:

* PSP-CAD - Canadian Card Payments
* PSP-USD - United States Card Payments
* GW-CDN - Canadian Payment Gateway
* GW-USA - United States Payment Gateway
* EFT-CAD - Canadian Funds Transfer
* ACH-USD - United States Funds Transfer
* BACS-GBP - United Kingdom Funds Transfer
* SEPA-EUR - European Funds Transfer


## Changelog


### **API Version 2016-08-18**

[Specification](./v2016-08-18)

[Terms API Spec](./tac_v2016-08-18)

#### May 30th, 2017
* New fields for GW-USA and GW-CDN
    * terminal.first_data_nashville_terminal.visa_debit_number
    * terminal.first_data_nashville_terminal.jcb_number
    * terminal.first_data_nashville_terminal.token_type
    * terminal.global_terminal.amex_number
    * terminal.global_terminal.jcb_number
    * terminal.global_terminal.discover_number
    * terminal.chase_paymentech_terminal.amex_number
    * terminal.chase_paymentech_terminal.discover_number
    * terminal.elavon_terminal.amex_number
    * terminal.elavon_terminal.discover_number
    * terminal.tsys_terminal.amex_number
    * terminal.tsys_terminal.discover_number
* New fields for GW-CDN
    * terminal.td_terminal.visa_debit_number
    * terminal.td_terminal.debit_mc_number
    * terminal.td_terminal.amex_number
    * terminal.td_terminal.discover_number
* New desjardins_terminal for GW-CDN
    * terminal.desjardins_terminal.terminal_id
    * terminal.desjardins_terminal.visa_number
    * terminal.desjardins_terminal.mc_number
    * terminal.desjardins_terminal.amex_number
    * terminal.desjardins_terminal.visa_debit_number
    * terminal.desjardins_terminal.jcb_number

#### May 9th, 2017
* Update and rewrite [Onboarding API Guide](../../guides/onboarding)
* Updated all Onboarding documentation to now use the 'Bambora' name

#### March 6th, 2017
* Changes to all workflows:
    * on_hold is a new state an application can be in while being processed.
* Changes to GW-USA and GW-CDN
    * discover_merchant_id is a new field for first data terminals.
    * amex_merchant_id is a new field for first data terminals. 

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

[Specification](./v2016-06-11)

#### July 20th, 2017
* Added optional custom_data field to all flows.

#### June 8th, 2017
* Added optional Address to Bank flows for BACS-GBP

#### June 11th, 2016
* Changes to all workflows:
    *  **API version is now required in the header attributes X-API-Version: 2016-06-11**
    * Additional properties are no longer allowed. This means that no extra/undefined properties will be allowed to be passed in that are not already in the swagger specification.
    * The list of countries for each flow is now more extensive.
    * Postal code is no longer a required field.
    * Region is now being collected in all flows, it was an enum in previous specific flows for provinces and is now a string maxlength 64.
    * Global address fields replace all existing address fields as follows: Address line 1, Address line 2, Region (includes: state/province/municipality/region), City, Postal Code (includes ZipCode), Country.
* Changes to PSP-USD:
    * applicant.social_security_number is now required.

