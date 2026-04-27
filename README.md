###   SETUP INSTRUCTIONS

- Download the project directory
- `CD` into the "mod13_api_impl" directory
- If the "node_modules" folder does not exist 
  - Within the project directory, run 
  
      `npm install`
      
      to install core project dependencies listed in the   configuration file if they have not been installed   already
    - If the config file is missing or `npm install` does not function properly, run
    `npm install ajv-formats@3.0.1 ajv-formats@3.0.1 ajv-formats@3.0.1 ajv-formats@3.0.1 ajv-formats@3.0.1`
- Run the `node app.js` command to start the server
---
###   ENDPOINT DESCRIPTIONS

*for endpoints with an "id" parameter, the id represents the ID associated with an Order record in the database - a value that increments with each additional order added to the database.
<br></br>

| ENDPOINT | DESCRIPTION | Returns |
|----------|-------------|---------|
|POST /orders| Add an order to the database, requires valid JSON payload with all fields barring the ID field | STATUS CODE: 201, Returns the valid record, additionally with orderID, createdAt, and updatedAt fields|
|GET /orders| Returns all orders within the database | STATUS CODE: 200, returns a list of all order records|
|GET /orders/:id| Returns the order with the matching ID, produces an error if no such order exists| STATUS CODE: 200, returns the order record with the matching ID|
|PATCH /orders/:id| Updates one or more fields within an existing order, submitted changes must be valid and the designated ID must have a matching record or else an error is produced| STATUS CODE: 200, returns the updated order record|
|DELETE /orders/:id| Deletes an order with the matching ID from the database, produces an error if no such record exists| STATUS CODE: 204, returns no content if the order record was successfully deleted|

---
###   EXAMPLE JSON PAYLOADS AND EXPECTED RESULTS (STATUS CODES)


**Create a new Order**

__INPUT__

POST http://localhost:3000/orders
 ```
 {
    "orderPrice": 51.29,
    "orderStatus": "PENDING",
    "orderDate": "2026-12-13",
    "customerAcct": "908371"
}
 ```
 
__OUTPUT__

HEADERS

```
URL: http://localhost:3000/orders
Method: POST
Status Code: 201 Created
```

RESPONSE

```
{
    "orderId": 1,
    "orderPrice": 51.29,
    "orderStatus": "PENDING",
    "orderDate": "2026-12-13",
    "customerAcct": "908371",
    "updatedAt": "2026-03-30T01:15:05.794Z",
    "createdAt": "2026-03-30T01:15:05.794Z"
}
```

**Get All Orders**

__INPUT__

GET http://localhost:3000/orders

__OUTPUT__

HEADERS
```
URL: http://localhost:3000/orders
Method: GET
Status Code: 200 OK
```
RESPONSE
```
[
    {
        "orderId": 1,
        "orderDate": "2026-12-13",
        "orderPrice": 51.29,
        "orderStatus": "PENDING",
        "customerAcct": "908371",
        "createdAt": "2026-03-30T01:15:05.794Z",
        "updatedAt": "2026-03-30T01:15:05.794Z"
    },
    {
        "orderId": 2,
        "orderDate": "2026-12-14",
        "orderPrice": 32.41,
        "orderStatus": "PENDING",
        "customerAcct": "123456",
        "createdAt": "2026-03-30T01:15:07.343Z",
        "updatedAt": "2026-03-30T01:15:07.343Z"
    },
    {
        "orderId": 3,
        "orderDate": "2026-11-11",
        "orderPrice": 64.49,
        "orderStatus": "PENDING",
        "customerAcct": "998877",
        "createdAt": "2026-03-30T01:15:08.885Z",
        "updatedAt": "2026-03-30T01:15:08.885Z"
    }
]
```

**Get an Order from the list of Orders by ID**

__INPUT__

GET http://localhost:3000/orders/1

__OUTPUT__

HEADERS
```
URL: http://localhost:3000/orders/1
Method: GET
Status Code: 200 OK
```
RESPONSE
```
{
    "orderId": 1,
    "orderDate": "2026-12-13",
    "orderPrice": 51.29,
    "orderStatus": "PENDING",
    "customerAcct": "908371",
    "createdAt": "2026-03-30T01:15:05.794Z",
    "updatedAt": "2026-03-30T01:15:05.794Z"
}
```

**Update a Pending Order to a Shipped Order**

__INPUT__

PATCH http://localhost:3000/orders/1

```
{
    "orderStatus": "SHIPPED"
}
```

__OUTPUT__

HEADERS
```
URL: http://localhost:3000/orders/1
Method: PATCH
Status Code: 200 OK
```
RESPONSE
```
{
    "orderId": 1,
    "orderDate": "2026-12-13",
    "orderPrice": 51.29,
    "orderStatus": "SHIPPED",
    "customerAcct": "908371",
    "createdAt": "2026-03-30T01:15:05.794Z",
    "updatedAt": "2026-03-30T01:15:13.446Z"
}
```

**Delete an Order**

__INPUT__

DELETE http://localhost:3000/orders/1

__OUTPUT__

HEADERS
```
URL: http://localhost:3000/orders/1
Method: DELETE
Status Code: 200 OK
```
RESPONSE
```
{
    "orderId": 1,
    "orderDate": "2026-12-13",
    "orderPrice": 51.29,
    "orderStatus": "SHIPPED",
    "customerAcct": "908371",
    "createdAt": "2026-03-30T01:15:05.794Z",
    "updatedAt": "2026-03-30T01:15:13.446Z"
}
```
