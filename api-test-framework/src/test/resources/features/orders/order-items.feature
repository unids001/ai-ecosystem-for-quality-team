Feature: Consulta de ítems de una orden

  @smoke @getOrderItems
  Scenario: Consultar ítems de una orden existente
    * def createOrderResponse = call read('order-creation.feature')
    * def orderId = createOrderResponse.response.orderId
    
    Given url baseUrl + '/api/restaurant/orders/' + orderId + '/items'
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And match response.orderId == orderId
    And match response.items == '#array'
    And match response.items[0] contains
      """
      {
        "id": "#string",
        "quantity": '#number',
        "price": '#number'
      }
      """
    And match response.total == '#number'
    And match response.currency == 'COP'

  @regression
  Scenario: Consultar ítems de orden inexistente
    Given url baseUrl + '/api/restaurant/orders/order-inexistente-999/items'
    And header Content-Type = 'application/json'
    When method get
    Then status 404