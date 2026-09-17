# Mejores practicas con el framework 4Ds
El QC asume el control del proceso aplicando el framework de fluidez de IA y las **4 Ds** (Description, Delegation, Discernment, Diligence) de Anthropic

### **Especificación y Clarificación (** **Description + Shift Left** **)**

* **La Intención:** El QC no programa de inmediato; usa a la IA para analizar la historia de usuario y detectar vacíos técnicos antes de escribir una sola línea de código.
* **Prompt 1:**

&gt; *"Actúa como un QA Técnico. Utilizando el MCP de Jira: Lee el contrato en las notas técnicas y comentarios de la historia de usuario SCRUM-1. Basado en eso, valida los criterios de aceptación y alerta dejando un comentario --etiqueta a la PO @pepita-perez-- si la US pide algo que el contrato no soporta."*

* **El Resultado:** CODA no entrega código todavía. Analiza los requerimientos, valida los criterios contra el esquema del contrato y señala inconsistencias.
* **Contraste:** Aplica un enfoque de **Shift Left** real al encontrar inconsistencias antes de la automatización y contrarresta el *copy-paste* ciego sin contexto

### **Plan Técnico y Tareas (** **Delegation** **)**

* **La Intención:** El QC define la arquitectura y estrategia de prueba; delega a la IA la ejecución, pero mantiene el control del pensamiento.
* **Prompt 2:**

&gt; *"Diseña el plan técnico para Karate escribiendo los pasos del flujo estándar. Separa el payload del plato típico --puedes usar el Ajiaco-- en un archivo JSON externo. Para la aserción, no valides solo el status adecuado; define cómo validaremos que el esquema del response coincide con el contrato y cómo guardaremos el 'order\_id' para proximas consultas de validación. No escribas código, solo asegurate de diseñar bien el plan técnico."*

* **El Resultado:** CODA entrega un plan de tareas claro: 1) Crear el archivo externo `bandeja-paisa.json` y 2) Diseñar el archivo `.feature` estructurado con validación estricta de esquema.
* **Contraste:** Evita los datos "quemados" (*hardcoded*) y previene la creación de tests frágiles o desechables

### **Implementación y Revisión (** **Discernment** **)**

* **La Intención:** Solicitar la generación del código con base en el plan acordado y revisarlo con criterio técnico.
* **Prompt 3:**

&gt; *"Genera el código para las tareas definidas en el plan técnico."*

* **El Resultado:** CODA entrega un script modular donde se valida el esquema mediante aserciones estrictas como `And match response == '#(expectedSchema)'`.
* Al ejecutar el test contra el mock (que responde HTTP 200 con el JSON de error `{"error": "Ingredientes insuficientes"}`), **¡esta vez el test falla!** Karate detecta que la estructura devuelta no coincide con el contrato esperado de éxito.
* **Contraste:** Muestra cómo un test bien diseñado no cae en la trampa del falso positivo y detecta que el sistema no cumplió el contrato
* **Prompt 3.1 (Exploración para validar el flujo feliz):**

&gt; *"El test para 'Ajiaco' falló porque la API devolvió un error de ingredientes insuficientes que no cumplía el esquema de éxito. Primero, redacta y publica un comentario estructurado en la US SCRUM-1 documentando este caso de borde para que el equipo (PO y Devs) decida cómo debe comportarse la API. Luego, cambia el payload a 'Bandeja Paisa' para ejecutar y validar el flujo feliz nuevamente."*

* **El Resultado:** La IA actualiza el archivo JSON de datos o la variable del payload. Se ejecuta el test con *"Bandeja Paisa"*, el mock responde con el contrato de éxito esperado y la prueba pasa en **verde (PASSED)**.

### **Validación, Manejo de Errores y Mentoría (** **Diligence** **)**

* **La Intención:** Si requiere profundizar, utiliza a la IA como mentora.

* **Prompt 4 (Mentoría y aprendizaje):**

&gt; *"Ahora llévame por el camino que recorre Karate en la automatización de esta prueba API. Explícame paso a paso cómo trabaja Karate detrás de escena, desde el step del 'Given' hasta el 'Then'. Utiliza un lenguaje técnico progresivo. El objetivo es que yo sea capaz de explicarlo y sustentarlo."*

* **El Resultado:** CODA enseña la arquitectura interna del framework, permitiendo que el QC eleve su nivel técnico en lugar de depender de una "caja negra"
