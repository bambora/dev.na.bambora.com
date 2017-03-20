---
title: Apple Pay
layout: tutorial

summary: >
    The Payments API now exposes our new 'apple_pay' payment method and associated parameters to accept a base 64 encoded Apple Pay Payment Token.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: false
  header_active: Guides
---

# Apple Pay

**Apple with Beanstream is currently in a close Beta trial period. Contact your account manager if you would like early access.**

The Payments API now exposes our new 'apple_pay' payment method and associated parameters to accept a base 64 encoded Apple Pay Payment Token.

Various resources exist to let you find out more about the Payments API in general. Learn how to [Take Payments](/docs/references/payments_SDKs/take_payments/) and for our REST API refer to the [Swagger doc](/docs/references/merchant_API/v1-0-2). Also, we highly recommend you understand how to deal with our [API Passcode Authentication protocol](/docs/guides/merchant_quickstart/) as it is used in the demo server app that is mentioned later in this document.


## Example Request

An example Payments API request is shown below with a JSON formatted parameter to pass to the https://api.beanstream.com/api/v1/payments RESTful interface.


```shell
  curl https://api.beanstream.com/api/v1/payments \
    -H "Authorization: Passcode XXX1XXx11Xxx1xX1XxxxXxXXXXx1XXX1XxX1XXXxXXXxXxxxX11XXXxX1" \
    -H "Content-Type: application/json" \
    -d '{
          "amount": 1.00,
          "payment_method": "apple_pay",
          "apple_pay": {
            "apple_pay_merchant_id": "<your_apple_pay_merchant_id>",
            "payment_token": "<apple_pay_base64_encoded_token>",
            "complete": true
          }
        }'
```

*The ‘complete’ property defaults to true if omitted. True indicates a Purchase or when set to false indicates a Pre-Auth.*

## Getting Started

Sample code on Github has been provided to help mobile app and backend server-side developers with your production level apps. We have simple demo client & server apps for you to inspect and follow (as a starting example), with the hope that these samples help bootstrap your implementations.

Click to view code samples on the [Mobile Payments Demo Github](https://github.com/Beanstream/mobilepayments-demo) repository.

To enable Apple Pay on your Beanstream Merchant account you need to know your Beanstream Merchant ID and use, or create, a Passcode for your account. When you log in to your Beanstream account, you will know if you can enable Apple Pay transactions if you see a mobile payments menu item, as shown below. If the mobile payments menu item does not appear, your Beanstream account is not enabled for Apple Pay.

<img src="/docs/guides/apple_pay/mobile-payments-screenshot.png" alt="mobile-payments-screenshot">

In your Beanstream account, click **configuration**, then **mobile payments**. This is where you can tell us about your app’s Apple Pay Merchant Id, and also upload your Apple Pay signing certificate from the **.p12** formatted file.

You also need to enable Apple Pay in your iOS apps. To do that you can follow Apple’s superb documentation!

* [Getting Started with Apple Pay](https://developer.apple.com/apple-pay/get-started/)
* [Apple Pay Programming Guide](https://developer.apple.com/library/content/ApplePay_Guide/)
* [Apple Pay Sandbox Testing](https://developer.apple.com/support/apple-pay-sandbox/)

## More Examples

### Payment Button Action

This is an example payment button action for iOS in Swift. Note that Beanstream allows payments that use **.capability3DS** (3D Secure), with Visa, MasterCard, and American Express as the currently supported card types.

```swift
func paymentButtonAction() {
    // Create a payment request
    let request = PKPaymentRequest()
    
    request.merchantIdentifier = "merchant.com.mycompany.myapp"
    request.supportedNetworks = [.visa, .masterCard, .amex]
    request.merchantCapabilities = .capability3DS
    
    // Use a currency set to match your Beanstream Merchant Account
    request.countryCode = "CA" // "US"
    request.currencyCode = "CAD" // "USD"
    
    request.paymentSummaryItems = [
        PKPaymentSummaryItem(label: "1 Golden Egg", amount: NSDecimalNumber(string: "1.00"), type: .final),
        PKPaymentSummaryItem(label: "Shipping", amount: NSDecimalNumber(string: "0.05"), type: .final),
        PKPaymentSummaryItem(label: "GST Tax", amount: NSDecimalNumber(string: "0.07"), type: .final),
        PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "1.12"), type: .final)
    ]
    
    self.paymentAmount = NSDecimalNumber(string: "1.12")
    
    let authVC = PKPaymentAuthorizationViewController(paymentRequest: request)
    authVC.delegate = self
    present(authVC, animated: true, completion: nil)
}
```

### Issue Payment Token

After a user successfully authorizes the above payment request, you then handle the issuing of a payment token as follows. Note that the iOS client below is sending the payment token to our Mobile Payments Demo Server, mentioned previously in this post.

```swift
// Executes a process payment request on the Mobile Payments Demo Server
func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                        didAuthorizePayment payment: PKPayment,
                                        completion: @escaping (PKPaymentAuthorizationStatus) -&gt; Void) {
    // Get payment data from the token and base64 encode it
    let token = payment.token
    let paymentData = token.paymentData
    let b64TokenStr = paymentData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    let transactionType = self.purchaseTypeSegmentedControl.selectedSegmentIndex == 0 ? "purchase" : "pre-auth"
    let parameters = [
        "amount": self.paymentAmount,
        "transaction-type": transactionType,
        "apple-wallet": [
            "payment-token": b64TokenStr,
            "apple-pay-merchant-id": "merchant.com.mycompany.myapp"
        ]
    ] as [String : Any]

    Alamofire.request(DemoServerURLBase + "/process-payment/apple-pay",
                      method: .post,
                      parameters: parameters,
                      encoding: URLEncoding.httpBody).responseJSON { response in

        let statusCode = response.response?.statusCode
                    
        if statusCode == 200 {
            completion(.success)
        }
        else {
            completion(.failure)
        }
    }
}
```

