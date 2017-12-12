---
title: Custom Checkout Reference
layout: tutorial

summary: >
  A full API reference for Custom Checkout.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.custom_checkout
  header_active: References

---

# Custom Checkout Reference

### customcheckout.create

`customcheckout.create(type[, options])`

Creates an input of *type*  and passes the optional specified *options* to it. Returns a field object.

| Argument       | Type   | Description                                                         |
|----------------|--------|---------------------------------------------------------------------|
| *type*         | String | The type of field to create. Can be `'card-number'`, `'cvv'`, or `'expiry'`. |
| *options*      | Object | Optional options object that can be specified for the field.             |

```javascript
var options = { ... };
var cardNumber = customCheckout().create('card-number', options);
```

#### options

| Parameter          | Type   | Description                                  |
|--------------------|--------|----------------------------------------------|
| `placeholder`      | String | A placeholder value for the input field.     |
| `style`            | Object | Style information for the field.             |
| `classes`          | Object | Custom classes to be applied to the wrapper. |
| `brands`           | Array  | Only pass to card-number input. Value is an array of supported card brands, all other brands will be treated as invalid. If not passed in, all brands are accepted. Can be `'amex'`, `'diners'`, `'discover'`, `'jcb'`, `'mastercard'`, `'visa'`, or `'maestro'`. |

Note: The `style` property affects the remote styling of text inside the iframe input. The `classes` property updates the class list of the element the field is mounted to on your page.

#### options.style

| Parameter        | Type   | Description                                     |
|------------------|--------|-------------------------------------------------|
| `base`           | Object | Default styles to be applied to the input.      |
| `complete`       | Object | Styles to be applied when the input is valid.   |
| `empty`          | Object | Styles to be applied when the input is empty.   |
| `error`          | Object | Styles to be applied when the input is invalid. |

The following CSS properties can be set on the objects set on the style object:

* `color`
* `fontFamily`
* `fontSize`
* `fontStyle`
* `fontWeight`
* `textDecoration`
* `padding`, `paddingLeft`, `paddingTop`, `paddingRight`, and `paddingBottom`

As well as these pseudo-classes:

* `:hover`
* `:focus`

#### options.classes

| Parameter  | Type   | Description                                                                           |
|--------------------|--------|---------------------------------------------------------------------------------------|
| `base`             | String | Base class applied to the wrapper. Defaults to `bambora-checkoutfield`.               |
| `complete`         | String | Class to apply when input is complete. Defaults to `bambora-checkoutfield-complete`.  |
| `empty`            | String | Class to apply when input is empty. Defaults to `bambora-checkoutfield-empty`.        |
| `focus`            | String | Class to apply when input has focus. Defaults to `bambora-checkoutfield-focus`.       |
| `error`            | String | Class to apply when input is in error. Defaults to `bambora-checkoutfield-error`.     |

```javascript
// Styles to be applied to the text in the iframe when it changes state.
var style = {
  error: {
    color: 'red',
    ':focus': {
      fontStyle: 'italic',
    },
  },
};

// Classes to be applied to the element wrapping the iframe
// when it changes state.
var classes = {
  error: 'my-error-class',        
};

var options = {
  placeholder: 'Card number',
  style: style,
  classes: classes,
};

var cardNumber = customCheckout.create('card-number', options);
```

### customcheckout.mount

`checkoutObject.mount(cssSelector)`

Mounts the custom input inside an element on the page identified by *cssSelector*. Returns an error if *cssSelector* is not found.  

| Argument         | Type     | Description              |
|------------------|----------|--------------------------|
| *cssSelector* | *String* | CSS selector of your parent element. |

```html
<script src='https://libs.na.bambora.com/customcheckout/1/customcheckout.js'></script>
<form id="checkout-form">
    <div id="card-number"></div>
    <div id="card-cvv"></div>
    <div id="card-expiry"></div>
    ...
</form>

<script>
    var customCheckout = customcheckout();
    var cardNumber = customCheckout.create('card-number')
    cardNumber.mount('#card-number');
</script>
```

### customcheckout.on

`customcheckout.on(event, callback)`

Adds an event listener to Custom Checkout.

| Argument       | Type       | Description                          |
|----------------|------------|--------------------------------------|
| *event*        | *String*   | The name of the event to listen for. |
| *callback*     | *Function* | The function to be run when the event is triggered. |

#### event

| Event        | Trigger                                   |
|--------------|-------------------------------------------|
| `blur`       | Input loses focus.                        |
| `focus`      | Input gains focus.                        |
| `empty`      | Input switches to or from an empty state. |
| `complete`   | Input becomes complete and valid.         |  
| `brand`      | Card brand changes.                       |
| `error`      | Input becomes invalid.                    |


| Event | Trigger                                                             | Event argument for callback |
|----------------|-------------------------------------------------------------------------|------------------------------|
| `blur`       | Input loses focus.                                    | `{ field: 'card-number cvv expiry' }` |
| `focus`      | Input gains focus.                                    | `{ field: 'card-number cvv expiry' }` |
| `empty`      | Input switches to or from an empty state.             | `{ field: 'card-number cvv expiry', empty: 'true false' }` |
| `complete`   | Input becomes complete and valid.         | `{ field: 'card-number cvv expiry', complete: 'true false' }`    |
| `brand`      | Card brand changes.                                  | `{ field: 'card-number', brand: 'amex diners discover jcb mastercard visa maestro' }` |
| `error`      | Input becomes invalid.           | `{ field: 'card-number cvv expiry', type: 'See below for a list of error types.',  message: 'A descriptive error message.' }` |

```javascript
customCheckout.on('blur', function(event) {
  console.log('blur: ' + JSON.stringify(event));
  //...
});
```

#### error.type

***Input Validation***

* `CardNumberInvalid`
* `CvvNotSet`
* `ExpiryIsInThePast`
* `ExpiryIsNotSet`

***Tokenization***

* `TokenizationValidationFailed`
* `TokenizationFailed`
* `TokenizationNoResponse`


### customcheckout.createToken

`customcheckout.createToken(callback)`

Validate and create a payment token from the input values. This token can then be used to process a payment using our Payments API.

| Argument       | Type       | Description                          |
|----------------|------------|--------------------------------------|
| *callback*     | *Function* | The function to be run when the event is triggered. |

```javascript
customCheckout.createToken(function(result) {
    // handle result.error or result.token
});
```

| callback event property | Type   | Description                                         |
|-------------------------|--------|-----------------------------------------------------|
| `code`                  | String | The HTTP status code of the tokenization request.   |
| `error`                 | Object | `{field: 'token', type: 'See below for a list of error types.', message: 'A descriptive error message.' }`    |
| `token`                 | String | Only present if no error. The payment token result. |
| `last4`                 | String | Only present if no error. The last 4 digits of the card number. |
| `expiryMonth`           | String | Only present if no error. The expiry month of the card.         |
| `expiryYear`            | String | Only present if no error. The expiry year of the card.          |

### input.update

`input.update(options)`

Updates an input instance with the specified *options*. Any previously set options will be lost.

| Argument       | Type   | Description                                                         |
|----------------|--------|---------------------------------------------------------------------|
| *options*      | Object | Optional options object that can be specified for the field.             |

```javascript
var options = { ... };
var cardNumber = customCheckout().create('card-number', options);

options = { ... };
cardNumber.update(options);
```

### input.focus

`input.focus()`

Requests to gain focus on a given input.

```javascript
cardNumber.focus();
```

### input.blur

`input.blur()`

Requests to lose focus from a given input.

```javascript
cardNumber.blur();
```

### input.clear

`input.clear()`

Removes any text entered from a given input.

```javascript
cardNumber.clear();
```

### input.unmount

`input.unmount()`

Removes a given input from the DOM.

```javascript
cardNumber.unmount();
```
