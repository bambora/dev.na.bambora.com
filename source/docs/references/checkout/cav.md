Notes: CAV to be fully documented at later date.

## CAV

| ID  | Description |
| --- | ----------- |
| 1 | The CAV request has successfully processed. |
| -1 | Service not configured for this merchant ID. Ensure that the merchant ID passed in the request XML message is correct. |
| -2 | Settings not configured for the passed merchant ID. Ensure that the merchant ID passed in the request XML message is correct. |
| -3 | Incorrectly formatted card number (e.g., insufficient number of digits in the credit card number). Ensure that the credit card number passed in the request XML message is correct. |
| -4 | Incorrectly formatted postal code. Ensure that the postal code passed in the request XML message is correct. |
| -5 | Incorrectly formatted social insurance number. Ensure that the SIN passed in the request XML message is correct. |
| -6 | Incorrectly formatted date of birth. Ensure that the DOB passed in the request XML message is correct. |
| -7 | Incorrectly formatted phone number (e.g. incorrect number of digits). Ensure that the phone number passed in the request XML message is correct. |
| -8 | Internal application error |
| -9 | Invalid merchant ID. Ensure that the merchant ID passed in the request XML message is correct. |
| -10 | Request has reached the limit on the number of CAV attempts against the card number. This CAV transaction limit is set in the membership area. See Configuration & Administration for details. |
| -11 | The CAV service is unavailable due to a communication failure to Equifax or due to Equifax temporarily declining CAV requests. The user should be requested to try their request again later. |
| -12 | Invalid passcode. Ensure that the passcode passed in the request XML message is correct. |
| -13 | Incorrectly formatted last name. This error occurs if the last name passed in the request XML message is missing or is less than 2 characters. |
| -14 | Missing XML message. Ensure that an XML request message was passed. |
| -15 | Could not parse the XML message. Ensure that the XML request message is valid XML. |
| -17 | Invalid eID transaction ID. |
| -18 | Invalid merchant account status. |
