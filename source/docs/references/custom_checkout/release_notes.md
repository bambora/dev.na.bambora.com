---
title: Custom Checkout Release Notes
layout: tutorial

summary: >
  Release notes for Custom Checkout.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.custom_checkout
  header_active: References
---

# Custom Checkout Release Notes

## 1.0.1

**September 11, 2017**

- Update the library url to support using only the MAJOR version to get the latest backwards compatible changes.
- Properly load iFrames when non-Custom Checkout iFrames are included within the same page

## 1.0.0

**August 15, 2017**

- The injected inputs now have a transparent background. This allows for changing the color of the input by changing the background color of the div it is mounted to. 
- The library now behaves correctly in IE 9, 10, and 11. 
- The 404 page for library files no longer redirects to web.na.bambora.com after a timeout. 
- Autofill of credit card information now behaves correctly in browsers that support it.
- Validation error types have been simplified. See the [documentation](/docs/references/custom_checkout/#error-type) for the updated list.
- Added the following new methods to input objects:
  - `input.unmount()`: remove an input from the DOM
  - `input.update()`: update the options passed to an input
  - `input.focus()`: give focus to the input
  - `input.blur()`: remove focus from the input
  - `input.clear()`: reset the value of the input

## 0.1.1

**August 1, 2017** 

- A hash in the URL of a page integrating custom checkout will no longer break integration.
- Firefox and IE no longer require two tabs to switch between fields.
- Padding is now a supported property in the style options. This can be used to increase the selectable area of the inputs.

---

## 0.1.0

**June 26, 2017**

- Alpha release of Custom Checkout.
