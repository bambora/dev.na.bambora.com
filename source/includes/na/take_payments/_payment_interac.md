## Interac Online  

```shell
Definition
POST /v1/payments HTTP/1.1

Request
curl https://api.na.bambora.com/v1/payments
-H "Authorization: Passcode MzAwMjAwNTc4OjRCYU..."
-H "Content-Type: application/json"
-d '{
      "order_number":"MyOrderId-01234",
      "amount":100.00,
      "payment_method":"interac"     
    }'
```

Interac Online is a transaction method available to Canadian merchants only. It allows customers to authenticate direct debits without sharing their debit card details with the merchant.

See [here](/docs/guides/interac_online) for more information on how to implement Interac Online.
