---
title: Address Verification
layout: tutorial

summary: >
    The Address Verification System (AVS), is a free tool that compares customer-submitted order information against bank databases.
    
navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: in-page
  header_active: References
---


# Address Verification System (AVS)
The [Address Verification System (AVS)][wikipedia-avs] is a system used to verify the address of a person claiming to own a credit card. The system will check the billing address of the credit card provided by the user with the address on file at the credit card company.

AVS is unable to verify all addresses as some cards may not have address information associated with them. AVS results are only returned after a transaction has completed processing. This means that a merchant must refund or void a high-risk transaction, rather than blocking it before completing the initial purchase.

You can configure your account in the [Back Office][back-office] to decline a transaction if either the street address or the postal codes do not match. Navigate to `Administration > Account Settings > Order Settings`.

AVS response codes are returned by the Payments API for purchases and pre-authorizations. You can read the payments API spec [here][beanstream-swagger]. They are also displayed in the transaction report in the [Back Office][back-office]. Navigate to `Reporting/Analysis > Transaction Report`. 

## AVS Response Codes

| ID      | Results  | Processed | Address Match | Postal/ZIP Match      | Message 														   |
| ------- | -------- | --------- | ------------- | --------------------- | --------------------------------------------------------------- |
| 0   	  | 0        | 0		 | 0	    	 | 0			         | Address Verification not performed for this transaction.   	   |
| 5   	  | 0        | 0		 | 0			 | 0			         | Invalid AVS Response. 										   |
| 9   	  | 0        | 0		 | 0			 | 0			         | Address Verification Data contains edit error. 				   |
| A   	  | 0        | 1		 | 1			 | 0			         | Street address matches, Postal/ZIP does not match. 		   	   |
| B   	  | 0        | 1		 | 1		     | 0			         | Street address matches, Postal/ZIP not verified. 			   |
| C   	  | 0        | 1		 | 0			 | 0			         | Street address and Postal/ZIP not verified. 					   |
| D   	  | 1        | 1		 | 1			 | 1			         | Street address and Postal/ZIP match. 						   |
| E   	  | 0        | 0		 | 0			 | 0			         | Transaction ineligible. 										   |
| G   	  | 0        | 0		 | 0			 | 0			         | Non AVS participant. Information not verified. 				   |
| I   	  | 0        | 0		 | 0			 | 0			         | Address information not verified for international transaction. |
| M   	  | 1        | 1		 | 1			 | 1			         | Street address and Postal/ZIP match. 						   |
| N   	  | 0        | 1		 | 0			 | 0			         | Street address and Postal/ZIP do not match. 					   |
| P   	  | 0        | 1		 | 0			 | 1			         | Postal/ZIP matches. Street address not verified. 			   |
| R   	  | 0        | 0		 | 0			 | 0			         | System unavailable or timeout. 								   |
| S   	  | 0        | 0		 | 0			 | 0			         | AVS not supported at this time. 								   |
| U   	  | 0        | 0		 | 0			 | 0			         | Address information is unavailable. 							   |
| W   	  | 0        | 1		 | 0			 | 1			         | Postal/ZIP matches, street address does not match. 			   |
| X   	  | 1        | 1		 | 1			 | 1			         | Street address and Postal/ZIP match. 						   |
| Y   	  | 1        | 1		 | 1			 | 1			         | Street address and Postal/ZIP match. 						   |
| Z   	  | 0        | 1		 | 0			 | 1			         | Postal/ZIP matches, street address does not match. 			   |

[wikipedia-avs]: https://en.wikipedia.org/wiki/Address_Verification_System
[back-office]: https://www.beanstream.com/admin/
[beanstream-swagger]: http://support.beanstream.com/restapi/