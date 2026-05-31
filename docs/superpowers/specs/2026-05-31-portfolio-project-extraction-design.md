# Diseño: Extracción de Información de Proyectos para Portfolio

## Visión General

Sistema para extraer información de proyectos pendientes (ValaquiaStore, Reto_Libreria, Reto2_Libreria) y convertirla en contenido estructurado para el portfolio.

## Contexto del Proyecto

**Portfolio actual:** HTML estático con 4 proyectos ya integrados
**Proyectos pendientes:** 3 proyectos en carpeta "Proyectos pendientes/"
**Objetivo:** Agregar estos proyectos al portfolio con descripción, tech stack e imágenes

## Proyectos a Analizar

### 1. ValaquiaStore
- **Tipo:** Full-stack (Android + Spring Boot)
- **Componentes:** Cliente Android (PMD) + Servidor PSP
- **Tech stack:** Java, Android, Spring Boot, Retrofit, Glide, MySQL
- **Funcionalidad:** Tienda de juegos con consejos de salud

### 2. Reto_Libreria (Web)
- **Tipo:** Aplicación web PHP
- **Arquitectura:** MVC con API REST
- **Tech stack:** PHP, MySQL, HTML5, CSS3, JavaScript
- **Funcionalidad:** Sistema de gestión de librería

### 3. Reto2_Libreria (Desktop)
- **Tipo:** Aplicación de escritorio JavaFX
- **Arquitectura:** MVC con connection pooling
- **Tech stack:** Java, JavaFX, MySQL, DBCP2
- **Funcionalidad:** Mismo sistema de librería que versión web

## Diseño del Sistema

### Componentes

1. **Script PowerShell** (`extract-project-info.ps1`)
   - Extrae información técnica automáticamente
   - Lee READMEs, build files, estructura de directorios
   - Genera markdown estructurado

2. **Archivos Markdown** (2 archivos)
   - `valaquiastore.md`
   - `reto-libreria.md` (unificado: web + desktop)

3. **Carpeta de imágenes**
   - Imágenes extraídas de repositorios
   - Mockups generados para proyectos sin imágenes

### Flujo de Datos

```
Proyectos Pendientes
       ↓
Script PowerShell (extracción automática)
       ↓
Archivos Markdown (información estructurada)
       ↓
Portfolio HTML (integración final)
```

## Especificación del Script

### Funcionalidades

1. **Extracción de READMEs**
   - Buscar archivos README.md o Readme.md
   - Extraer contenido formateado
   - Identificar secciones clave (descripción, features, tech stack)

2. **Análisis de Build Files**
   - `build.gradle.kts` (Android/Java)
   - `pom.xml` (Maven/Spring Boot)
   - `package.json` (Node.js)
   - Extraer dependencias y tecnologías

3. **Estructura de Directorios**
   - Identificar arquitectura (MVC, etc.)
   - Contar archivos por tipo
   - Detectar patrones de diseño

4. **Búsqueda de Características**
   - Buscar palabras clave en código
   - Identificar funcionalidades principales
   - Extraer tecnologías específicas

5. **Manejo de Imágenes**
   - Buscar imágenes existentes en repositorios (.jpg, .png, .gif)
   - Si no existen, generar placeholders descriptivos
   - Crear thumbnails optimizados para el portfolio
   - Nota: El usuario tomará capturas manuales para imágenes finales

### Salida

Para cada proyecto, generar markdown con:

```markdown
# Nombre del Proyecto

## Descripción
[Descripción detallada del proyecto, funcionalidades y propósito]

## Tech Stack
- Tecnología 1
- Tecnología 2
- Tecnología 3

## Características Clave
- Característica 1
- Característica 2
- Característica 3

## Arquitectura
[Descripción de la arquitectura del proyecto]

## Imágenes
![Descripción](ruta/imagen.jpg)
```

## Contenido por Proyecto

### ValaquiaStore

**Descripción:**
Aplicación completa de tienda de juegos desarrollada como proyecto académico. Consta de un cliente Android para dispositivos móviles y un servidor Spring Boot para la API REST. Incluye funcionalidades de catálogo de juegos, consejos de salud vinculados a cada juego, y sistema de descarga segura con verificación de integridad.

**Tech Stack:**
- Android (Java)
- Spring Boot (Java 22)
- Retrofit (HTTP client)
- Glide (Imágenes)
- MySQL (Base de datos)
- SHA-256 (Verificación de integridad)

**Características Clave:**
- Consumo de API REST con Retrofit
- Gestión de juegos y consejos de salud
- Descarga de archivos con Threads (Hilos)
- Verificación de integridad con SHA-256
- Interfaz responsive con Material Design

**Arquitectura:**
- Cliente: MVC con Activities y Adapters
- Servidor: Spring Boot con controllers, services, repositories
- Comunicación: API REST con JSON

### Reto Librería (Unificado)

**Descripción:**
Sistema completo de gestión de librería desarrollado en dos versiones: una aplicación web con PHP y una aplicación de escritorio con JavaFX. Ambas versiones comparten la misma base de datos MySQL y funcionalidades, pero están optimizadas para sus respectivos entornos. El proyecto incluye mejoras significativas en seguridad, arquitectura MVC y contrato JSON.

**Tech Stack:**
- PHP (Versión web)
- JavaFX (Versión desktop)
- MySQL (Base de datos)
- HTML5/CSS3/JavaScript (Frontend web)
- MVC (Arquitectura)
- API REST (Comunicación)

**Características Clave:**
- Arquitectura MVC limpia (API → Controller → DAO → Entities)
- Contrato JSON consistente: `{status, code, message, data}`
- Seguridad: password_hash, password_verify, session_regenerate_id
- Validación de uploads (extensión, tamaño, MIME real)
- Cliente web: apiFetch() común para llamadas API
- Cliente desktop: Connection pooling con DBCP2

**Arquitectura:**
- Web: PHP MVC con API REST, controllers, DAOs, entities
- Desktop: JavaFX MVC con FXML, controllers, models, connection pool
- Base de datos compartida con procedimientos almacenados

## Integración con Portfolio

### Estructura de Archivos

```
Portfolio-Mikel/
├── index.html (actualizar sección de proyectos)
├── images/
│   ├── project05.jpg (ValaquiaStore)
│   ├── project06.jpg (Reto Librería)
│   └── ...
├── docs/
│   └── superpowers/
│       └── specs/
│           └── 2026-05-31-portfolio-project-extraction-design.md
└── Proyectos pendientes/
    └── (archivos originales)
```

### Actualización del HTML

Agregar nuevas tarjetas de proyecto en la sección `#four`:

```html
<article class="reveal">
    <a href="#" class="image"><img src="images/project05.jpg" alt="ValaquiaStore" loading="lazy" /></a>
    <h3 class="major">VALAQUIASTORE</h3>
    <p>[Descripción del proyecto]</p>
    <div class="tech-tags">
        <span class="tag">Android</span>
        <span class="tag">Spring Boot</span>
        <span class="tag">Java</span>
    </div>
    <a href="#" class="special">See Demo</a>
    <a href="#" class="button">See Code</a>
</article>
```

## Plan de Implementación

### Fase 1: Preparación
1. Crear directorio `docs/superpowers/specs/`
2. Crear directorio `scripts/` para el script PowerShell
3. Crear directorio `project-images/` para imágenes extraídas

### Fase 2: Script PowerShell
1. Desarrollar función para extraer READMEs
2. Desarrollar función para analizar build files
3. Desarrollar función para buscar características
4. Desarrollar función para generar markdown
5. Desarrollar función para extraer/generar imágenes

### Fase 3: Ejecución
1. Ejecutar script para ValaquiaStore
2. Ejecutar script para Reto_Libreria
3. Ejecutar script para Reto2_Libreria
4. Revisar y refinar markdown generado

### Fase 4: Integración
1. Actualizar index.html con nuevos proyectos
2. Agregar imágenes al directorio images/
3. Probar responsive design
4. Verificar consistencia con proyectos existentes

## Criterios de Aceptación

1. **Información Completa:** Cada proyecto tiene descripción, tech stack y características
2. **Imágenes:** Al menos 1 imagen por proyecto
3. **Consistencia:** Formato igual a proyectos existentes
4. **Responsive:** Las tarjetas se ven bien en móvil y desktop
5. **Accesibilidad:** Alt texts, labels, semantic HTML

## Riesgos y Mitigaciones

### Riesgo 1: Imágenes faltantes
**Mitigación:** Generar mockups representativos o usar placeholders

### Riesgo 2: Información incompleta en READMEs
**Mitigación:** Análisis manual adicional del código fuente

### Riesgo 3: Incompatibilidad con diseño actual
**Mitigación:** Seguir mismos patrones CSS y estructura HTML

## Próximos Pasos

1. Invocación del skill writing-plans para crear plan de implementación detallado
2. Desarrollo del script PowerShell
3. Ejecución y pruebas del script
4. Integración final en el portfolio
