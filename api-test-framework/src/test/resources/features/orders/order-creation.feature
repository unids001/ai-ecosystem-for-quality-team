@order-creation
Feature: Creación de pedidos de platos típicos colombianos

  Background:
    * url restaurantBaseUrl
    * header Content-Type = 'application/json'
    * configure retry = { count: 3, interval: 2000 }
    * def storage = read('classpath:data/storage/order-id-storage.js')

  @smoke
  Scenario: Creación exitosa de pedido de Ajiaco
    Given path 'api/restaurant/orders'
    And request read('classpath:data/payloads/ajiaco-payload.json')
    When method post
    # Validaciones Nivel 1: Status code y response básico
    Then status 200
    And assert response != null
    # Validaciones Nivel 2: Schema validation - estructura y tipos de datos
    And match response == { orderId: '#string', status: '#string', currency: '#string', estimatedMinutes: '#number' }
    # Validaciones Nivel 3: Valores específicos según contrato
    And match response.status == 'RECEIVED'
    And match response.currency == 'COP'
    And assert response.estimatedMinutes > 0
    # Validación de formato de orderId (pattern matching)
    And match response.orderId == '#regex order-[0-9]+'
    
    # Logging del response para debugging
    * print 'Response completo:', response
    * print 'Order ID creado:', response.orderId
    * print 'Estado del pedido:', response.status
    * print 'Moneda:', response.currency
    * print 'Tiempo estimado:', response.estimatedMinutes, 'minutos'
    
    # Persistir el orderId para consultas futuras
    * call storage.saveOrderId(response.orderId)