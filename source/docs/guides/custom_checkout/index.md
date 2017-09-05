---
title: Custom Checkout
layout: tutorial

summary: >
  Create a fully customizable payment form while minimizing the scope of your PCI compliance.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.custom_checkout
  header_active: Guides

---

# Custom Checkout

Custom Checkout minimizes the scope of your PCI compliance - limiting it to SAQ A. It does this by isolating credit card data from your servers. It serves card input fields from Bambora’s domain, not yours, while rendering them within iframes on your web page.

## Demo
Here is an example of a custom payment form styled with Bootstrap. Custom Checkout can be styled any way you choose. Try it out!

You can use using the test card number 4030 0000 1000 1234, with a security code 123 and any expiry date in the future.

<div style="margin-bottom:24px;">
<p data-height="177" data-theme-id="light" data-slug-hash="OgbOKP" data-default-tab="result" data-user="na-bambora" data-embed-version="2" data-pen-title="CustomCheckout-Bootstrap" class="codepen">See the Pen <a href="https://codepen.io/na-bambora/pen/OgbOKP/">CustomCheckout-Bootstrap</a> by na-bambora (<a href="https://codepen.io/na-bambora">@na-bambora</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>
</div>

See [more examples](/docs/guides/custom_checkout/demos/) of styled Custom Checkout. See a [demo](https://libs.na.bambora.com/customcheckout/1.0.0/demo.html?source=production) of Custom Checkout’s eventing. See a [demo](https://demo.na.bambora.com) of a complete payment flow Custom Checkout.

## Custom Checkout vs Checkout

Checkout is an alternative to building your own payment form with Custom Checkout.

* Both solutions are PCI SAQ A compliant.
* Checkout is a payment form - it creates sale and pre-auth transactions. Custom Checkout is a tokenizaton library - it returns a token that you use when creating transactions via the Payment API.
* Checkout involves redirecting the user to a payment form on bambora.com. Custom Checkout embeds Bambora hosted input fields in your webpage.
* Checkout is brandable - you can set the primary color, a custom header and a custom footer. Custom Checkout allows you to build a fully customized payment form - you retain as much control over UI/UX as you do with native DOM elements.

## Migration

Custom Checkout replaces our legacy Payfields/CheckoutFields, Payform and Legato scripts. These, along with direct posts to our Token API, are classified as SAQ A-EP solutions.

The token returned by Custom Checkout is identical to that returned by these other scripts. This means you can easily migrate to Custom Checkout by switching out the scripts on the client-side while leaving your server-side integration unchanged.

## Browser support

These are the browsers we actively test.

### Desktop
* Chrome latest
* Firefox latest
* Internet Explorer 9+
* Microsoft Edge
* Safari 8+

### iOS
* Safari 8+
* Chrome 48+ (iOS 9+)

### Android
* Native browser 4.4+
* Chrome
* Firefox
