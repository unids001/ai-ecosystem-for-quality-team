# Flujo de Pruebas - API Restaurant Orders

## 🔄 Diagrama de Flujo del Proceso de Testing

```
┌─────────────────────────────────────────────────────────────┐
│                     FASE 1: PREPARACIÓN                      │
└─────────────────────────────────────────────────────────────┘
│ 1. Cargar payload desde archivo externo                      │
│    └─> ajiaco-payload.json                                  │
│ 2. Configurar headers                                        │
│    └─> Content-Type: application/json                        │
│ 3. Inicializar variables y storage global                    │
│    └─> karate-config.js, order-id-storage.js                │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│                   FASE 2: EJECUCIÓN                          │
└─────────────────────────────────────────────────────────────┘
│ 1. Enviar POST request                                       │
│    └─> POST /api/restaurant/pedidos                          │
│ 2. Capturar response completo                                │
│    └─> { orderId, status, currency, estimatedMinutes }      │
│ 3. Manejo de timeouts y reintentos                          │
│    └─> 3 intentos, 2 segundos entre reintentos              │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│              FASE 3: VALIDACIÓN - NIVEL 1                    │
└─────────────────────────────────────────────────────────────┘
│ ✅ Status Code                                               │
│    └─> HTTP 200 OK                                           │
│ ✅ Response Existente                                        │
│    └─> response != null                                      │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│              FASE 4: VALIDACIÓN - NIVEL 2                    │
└─────────────────────────────────────────────────────────────┘
│ ✅ Schema Validation                                         │
│    └─> orderId: '#string'                                    │
│    └─> status: '#string'                                     │
│    └─> currency: '#string'                                   │
│    └─> estimatedMinutes: '#number'                           │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│              FASE 5: VALIDACIÓN - NIVEL 3                    │
└─────────────────────────────────────────────────────────────┘
│ ✅ Valores Específicos                                       │
│    └─> status == 'RECEIVED'                                  │
│    └─> currency == 'COP'                                     │
│    └─> estimatedMinutes > 0                                  │
│ ✅ Pattern Matching                                          │
│    └─> orderId == '#regex order-[0-9]+'                      │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│                   FASE 6: PERSISTENCIA                       │
└─────────────────────────────────────────────────────────────┘
│ 1. Extraer orderId del response                              │
│    └─> response.orderId                                      │
│ 2. Guardar en sistema de storage                             │
│    └─> order-id-storage.js                                   │
│ 3. Registrar en logs                                        │
│    └─> Información completa del pedido                       │
└─────────────────────────────────────────────────────────────┘
```

## 📋 Validaciones Estratégicas

### Contrato API vs Criterios de Aceptación

| Criterio de Aceptación | Contrato API | Validación Implementada |
|------------------------|--------------|-------------------------|
| POST al recurso de pedidos | POST /api/restaurant/pedidos | ✅ endpoint correcto |
| HTTP 200 OK | Response exitoso | ✅ status 200 |
| Identificador único | orderId con formato "order-XXXX" | ✅ pattern matching |

### Schema Validation Completo

```json
Response Structure:
{
  "orderId": "string",           // order-1001
  "status": "string",            // RECEIVED
  "currency": "string",          // COP
  "estimatedMinutes": "number"   // 25
}
```

### Tipos de Datos Validados
- **orderId**: String con patrón específico
- **status**: String con valor fijo 'RECEIVED'
- **currency**: String con valor fijo 'COP'
- **estimatedMinutes**: Number positivo (> 0)

## 🔧 Sistema de Storage

### Funcionalidades:
1. **saveOrderId(orderId)**: Guardar el ID del pedido
2. **getOrderId()**: Recuperar el ID para consultas
3. **clearOrderId()**: Limpiar el storage entre tests

### Persistencia Global:
- Configuración en `karate-config.js`
- Almacenamiento en `config.orderIds`
- Disponible para todos los tests

## 📊 Matriz de Validaciones

| Tipo Validación | Campo | Valor Esperado | Implementación |
|-----------------|-------|----------------|----------------|
| Status Code | response.status | 200 | `Then status 200` |
| Tipo de dato | orderId | string | `'#string'` |
| Tipo de dato | status | string | `'#string'` |
| Tipo de dato | currency | string | `'#string'` |
| Tipo de dato | estimatedMinutes | number | `'#number'` |
| Valor fijo | status | 'RECEIVED' | `== 'RECEIVED'` |
| Valor fijo | currency | 'COP' | `== 'COP'` |
| Rango | estimatedMinutes | > 0 | `> 0` |
| Patrón | orderId | order-[0-9]+ | `'#regex order-[0-9]+'` |

## 🚀 Escalabilidad del Framework

### Fácil agregar nuevos platos:
1. Crear nuevo payload JSON (ej: `sancocho-payload.json`)
2. Copiar escenario y cambiar nombre
3. Validaciones se reutilizan

### Fácil agregar nuevos escenarios:
1. Escenarios negativos (errores de validación)
2. Escenarios de consulta de estado
3. Escenarios de múltiples items

Este diseño permite un crecimiento sostenible del framework de pruebas.