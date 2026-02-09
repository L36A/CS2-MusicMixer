# CS2 & Media Controller: Global Audio Hotkeys

Una solución de automatización ligera basada en **AutoHotkey (AHK)** diseñada para gestionar el equilibrio de audio entre **Counter-Strike 2** y servicios de streaming (YouTube Music, Spotify, etc.) mediante el panel numérico.

## 📋 Resumen del Proyecto

Este script permite el control total de medios y el muteo granular del proceso `cs2.exe` sin necesidad de realizar `Alt+Tab`. Utiliza una arquitectura de **intercepción de bajo nivel** para garantizar que los comandos se ejecuten incluso cuando el juego tiene el foco exclusivo del teclado.

## ⌨️ Asignaciones de Teclas (Hotkeys)

| Acción | Combinación | Función Técnica | 
| ----- | ----- | ----- | 
| **Pausa / Play** | `Ctrl + Numpad 5` | Envía `Media_Play_Pause` al sistema. | 
| **Siguiente Tema** | `Ctrl + Numpad 6` | Envía `Media_Next`. | 
| **Anterior Tema** | `Ctrl + Numpad 4` | Envía `Media_Prev`. | 
| **Subir Volumen** | `Ctrl + Numpad 9` | Incrementa el volumen maestro de Windows. | 
| **Bajar Volumen** | `Ctrl + Numpad 3` | Decrementa el volumen maestro de Windows. | 
| **Mute/Unmute CS2** | `Ctrl + Numpad 0` | Toggle del volumen específico para `cs2.exe`. | 

## 🛠 Requisitos de Despliegue

* **AutoHotkey v1.1.37.02** (o compatible con la rama 1.1).
* **NirCmd**: El binario `nircmd.exe` debe residir en el mismo directorio que el script.
* **Privilegios**: El script debe ejecutarse con **permisos de Administrador** para poder interactuar con el proceso del juego (Integridad Alta).

---

## 🔍 Decisiones de Diseño y Justificación Técnica

### 1. Intercepción vía Hook de Bajo Nivel (`#UseHook`)
* **Decisión:** Se fuerza el uso del hook de teclado de Windows (`WH_KEYBOARD_LL`).
* **Contraste:** A diferencia del método estándar de registro de hotkeys de Windows (`RegisterHotKey`), el Hook captura la pulsación antes de que llegue a la cola de mensajes de la aplicación activa.
* **Justificación:** En juegos de tipo *Full Screen Exclusive*, el motor suele "secuestrar" el input. El Hook garantiza que AHK procese la tecla antes de que el juego la ignore o la consuma, asegurando una fiabilidad del 100%.

### 2. Control de Audio mediante NirCmd vs. AHK nativo
* **Decisión:** Uso del ejecutable externo `nircmd.exe` para gestionar el volumen del proceso.
* **Contraste:** Los comandos nativos de AHK (como `SoundSet`) actúan principalmente sobre el mezclador maestro o dispositivos físicos. Para manipular una **sesión de audio específica** (como la de CS2) de forma limpia, se requiere la API de *Audio Endpoint* de Windows.
* **Justificación:** NirCmd es el estándar de oro en administración de sistemas para automatización de audio por CLI. Es más ligero y estable que cargar librerías complejas como `VA.ahk` (Vista Audio) dentro del script, reduciendo la superficie de error y el consumo de recursos.

### 3. Mapeo en VK_NUMPAD
* **Decisión:** Se bindean las teclas específicamente al panel numérico (`Numpad0`, `Numpad5`, etc.).
* **Contraste:** Usar los números de la fila superior (`0-9`) entraría en conflicto directo con los binds de compra de armas y selección de granadas en CS2.
* **Justificación:** Las teclas del Numpad tienen códigos de escaneo únicos. Esto permite mantener la funcionalidad del juego intacta mientras se utiliza el panel numérico como un "mixer" físico dedicado.

---

## 🛡 Seguridad y Cumplimiento (VAC)

Como solución orientada a usuarios de **Seguridad Informática**:
* **Integridad:** El script no inyecta código en el espacio de memoria de `cs2.exe`.
* **Transparencia:** Solo interactúa con las APIs públicas de Windows para la gestión de audio y entrada de teclado.
* **Riesgo:** Es 100% seguro contra sistemas Anti-Cheat (VAC), ya que se comporta como una utilidad de control de periféricos estándar (similar a los drivers de Corsair o Logitech).

---

## 📜 Licencia
Este proyecto es de código abierto bajo la licencia MIT.
