## Отмена/возврат оплаты

Запрос отмены оплаты.

#### Атрибуты запроса

+ **amount** `number` - Сумма к возврату, в копейках `Необходимое`
+ **operationId** `string` - Идентификатор операции, формируемый клиентом `Необходимое`
+ **accountId** `string` - Идентификатор аккаунта в МС `Необходимое`
+ **retailStoreId** `string` - Идентификатор точки продаж в МС `Необходимое`

> **`POST`**
> /payment/cancel

> **Request**

> Headers

```
Content-Type:application/json
Authorization:Bearer <токен>
```

> Body

```json
{
  "amount": 100,
  "operationId": "3ce94dac-5584-464a-9a03-194b799341bc",
  "accountId": "3066cc26-67ca-11f0-0a83-147100000002",
  "retailStoreId": "3238f1cc-67ca-11f0-0a80-0383000000be"
}
```

> **Response**  
> 200 (application/json)

