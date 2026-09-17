function saveOrderId(orderId) {
  karate.set('orderId', orderId);
  return orderId;
}

function getOrderId() {
  return karate.get('orderId');
}

function clearOrderId() {
  karate.set('orderId', null);
}