## AVS response codes

| ID  | Results | Processed | Address Match | Postal/ZIP Match | Message |
| --- | ------- | --------- | ------------- | ---------------- | ------- |
| 0 | 0 | 0 | 0 | 0 | Address Verification not performed for this transaction. |
| 5 | 0 | 0 | 0 | 0 | Invalid AVS Response. |
| 9 | 0 | 0 | 0 | 0 | Address Verification Data contains edit error. |
| A | 0 | 1 | 1 | 0 | Street address matches, Postal/ZIP does not match. |
| B | 0 | 1 | 1 | 0 | Street address matches, Postal/ZIP not verified. |
| C | 0 | 1 | 0 | 0 | Street address and Postal/ZIP not verified. |
| D | 1 | 1 | 1 | 1 | Street address and Postal/ZIP match. |
| E | 0 | 0 | 0 | 0 | Transaction ineligible. |
| G | 0 | 0 | 0 | 0 | Non AVS participant. Information not verified. |
| I | 0 | 0 | 0 | 0 | Address information not verified for international transaction. |
| M | 1 | 1 | 1 | 1 | Street address and Postal/ZIP match. |
| N | 0 | 1 | 0 | 0 | Street address and Postal/ZIP do not match.  |
| P | 0 | 1 | 0 | 1 | Postal/ZIP matches. Street address not verified. |
| R | 0 | 0 | 0 | 0 | System unavailable or timeout. |
| S | 0 | 0 | 0 | 0 | AVS not supported at this time. |
| U | 0 | 0 | 0 | 0 | Address information is unavailable. |
| W | 0 | 1 | 0 | 1 | Postal/ZIP matches, street address does not match. |
| X | 1 | 1 | 1 | 1 | Street address and Postal/ZIP match. |
| Y | 1 | 1 | 1 | 1 | Street address and Postal/ZIP match. |
| Z | 0 | 1 | 0 | 1 | Postal/ZIP matches, street address does not match. |
