---
title: Custom Checkout Setup
layout: tutorial

summary: >
  Get up and running with Custom Checkout in three steps.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.custom_checkout
  header_active: Guides

---

# Setup

A payment with Custom Checkout involves 3 steps:

1. Configure Custom Checkout in your client
2. Create a token through Custom Checkout
3. Create a payment by passing the token to our Payment API via your server

## Step 1: Configure Custom Checkout

**First**, include and initialize Custom Checkout.

```html
<script src='https://libs.na.bambora.com/customcheckout/1/customcheckout.js'></script>

<script>
    var customCheckout = customcheckout();
</script>
```

**Second**, create and mount the inputs. Mount the custom input to the HTML element using its CSS selector.

```html
<!-- ... -->
<form id="checkout-form">
    <div id="card-number"></div>
    <div id="card-cvv"></div>
    <div id="card-expiry"></div>
    <!-- ... -->
</form>

<script>
    var customCheckout = customcheckout();
    var cardNumber = customCheckout.create('card-number')
    cardNumber.mount('#card-number');
    // ...
</script>
<!-- ... -->
```

You can add styling to the inputs when passing the `options` argument to `customcheckout.create()`.

```javascript
// Styles to be applied to the text rendered in the iframe
var style = {
  error: {
    color: 'red',
    ':focus': {
      fontStyle: 'italic',
    },
  },
};

// Classes to be applied to the element wrapping the iframe
var classes = {
  error: 'my-error-class',        
};

var options = {
  placeholder: 'Card number',
  style: style,
  classes: classes,
  brands: ['visa', 'mastercard'],
};

var cardNumber = customCheckout.create('card-number', options);
```

**Third**, add an event listener so that you can handle validation errors.

```javascript
customCheckout.on('error', function(event) {
    if (event.field === 'card-number') {
      console.log('Card number has errors: ' + JSON.stringify(event));
    } else if (event.field === 'cvv') {
      console.log('CVV has errors: ' + JSON.stringify(event));
    } else if (event.field === 'expiry') {
      console.log('Expiry has errors: ' + JSON.stringify(event));
    }
});

customCheckout.on('complete', function(event) {
    if (event.field === 'card-number') {
      console.log('Card number is complete: ' + JSON.stringify(event));
    } else if (event.field === 'cvv') {
      console.log('CVV is complete: ' + JSON.stringify(event));
    } else if (event.field === 'expiry') {
      console.log('Expiry is complete: ' + JSON.stringify(event));
    }
});
```

## Step 2: Create a token

You request a token for the card data in the Custom Checkout text inputs at any time using `customCheckout.createToken`. It will only return a token if the card data is valid, otherwise it will return an error.

The token returned is a nonce. It expires on-use or after 15 minutes.

```javascript
customCheckout.createToken(function (result) {
  if (result.error) {
    console.log(result.error.message);
    // display error message
  } else {
    console.log(result.token);
    // process token using our Payments API
  }
});
```

## Step 3: Create a payment

Once you have a token representing credit card data, the next step is to pass to one of our APIs via your server. You can either pass it to the [Payment API](/docs/references/payment_APIs/) to create a payment immediately, or pass it to the [Payment Profile API](/docs/references/payment_APIs/) to save the card data for future payments.

You can find out more about getting up-and-running with our APIs [here](/docs/guides/merchant_quickstart/).
