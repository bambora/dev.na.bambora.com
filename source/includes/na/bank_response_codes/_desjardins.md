## Credit card responses
### Desjardins

| Message ID | Cardholder message | Merchant message |
| ---------- | ------------------ | ---------------- |
| 1001 | APPROVED | Approved with balance |
| 1002 | APPROVED | Approved without the balance |
| 1003 | APPROVED | Approved VIP |
| 1004 | APPROVED | Approved. Administrative Transaction |
| 1005 | DECLINED | Declined |
| 1006 | EXPIRED CARD | Declined. Expired card |
| 1007 | ADM PIN TRIES EXCEE | Declined. Max PIN attempts with an Administrative card reached |
| 1008 | INVALID CARD | Declined. The Admin card must be from the same institution as the POS |
| 1009 | SYSTEM NOT AVAIL. | Declined. The host cannot authorize the transaction at this time |
| 1010 | TRX NOT ALLOWED | Declined. The transaction type is invalid |
| 1011 | TRX NOT ALLOWED | Declined. The transaction type is not supported on this terminal |
| 1012 | DECLINED | Declined. The card status is lost or stolen |
| 1013 | DECLINED | Declined. The status of the card is unknown |
| 1014 | ACCOUNT NOT SET UP | Declined. The account used in the transaction is not defined |
| 1015 | PLEASE RETRY | Declined. Auth. type incorrectly defined. Host problem |
| 1016 | INVALID CARD | Declined. Track2 invalid |
| 1017 | PLEASE RETRY | Declined. Partial cancellations are not supported |
| 1018 | PLEASE RETRY | Declined. Invalid amount |
| 1019 | PLEASE RETRY | Declined. The transaction date is invalid. |
| 1020 | PLEASE RETRY | Declined. Transaction declined by the issuer |
| 1021 | PLEASE RETRY | Declined. Format error in the transaction |
| 1022 | PLEASE RETRY | Declined. Invalid acquirer institution |
| 1023 | PLEASE RETRY | Declined. Routing problem |
| 1024 | PLEASE RETRY | Declined. Routing problem |
| 1025 | PLEASE RETRY | Declined. Cannot authorize |
| 1026 | PLEASE RETRY | Declined. Invalid card number length |
| 1027 | DECLINED | Declined. Insufficient funds |
| 1028 | PLEASE RETRY | Declined. Preauthorization limit reached for the period |
| 1029 | DECLINED | Declined. Duplicate transaction |
| 1030 | PLEASE RETRY | 	Declined. Max online refund amount reached for a card for the period |
| 1031 | REFUND LIMIT | Declined. Max offline refund amount reached for a card for the period |
| 1032 | REFUND LIMIT | Declined. Max refund amount for a transaction |
| 1033 | OVER MAX NUMBER TRX | Declined. Max number of refunds reached for a card for the period |
| 1034 | PLEASE RETRY | Declined. Max refund amount reached for a card for the period |
| 1035 | NOT AVAILABLE | Declined. Balance inquiry transaction not permitted |
| 1036 | OVER MAX NUMBER TRX | Declined. Usage limit has been reached |
| 1037 | OVER MAX NUMBER TRX | Declined. The number of refunds for this card type has been reached |
| 1038 | PLEASE RETRY | Declined. Declined by the issuer |
| 1039 | DECLINED | Declined. Status of the card inactive |
| 1040 | HOLD CARD | Declined. Stolen card |
| 1041 | REFUND LIMIT | Declined. Limit in the no. of trans. or refund amount and Interac cancellations reached for the terminal |
| 1042 | PIN REQUIRED | Declined. The card PIN is required for this card (can be admin card) |
| 1043 | INVALID CARD | Declined. The check digit of the card number is invalid |
| 1044 | PLEASE RETRY | Declined. A forced transaction ended in error due to a system problem |
| 1045 | SYSTEM NOT AVAIL. | Declined. The authorization host is not available |
| 1046 | CALL FOR AUTH | Declined. The authorization host is not available |
| 1047 | CALL FOR AUTH | Declined. The authorization host is not available |
| 1048 | PLEASE RETRY | Declined. System error |
| 1049 | TRX NOT ALLOWED | Declined. Unsupported transaction |
| 1050 | CALL FOR AUTH | Declined. Maximum amount limit |
| 1051 | CALL FOR AUTH | Declined. Maximum amount limit for the day reached |
| 1052 | CALL SERVICE | Declined. Issuing host did not respond (timeout) |
| 1053 | CALL SERVICE | Declined. System error |
| 1054 | CALL SERVICE | Declined. System error |
| 1055 | CALL SERVICE | Declined. System error (admin card) |
| 1056 | CALL FOR AUTH | Declined. System error with security boxes |
| 1057 | CALL FOR AUTH | Declined. ARQC error |
| 1058 | CALL FOR AUTH | Declined. CVR error |
| 1059 | CALL FOR AUTH | Declined. TVR error |
| 1060 | CALL FOR AUTH | Declined. This message is an EMV referral - "fallback" |
| 1061 | RETAILER NOT FOUND | Declined. The merchant number is invalid |
| 1062 | PLEASE RETRY | Declined. Account type invalid. |
| 1063 | INVALID ADMIN PIN | Declined. The administrative PIN is invalid |
| 1064 | NEED ADMIN CARD | Declined. Admin card required. Currently only validated for admin PIN change transactions |
| 1065 | CALL SERVICE | Declined. The amount of the transaction is too high |
| 1066 | CARD NOT SET UP | Declined. The card is not set up in the acquirer's host (POS) |
| 1067 | CALL SERVICE | Declined. The transaction date is invalid |
| 1068 | INVALID DATE | Declined. The expiry date of the card is invalid |
| 1069 | CALL SERVICE | Declined. Transaction code invalid |
| 1070 | DECLINED | Declined. Transaction amount exceeds the allowable limit |
| 1071 | DECLINED | Declined. EMV - ARQC invalid |
| 1072 | DECLINED | Declined. EMV - Error with the security box |
| 1073 | DECLINED | Declined. EMV - Error with the security box |
| 1074 | DECLINED | Declined. EMV - Key cannot be found in the security module |
| 1075 | DECLINED | Declined. EMV - ATC error |
| 1076 | DECLINED | Declined. EMV - CVR error |
| 1077 | DECLINED | Declined. EMV - TVR error |
| 1078 | DECLINED | Declined. EMV - Transaction in fallback |
| 1079 | INVALID PROGRAM | Declined. PPC - The selected program is inactive |
| 1080 | TRX NOT ALLOWED | Declined. PPC - The merchant does not have access to the transaction program |
| 1081 | INC. AMOUNT/CARD | Declined. PPC - Amount differs from the program |
| 1082 | INVALID AMOUNT | 	Declined. PPC - The amount does not correspond with the program |
| 1083 | DECLINED | Declined. PPC - Activation correction impossible |
| 1084 | DECLINED | Declined. PPC - amount of the transaction higher than the starting amount |
| 1085 | ALREADY ACTIVE | 	Declined. PPC - card already activated |
| 1086 | INSUFF. FUNDS | Declined. PPC - Insufficient funds |
| 1087 | INVALID CARD | Declined. PPC - Invalid card |
| 1088 | FORMAT ERROR | Declined. Error in the format of the transaction |
| 1089 | FORMAT ERROR | Declined. Error in the contents of a field in the transaction |
| 1090 | FORMAT ERROR | Declined. Error in Batch Close |
| 1091 | PLEASE RETRY | Declined. Desjardins acquirer system timeout |
| 1092 | FORMAT ERROR | Declined. Error in the Desjardins host acquirer system |
| 1093 | TERMINAL DEACTIVATED | Declined. The terminal is deactivated at the Desjardins acquirer host |
| 1094 | FORMAT ERROR | Declined. The transaction is invalid. The response sent by the host only contains a header. |
| 1095 | INVALID PIN LENGTH | Declined. PIN length invalid |
| 1096 | PLEASE RETRY | Declined. Cardholder card data decrypting error. |
| 1097 | PLEASE RETRY | Declined. MAC error |
| 1098 | CALL SERVICE | Declined. Sequence number (see header) is invalid |
| 1099 | PIN TRIES EXCEEDED | Declined. Number of PIN attempts exceeded |
| 1100 | EXPIRED CARD | Declined. Expired card |
| 1101 | HOLD CARD | Declined. Card probably fraudulent. |
| 1102 | HOLD CARD | Declined. Stolen card |
| 1103 | INVALID AMOUNT | Declined. Invalid amount |
| 1104 | PLEASE RETRY | Declined. Invalid card |
| 1105 | HOLD CARD | Declined. Card probably fraudulent. |
| 1106 | PLEASE RETRY | Declined. Limit exceeded |
| 1107 | HOLD CARD | Declined. Amount exceeds the limit |
| 1108 | HOLD CARD | Declined. Retain card |
| 1109 | DECLINED | Declined. EMV - ARQC error |
| 1110 | DECLINED | Declined. EMV - CVR error |
| 1111 | DECLINED | Declined. EMV - TVR error |
| 1112 | UNABLE TO PROCESS | Declined. Error in the tax calculation |
| 1113 | CANCELLATION LIMITÂ | Declined. Daily Interac cancellation limit reached |
| 1114 | KEY CHANGE REQUIRED | Declined. First transaction for a terminal must be a transaction code 96 |
| 1115 | CARD NOT SUPPORTED | Declined. |
| 1116 | SELECT OTHER ACCT | Declined. Inactive Desjardins Interac account |
| 1117 | CARD NOT SET UP | Declined. Inactive Desjardins Interac card |
| 1118 | DECLINED | Declined. Desjardins Interac card, insufficient funds |
| 1119 | NOT ALLOWED | Declined. Transaction not allowed |
| 1120 | INVALID PIN | Declined. Incorrect PIN |
| 1121 | DECLINED | Declined. PIN Required. The card must be inserted into the chip reader. |
| 1122 | ADM PIN NOT IN FILE | Declined. Unrecognized administrative card |
| 1123 | PIN CHG NOT ALLOWED | Declined. This Admin card cannot be used to change the PIN |
| 1124 | SYSTEM NOT AVAIL. | Declined. Desjardins Interac issuing host unavailable |
| 1125 | DECLINED | Declined. Requires caisse authorization |
| 1126 | ACCOUNT NOT SET UP | Declined. Non-existent account |
| 1127 | CARD NOT SUPPORTED | Declined. Caisse (branch) does not exist |
| 1128 | CARD NOT SET UP | Declined. Card inactive at the Desjardins Interac issuing host |
| 1129 | SELECT OTHER ACCT | Declined. Account does not exist |
| 1130 | DECLINED | Declined. Amount exceeds the allowable limit |
| 1131 | CARD NOT SET UP | Declined. Account does not exist |
| 1132 | Invalid Accord D Transaction | Invalid Accord D Transaction |
| 1133 | Accord D transaction cannot be processed as recurring. | Accord D transaction cannot be processed as recurring. |
