---
title: Configure the form
layout: tutorial

summary: Checkout provides you with an easy-to-use way to process payments on your site.

navigation:
    header: na.tocs.na_nav_header
    footer: na.tocs.na_nav_footer
    toc: na.tocs.checkout_guide
    header_active: guides
---

# Configure the form
You can configure the form in the [Member Area](https://web.na.bambora.com). You can control what fields are displayed by default and how they are styled. You can also add a custom header and footer to the page. Click on **configuration**, and select **checkout** to find a list of title and form options.

## Layout
These settings control the default appearance of the form. They can be overridden by settings passed in the URL.

Note: The font and color settings in the Member Area have been deprecated. Font and color are now controlled by setting CSS

- **Transaction Type** - Choose between *Purchase* or *Pre-Authorization* as the default transaction type.
- **Include Billing Address** - Show billing address fields. This setting is secondary to the 'Billing address optional' setting in *Order Settings*
- **Include Shipping Address** - Show shipping address fields.
- **Allow Price Modification** - Show and allow the user to edit the amount.
- **Include Invoice/Order** - Show and allow the user to edit the invoice/order number.
- **Include Card Selection** - Allow the user to select their card brand. This field redundant. We recommend that it is excluded.
- **Include comments** - Show the comments text field.

Once you've finished customizing your form's fields, click **View Preview** at the bottom of the page to see your payment form. Click **Update Live** to confirm your changes and update your forms.

## Branding
You can brand Checkout by adding a custom header and footer to the html text boxes on the configuration page in the Member Area. Simply add the appropriate HTML and CSS blocks to the head and body of the page. In the example below we have added the minimal header that can be seen in our [demo](https://web.na.bambora.com/scripts/payment/payment.asp?merchant_id=300204468&trnAmount=10.00&hashValue=198b1de5fae8e1671bdf720cbbf292e15671dfaa).

```html
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Checkout</title>
    <link rel="stylesheet" type="text/css" href="https://libs.na.bambora.com/checkouttheme/0.1.0/ui.bambora/ui.bambora.1.1.0.css">
    <link rel="stylesheet" type="text/css" href="https://libs.na.bambora.com/checkouttheme/0.1.0/style.css">

    <style>
      header{
        margin-bottom: 40px;
        margin: 0 auto;
        width: 100%;
        max-width: 464px;
        border-bottom: 1px solid rgba(200, 200, 200, 1);
        display: flex;
        align-items: center;
        padding: 10px 20px;
        color: #9197a3;
        font-size: 20px;
        line-height: 32px;
        font-weight: 500;
        margin-bottom: 40px;
      }
    </style>

  </head>
  <body>
    <script src="https://libs.na.bambora.com/checkouttheme/0.1.0/checkouttheme.min.js"></script>  	
    <script>CheckoutTheme.init();</script>

    <header class="custom-header">
      <span>ACME Corp.</span>
    </header>
```
<div style="margin-bottom:24px;"></div>

### Colours

In addition to adding a custom header and footer, you can also set the form's colour scheme to match your brand. In the example below we have updated the colour scheme from shades of purple to shades of blue.

The first two blocks of CSS set the primary colour of the form. The third block sets a slightly darker color for the "Pay" button's hover and focus states.

```html
<style>
  .spinner .spinner-left:after, .spinner .spinner-right:after,
  input:not(.btn):focus, select:focus, textarea:focus,
  div.checkbox input[type=checkbox]:checked + label:before,
  div.checkbox:hover input[type=checkbox]:not(:disabled) + label:before {
    border-color: #067aed !important;
  }

  div.checkbox input[type=checkbox]:checked + label:before,
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
<div style="margin-bottom:24px;"></div>

## Redirect pages
By default, Checkout displays feedback on a transaction's success or failure to the user. You can override this behaviour by setting a custom redirect to bring the user back to your website after a transaction has been completed.

You can either pass redirect URLs as a GET parameters in the Checkout URL (see below), or you can set them in the [Member Area](https://web.na.bambora.com). Click **administration**, then **account settings**, and then **order settings**. Under **Transaction Response Pages**.

### Testing redirects
You may fined it helpful tools like [PutsReq](http://putsreq.com) helpful while testing.
