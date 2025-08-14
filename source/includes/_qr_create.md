## Создать QR-код

Запрос на создание нового QR-кода.

#### Атрибуты запроса

+ **amount** `number` - Сумма к оплате за покупку, в копейках `Необходимое`
+ **operationId** `string` - Идентификатор операции, формируемый клиентом `Необходимое`
+ **accountId** `string` - Идентификатор аккаунта в МС `Необходимое`
+ **retailStoreId** `string` - Идентификатор точки продаж в МС `Необходимое`

#### Атрибуты ответа

+ **operationId** `string` - Идентификатор операции, формируемый клиентом `Необходимое`
+ **data** `string` - Данные, которые будут отображены в виде QR-кода на кассе `Необходимое`

> **`POST`**
> /payment/qr

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

> Body

```json
{
  "operationId": "f1c50d66-55b9-4448-a617-e030ff3e9bd1",
  "data": "https://qr.nspk.ru/BD1000140UGULHTI8TFB015KNF1ORSCR?type=02&bank=100000000004&sum=20000&cur=RUB&crc=C736"
}

```

