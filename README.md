# Proyecto "Smart House"

## Introducción

El proyecto "Smart House" surge como respuesta a la creciente demanda de sistemas de seguridad eficientes y personalizables para el hogar. La combinación de una FPGA y diversos sensores permite crear un entorno inteligente y escalable capaz de detectar situaciones potencialmente peligrosas, como la presencia de movimiento o la existencia de gases nocivos. Este informe profundizará en los aspectos técnicos, los desafíos abordados y las decisiones de diseño que respaldan el desarrollo del sistema.

## Descripción del Problema

La seguridad residencial es un aspecto fundamental en la vida moderna, y tradicionalmente se ha abordado mediante sistemas propietarios y costosos. Este proyecto busca superar estas limitaciones, proporcionando un sistema de seguridad inteligente, asequible y personalizable. La detección temprana de eventos como movimiento y gas permite tomar medidas inmediatas para garantizar la seguridad del hogar y sus ocupantes.

## Objetivos

### Detección de Movimiento

La implementación de un sensor de movimiento (PIR) es esencial para identificar la presencia de personas en áreas específicas de la casa. Esto se logra mediante el análisis de las señales generadas por el sensor y su interpretación por la FPGA. Con base a estas señales, se determinará si se debe alertar o no al usuario.

### Detección de Gas

El uso de un sensor de gas agrega una capa adicional de seguridad al sistema, permitiendo la identificación de posibles fugas o concentraciones peligrosas. La FPGA procesa las lecturas del sensor y activa las medidas correspondientes en caso de detección de gas.

### Notificación por Telegram

La integración de un bot de Telegram permite al sistema comunicarse directamente con el usuario. Se enviarán notificaciones inmediatas en caso de eventos adversos, brindando al usuario la capacidad de tomar decisiones informadas rápidamente.

### Alarma Sonora

La activación de un altavoz para generar una alarma sonora refuerza la capacidad de respuesta del sistema. Esta función añade una alerta audible que puede ser crucial en situaciones críticas.

## Arquitectura del Sistema

### FPGA

La FPGA actúa como el núcleo o cerebro del sistema, coordinando todas las operaciones. Su capacidad de programación flexible permite adaptarse a diversas configuraciones y requisitos del proyecto.

### Sensor de Movimiento y Sensor de Gas

La correcta conexión y calibración de estos sensores son esenciales para garantizar una detección precisa. Las señales analógicas se convierten digitalmente y son procesadas por la FPGA para su interpretación.

### Bot de Telegram

La configuración del bot implica la obtención de un token para la comunicación segura. La integración del bot con la FPGA se realiza mediante una interfaz de programación de aplicaciones (API) de Telegram. Un microcontrolador ESP32 garantiza la comunicación entre la FPGA y el usuario mediante un bot de telegram alojado en dicho microcontrolador.

### Altavoz

La activación del altavoz se realiza en respuesta a eventos detectados, proporcionando una alerta audible en caso de emergencia.

## Instrucciones de Uso

### Conexión de Sensores y funcionamiento de la FPGA

Es crucial seguir las instrucciones de conexión de los sensores a la FPGA para garantizar un funcionamiento adecuado del sistema.



### Compilación y Carga

La compilación del código fuente y la carga del programa en la FPGA se realiza utilizando las herramientas open source proporcionadas durante el curso. 

### Monitoreo y control

El usuario puede monitorear las notificaciones del bot de Telegram para recibir alertas en tiempo real sobre eventos detectados. Además, la activación del altavoz proporciona una señal sonora adicional. Mediante este mismo bot, el usuarió podra desactivar la alarma en caso de ser necesario.


