# 📌 Secuencia de Collatz

> ⚠️ Estado: **Finalizado**

Este proyecto implementa la generación de la secuencia de Collatz desde 1 hasta *n*, e imprime el **valor máximo** alcanzado por todas las secuencias generadas. Se ha desarrollado en dos versiones: una usando el lenguaje ensamblador **MARIE** y otra usando **ensamblador ARM** sobre Raspberry Pi.

---

## 👥 Autores

- [JUAN SEBASTIÁN GUAYAZÁN CLAVIJO](https://github.com/JSGC-ECI) → [juan.guayazan-c@mail.escuelaing.edu.co](mailto:juan.guayazan-c@mail.escuelaing.edu.co)

Organización de los Sistemas de Cómputo (ISIS ODSC-1 y ODSC-101)      
Decanatura Ingeniería de Sistemas → Centro de Estudios de Arquitectura Tecnológica y Seguridad     
Ingeniería de Sistemas    
Escuela Colombiana de Ingeniería Julio Garavito     
2025-i

---

## 🧠 Índice

* [📌 Nombre del Proyecto](#-secuencia-de-collatz)
* [🚀 Características](#-características)
* [⚙️ Tecnologías](#️-tecnologías)
* [📦 Instalación](#-instalación-y-requisitos)
* [▶️ Uso](#️-uso)
* [🧪 Pruebas](#-pruebas)
* [📁 Estructura del Proyecto](#-estructura-del-proyecto)
* [📌 TODOs / Funcionalidades Futuras](#-todos--funcionalidades-futuras)
* [📄 Licencia](#-licencia)

---

## 🚀 Características

* ✅ Implementación de la secuencia de Collatz desde 1 hasta *n*.
* ✅ Cálculo del **máximo término** alcanzado en las secuencias.
* ✅ Versión en **lenguaje ensamblador MARIE** para simuladores educativos.
* ✅ Versión en **ensamblador ARM** para Raspberry Pi.
* ✅ Entrada por consola / terminal.

---

## ⚙️ Tecnologías

* Lenguaje(s): `MARIE Assembly`, `ARM Assembly`
* Herramientas:

  * `MARIE Simulator` (para `.mas`)
  * `as` y `ld` en Raspberry Pi (para `.s`)
* Dependencias:

  * `gcc-arm-none-eabi` o `binutils` en ARM
  * Simulador MARIE descargado desde el sitio oficial

---

## 📦 Instalación y Requisitos

### Clonar el repositorio

```bash
git clone https://github.com/JuanSebastianGuayazanClavijoECI/collatz-mar-arm
cd collatz-mar-arm
```

### Requisitos

* Para MARIE:

  * Descargar [MARIE Simulator](https://www.marietools.com) e instalarlo.
* Para ARM:

  * Raspberry Pi con terminal.
  * Paquete `as`, `ld` o toolchain de `gcc-arm`.

---

## ▶️ Uso

### Entrada esperada:

```
número_de_casos
n1
n2
...
```

> Por cada línea, se genera la secuencia de Collatz desde 1 hasta *n* y se imprime el **mayor valor** encontrado.

#### Ejemplo:

**Entrada**

```
2
4
7
```

**Salida**

```
5
16
```

---

## 🧪 Pruebas

### Para MARIE:

1. Abre el simulador.
2. Carga `pro.mas`.
3. Ejecuta paso a paso o en ejecución completa.
4. Verifica la salida en el simulador.

### Para ARM:

```bash
as -o pro.o pro.s
ld -o pro pro.o
./pro
```

---

## 📁 Estructura del Proyecto

```bash
📦 collatz-mar-arm
 ┣ 📜 pro.mas           # Versión MARIE
 ┗ 📜 pro.s             # Versión ARM Assembly
```

---

## 📌 TODOs / Funcionalidades Futuras

* [ ] Agregar versión en C para validación.
* [ ] Añadir visualización gráfica de la secuencia.
* [ ] Mejorar formato de entrada/salida en terminal.


---

## 📄 Licencia

Este proyecto está licenciado bajo propósitos académicos y educativos. Puedes consultar el archivo [LICENSE](./LICENSE) para más información.

---

¿Deseas que también te prepare el `LICENSE`, `.gitignore` o el `pro.mas` / `pro.s` si aún no los tienes completos?
