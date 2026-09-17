Feature: Restaurant Order Management

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'

  @smoke @critical
  Scenario: Order creation with valid body
    Given path '/api/restaurant/orders'
    And request
      """
      {
        "customer": {
          "name": "Juan Garcia",
          "phone": "3101234567",
          "address": "Cra 7 #45-23, Bogota"
        },
        "items": [
          {
            "itemId": "AJIACO",
            "name": "Ajiaco",
            "quantity": 2,
            "price": 15000
          },
          {
            "itemId": "BANDEJA",
            "name": "Bandeja Paisa",
            "quantity": 1,
            "price": 25000
          }
        ],
        "payment": {
          "method": "CASH"
        }
      }
      """
    When method POST
    Then status 201
    And match response.orderId == 'order-1001'
    And match response.status == 'RECEIVED'
    And match response.currency == 'COP'
    And match response.estimatedMinutes == 25
