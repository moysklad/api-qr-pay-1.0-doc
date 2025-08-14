# МойСклад QrPay API

В приложении Касса Мойсклад можно оплатить покупки по QR-коду. Оплата по QR-коду может быть через эквайринговый
pos-терминал, а может быть с помощью решения в Каталоге решений МоегоСклада.

Под QR оплатой понимается любой способ оплаты на кассе, для оплаты которого покупателю необходимо отсканировать QR-код и
оплатить по ссылке. Например, СБП, сервисы оплаты по QR (Плати QR, Мульти QR) и любые другие.

Мы предоставляем публичное **API QrPay**, которое позволяет реализовать второй вариант оплаты по QR. Через API
веб-приложение МойСклад сможет запрашивать данные для оплаты у решения. Решение будет обращаться в платёжный сервис
через его API.

## Путь пользователя

1. Администратор аккаунта устанавливает решение для оплаты по QR в Каталоге решений.
2. Включает на Точке продаж оплату по QR.
3. Настраивает решение (Если необходимо, указывает логины, пароли, токены и другие идентификаторы для взаимодействия с
   платежным сервисом).
4. Продавец на кассе вызывает данный способ оплаты.
5. Касса посылает запрос на генерацию QR-кода по API в МойСклад.
6. МойСклад передает запрос в установленное Решение.
7. Решение передает запрос в платежный сервис.
8. Далее в обратном порядке QR-код передает на кассу.
9. Клиент сканирует QR-код, оплачивает.
10. Касса получает статус, что оплата прошла, далее фискализирует чек.

## Как поддержать интеграцию

Подключение оплаты по QR-коду в сервисе МойСклад происходит через решение, которое необходимо разработать и опубликовать
в нашем каталоге решений. Для этого вам нужно:

1. Получить доступ
   к [Личному кабинету разработчика](https://dev.moysklad.ru/doc/api/vendor/1.0/#lichnyj-kabinet-razrabotchika).
2. Создать черновик [серверного решения](https://dev.moysklad.ru/doc/api/vendor/1.0/#serwernye-resheniq) с указанием
   блока `<qrPayApi/>` в [дескрипторе](https://dev.moysklad.ru/doc/api/vendor/1.0/#deskriptor-resheniq).
3. Используя эту документацию имплементировать QrPay API на сервере.
4. Протестировать и отправить решение на публикацию.

### Как заполнить дескриптор

В [дескрипторе](https://dev.moysklad.ru/doc/api/vendor/1.0/#deskriptor-resheniq) решения нужно указать блок
`<qrPayApi/>`, который представляет собой массив элементов `</paymentProvider>`.

**Важно:** В дескрипторе можно указать больше одного элемента `paymentProvider`, но в данный момент запросы будут
осуществляться только по первому элементу.

#### Аттрибуты `paymentProvider`

+ **name** `string` - Название способа оплаты `Необходимое`
+ **qrType**, `enum[string]` - Тип QR-кода `Необходимое`
+ **endpointBase** `string` - Базовый URL на стороне разработчика с имплементацией QrPay API `Необходимое`

#### Возможные значения `qrType`

| Значение                     | Поддерживается | Описание                                                      |
|------------------------------|----------------|---------------------------------------------------------------|
| `MERCHANT_GENERATED_DYNAMIC` | Да             | QR-код создаётся на каждую операцию                           |
| `MERCHANT_GENERATED_STATIC`  | Нет            | Статический QR-код                                            |
| `CUSTOMER_GENERATED`         | Нет            | QR-код, который показывает покупатель, продавец его сканирует |

> **Пример заполнения дескриптора**

```xml

<ServerApplication xmlns="https://apps-api.moysklad.ru/xml/ns/appstore/app/v2"
                   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                   xsi:schemaLocation="https://apps-api.moysklad.ru/xml/ns/appstore/app/v2
      https://apps-api.moysklad.ru/xml/ns/appstore/app/v2/application-v2.xsd">
  <vendorApi>
    <endpointBase>https://example.com/dummy-app</endpointBase>
  </vendorApi>
  <qrPayApi>
    <paymentProvider>
      <name>Some vendor's first payment provider</name>
      <qrType>MERCHANT_GENERATED_DYNAMIC</qrType>
      <endpointBase>https://some-vendor.ru/api/1/root</endpointBase>
    </paymentProvider>
    <paymentProvider>
      <name>Some vendor's second payment provider</name>
      <qrType>MERCHANT_GENERATED_DYNAMIC</qrType>
      <endpointBase>https://some-vendor.ru/api/2/root</endpointBase>
    </paymentProvider>
  </qrPayApi>
  <access>
    <resource>https://online.moysklad.ru/api/remap/1.2</resource>
    <scope>admin</scope>
  </access>
</ServerApplication>
```

# Описание QrPay API

