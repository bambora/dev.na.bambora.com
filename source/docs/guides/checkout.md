---
title: Checkout
layout: tutorial

summary: The Checkout form provides you with an easy-to-use way to process payments on your site.

navigation: 
    header: na.tocs.na_nav_header
    footer: na.tocs.na_nav_footer
    toc: na.tocs.checkout
    header_active: guides 
---

# Creating a Checkout form

## About Checkout

Checkout allows you to send out a single URL for a hosted, customizable, mobile-friendly  payment form. This guide will show you how to customize and create a form before sending it out to clients, customers, and donors.

## Requirements

To create a [payment form](https://web.na.bambora.com/scripts/payment/payment.asp?merchant_id=300204468&hashValue=fbef85a3436d1583381839779148fefbcefa2699), you'll need two unique pieces of information: your Merchant ID and a hash key. Both can be found in our [Member Area](https://web.na.bambora.com).

### Merchant ID

Your Merchant ID is displayed at the top right corner of your [Member Area](https://web.na.bambora.com).

You can also find your Merchant ID from the left navigation panel under **administration** on the **Company Info** page.

### Hash key

Your hash key is the way to secure your Checkout form along with transaction and customer details, ensuring your payment is completed. 

Click **administration** then **account settings**, and finally **order settings** to access your hash key. You'll use this hash key to generate a link to your form.

#### Manual hash creation

If you're building your link manually and are creating a hashed validation for your string, you'll need to enter your hash key after enabling **Require hash validation on all Payment Gateway transaction requests**. Select the type of **Hash algorithm** you're using (MD5 or SHA-1) and then click **Update**.

> Note: When manually creating your link, any redirect links created with PHP may already have a hash function. If you're using the PHP hash function, you won't need to adjust the type of algorithm.

When you insert your hash value, you'll do so in this base URL:

`https://web.na.bambora.com/scripts/payments/payments.asp`

Make sure to include the hash value in your Checkout form link as a hash variable `&hashValue`, or transactions will automatically be declined. In the sample below, the `merchant_id` is the string that is hashed.

`https://na.bambora.com/scripts/payments/payments.asp?merchant_id=300204468&hashValue=fbef85a3436d1583381839779148fefbcefa2699`

### Payment options

In addition to standard credit card payment, Checkout also allows for the use of Interac Online, Visa Checkout, MasterPass, and advanced Fraud Defense tools.

## Configuring your form

Before you send out your first invoice, you'll want to customize the form for required payment fields and to collect information important to the sale and your business. After you log into the [Member Area](https://web.na.bambora.com), click on **configuration**, and select **payment form** to find a list of title and form options.

You can decide which of the following options is appropriate for your invoices or orders.

| Option | Description |
| ------ | ----------- |
| Transaction Type | Choose between *Purchase* or *Pre-Authorization* as the default transaction type. |
| Include Billing Address | Only available when enabled in your *Order Settings*, this requires the cardholder to provide their billing address to complete a transaction. |
| Include Shipping Address | Enabling this option will allow you to collect the shipping address of the cardholder. |
| Allow Price Modification | Enabling this option will allow the cardholder to select the amount they choose to donate or pay. |
| Include Invoice/Order | Enabling this option will allow you to enter an invoice or order number when creating the payment form. Disabling this option will automatically use the Transaction ID as an order number on Transaction Reports. |
| Include Card Selection | By enabling this option, the cardholder will be able to select their card brand during the transaction. Even when disabled, Bambora's API will automatically detect the brand using card numbers. |
| Include comments | Enable this option to provide custom comments on the payment form. While disabled, comments added during form creation appear on Transaction Reports. |

Once you've finished customizing your form's fields, click **View Preview** at the bottom of the page to see a sample of your hosted payment form. Click **Update Live** to confirm your changes and update your forms.

## Generating a link

Now that you've got a payment form, you'll want to create a link for cardholders to use.

You can use our [Checkout Form Link Builder](https://dev.na.bambora.com/docs/forms/link_builder/) to construct your link.

Your Merchant ID and Hash Key are required pieces of info to build your link. You'll also be able to enter basic details about the cardholder and their purchase whether you use our builder or construct the URL manually using variables.

If you're building your link manually, you'll use a query string API request. After you've entered all the variables, separating each customer and card detail with an ampersand, your full link will look close to:

```
https://web.na.bambora.com/scripts/payment/payment.asp?merchant_id=123456789&trnAmount=19.99&trnOrderNumber=12345TEST
```

### Form fields and variables

Whether you build your form manually or use the [Checkout Form Link Builder](https://dev.na.bambora.com/docs/forms/link_builder/), you'll have the following fields or variables to enter.

#### Order info

| Form Field | API Variable | Description |
| ---------- | ------------ | ----------- |
| Amount | trnAmount | The total amount for the transaction including tax and additional fees. Up to 10 numbers, not including the decimal point. |
| Order Number | trnOrderNumber | The invoice or order ID you want associated with the transaction. Up to 30 characters. |
| Transaction Type | trnType | The type of transaction you want to perform. P - Purchase, PA - Pre-Authorization. |
|Card Owner | trnCardOwner| The name of the cardholder as it appears on the card itself. As a variable, you can use `+` to separate names. 4-64 characters. |
| Language | trnLanguage|The language that will be used to display field titles and form notes. For field or variable, eng - English, fre - French. |

#### Billing info

| Form Field | API Variable | Description |
| ---------- | ------------ | ----------- |
| Name | ordName | The billed contact's name. Up to 64 characters. |
| Email | ordEmailAddress | The email address of the billed contact and destination for email receipts in a valid email format. Up to 64 characters. |
| Address 1 | ordAddress1 | The billing address for the card holder. With Address Verification, this will need to match the card issuer's records. Up to 32 characters. |
| Address 2 | ordAddress2 | The second line for the card holder's billing address. Up to 32 characters |
| City|ordCity | The city associated with the billing address. Up to 32 characters. |
| Province | ordProvince | The province or state associated with the billing address. As a variable, the two-letter ISO code. |
| Postal Code | ordPostalCode | The postal or ZIP code associated with the billing address. Up to 16 characters. |
| Country | ordCountry | The country associated with the billing address. As a variable, the two-letter ISO code. |

#### Shipping info

| Form Field | API Variable | Description |
| ---------- | ------------ | ----------- |
| Name | shipName | The name of the contact receiving the shipment. Up to 64 characters. |
| Email | shipEmailAddress | The shipping contact's email address in a valid email format. Up to 64 characters. |
| Address 1 | shipAddress1 | The shipping contact's destination address. Up to 32 characters. |
| Address 2 | shipAddress2 | The second line of the shipping contact's destination address. Up to 32 characters |
| City | shipCity | The shipping contact's destination city. Up to 32 characters. |
| Province | shipProvince | The shipping contact's province or state destination. As a variable, the two-letter ISO code. [Provinces](https://en.wikipedia.org/wiki/ISO_3166-2:CA) and [States](https://en.wikipedia.org/wiki/ISO_3166-2:US). |
| Postal Code | shipPostalCode | The shipping contact's postal or ZIP code. Up to 16 characters.
| Country | shipCountry | The shipping contact's destination country. As a variable, the [two-letter ISO code](https://www.iso.org/obp/ui/#search/code/). |
| Phone | shipPhoneAddress | The shipping contact's phone number. Up to 32 characters. |

#### Redirects

| Form Field | API Variable | Description |
| ---------- | ------------ | ----------- |
| Approved Link | approvedPage | The URL the cardholder will be sent to after their transaction is approved. By default, the URL provided in **Order settings** will be used. |
| Declined Link | declinedPage | The URL the cardholder will be sent to after their transaction is declined. By default, the URL provided in **Order settings** will be used. |

#### Hash expiry

| Form Field | API Variable | Description |
| ---------- | ------------ | ----------- |
| Hash Expiry | hashExpiry | The time when the hash will expire, cancelling the payment form. Only active with hash validation, the format is YYYYMMDDHHMM on PST using a 24 hour clock. |

#### References info

| Form Field | API Variable | Description |
| ---------- | ------------ | ----------- |
| Ref 1-5 | refn1 | Within each order, up to five references can be added to maintain any information for the order process. Whether you pass shopper ID or account numbers, there is a 256 character limit on each reference, and each reference is added to the transaction details. |

After you've entered all the details, simply click on **Create link** at the bottom of the page to generate a URL that you can copy and send out to your customers.

## Applying a theme

While Checkout is a basic form for you to use when collecting payments it's also easy to update. We also offer a modern user interface (UI) that you can copy and paste into your **payment form**.

### Updating the interface

From the **payment form** page under **configuration**, you can use our custom HTML fields **Page Header** and **Page Footer** to generate a UI that works with mobile screens.

Simply copy the code as it appears below into the **Page Header** field and update the Merchant name to your own business.

```html
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<title> { Merchant Name } - Payment Form </title> 

<link rel="stylesheet" type="text/css" href="https://libs.na.bambora.com/checkouttheme/0.1.0/ui.bambora/ui.bambora.1.1.0.css">
<link rel="stylesheet" type="text/css" href="https://libs.na.bambora.com/checkouttheme/0.1.0/style.css">
</head>

<body>
<script src="https://libs.na.bambora.com/checkouttheme/0.1.0/checkouttheme.min.js"></script>  	
<script> CheckoutTheme.init(); </script>
```

Add this code to your **Page Footer** and you'll have a responsive pay form. 

```html
</body>
</html>
```

### Changing colours

If you've updated Checkout using our sample code, you may want to change the colours from default purple highlights to match your online store.
Add the following code inside the `<head>` tag in **Page Header**.

```html
<style>
/* Edit the hex values here to change the colors of the Hosted Payment Form */

/* Spinner color */
.spinner .spinner-left:after, .spinner .spinner-right:after {
    border-color: #067aed !important;
}

/* Text input and select focus color */
input:not(.btn):focus, select:focus, textarea:focus {
    border-color: #067aed !important;
}

div.checkbox input[type=checkbox]:checked + label:before {
    border-color: #067aed !important; 
}

/* checkbox hover border color */
div.checkbox:hover input[type=checkbox]:not(:disabled) + label:before {
    border-color: #067aed !important;
}

/* checkbox checked background color */
div.checkbox input[type=checkbox]:checked + label:before {
    background-color: #067aed !important;
}

/* Purchase button background color */
.btn:not(.btn-secondary) {
    background-color: #067aed !important;
}

/* Purchase button hover, active, focus background color */
.btn:not(.btn-secondary):hover, .btn:not(.btn-secondary):active, 
.btn:not(.btn-secondary):focus {
    background-color: #04498e !important;
}
</style>
```

Changing any of the hex colours will alter the primary colours of your form, just make sure you leave the `:important!` rule after changes are made. If you're not sure which colour is right for you, find a list of available CSS colours [here](https://www.w3schools.com/cssref/css_colors.asp).

Your preferred colour should replace the first six listings, with a darker shade for when users are hovering for the final entry.

Feel free to add any additional styling information within the style tags.

## Custom header and footer

You can customize the header and footer of your form to display your own logo, company name, custom links etc.

From the **payment form** page under **configuration**, you can use our custom HTML fields **Page Header** and **Page Footer** to generate a UI that works with mobile screens.

Simply copy the code as it appears below into the **Page Header** field and update 'Merchant Name' to your own business. As well, update the image tag and text accordingly and change the example '.custom-header-footer' style to fit your web site design.

```html
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<title> { Merchant Name } - Payment Form </title> 

<link rel="stylesheet" type="text/css" href="https://libs.na.bambora.com/checkouttheme/0.1.0/ui.bambora/ui.bambora.1.1.0.css">
<link rel="stylesheet" type="text/css" href="https://libs.na.bambora.com/checkouttheme/0.1.0/style.css">

<style>
.custom-header-footer {
    background: #cddeef;
    box-shadow: 0 0 0px 2px rgba(3, 24, 199, 0.1);
    padding: 10px 15px;
    line-height: 2;
    margin-bottom: 40px;
    margin-top: 10px;
    text-align: center;
}
.custom-header-footer p {
    font-size: 25px;
    font-weight: 400;
}
</style>

</head>

<body>
<script src="https://libs.na.bambora.com/checkouttheme/0.1.0/checkouttheme.min.js"></script>  	
<script> CheckoutTheme.init(); </script>
<div class="custom-header-footer">
   <img src="https://cdn.na.bambora.com/resources/logos/bambora-logo180x92.png" alt="Your logo here">
   <p>Your company logo and name here</p>
</div>

```

Add this code to your **Page Footer** and you'll have a custom footer for your responsive pay form. 

```html
<div class="custom-header-footer">
   <p>Your footer message</p>
</div>

</body>
</html>
```
