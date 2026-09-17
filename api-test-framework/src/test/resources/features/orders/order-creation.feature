Feature: Creación de pedido de un plato típico

  @smoke
  Scenario: Crear pedido de Ajiaco mediante API
    Given url baseUrl + '/api/restaurant/orders'
    And header Content-Type = 'application/json'
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
          }
        ],
        "payment": {
          "method": "CASH"
        }
      }
      """
    When method post
    Then status 200
    And match response.orderId != null
    And match response.orderId != ''
    And match response contains
      """
      {
        "orderId": "#string",
        "status": "#string",
        "currency": "#string",
        "estimatedMinutes": '#number'
      }
      """