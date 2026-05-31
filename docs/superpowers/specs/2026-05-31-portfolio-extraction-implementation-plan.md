# Plan de Implementación: Extracción de Proyectos para Portfolio

## Resumen

Implementar sistema para extraer información de proyectos pendientes (ValaquiaStore, Reto_Libreria, Reto2_Libreria) y convertirla en contenido estructurado para el portfolio HTML existente.

## Decisiones de Arquitectura

1. **Script PowerShell:** Se usa PowerShell por compatibilidad nativa con Windows y capacidad de manipulación de archivos
2. **Markdown como formato intermedio:** Permite revisión manual antes de integración final
3. **Reto Librería unificado:** Se presentan web y desktop como un solo proyecto con dos versiones
4. **Imágenes placeholder:** Se generan descripciones textuales hasta que el usuario tome capturas manuales

## Lista de Tareas

### Fase 1: Preparación del Entorno

- [ ] **Tarea 1: Crear estructura de directorios**
  - Descripción: Crear directorios necesarios para el proyecto
  - Criterios de aceptación:
    - [ ] Directorio `Portfolio-Mikel/scripts/` existe
    - [ ] Directorio `Portfolio-Mikel/project-images/` existe
    - [ ] Directorio `Portfolio-Mikel/docs/superpowers/specs/` existe (ya creado)
  - Verificación: Listar directorios y confirmar estructura
  - Dependencias: Ninguna
  - Archivos tocados: Ninguno (solo creación de directorios)
  - Alcance: XS

### Fase 2: Desarrollo del Script PowerShell

- [ ] **Tarea 2: Crear función de extracción de READMEs**
  - Descripción: Desarrollar función que busque y extraiga contenido de archivos README
  - Criterios de aceptación:
    - [ ] Función `Extract-ReadmeContent` acepta ruta como parámetro
    - [ ] Busca archivos README.md, Readme.md, readme.md
    - [ ] Extrae contenido completo preservando formato
    - [ ] Retorna string con contenido del README
  - Verificación: Ejecutar función con proyecto de prueba
  - Dependencias: Tarea 1
  - Archivos tocados: `scripts/extract-project-info.ps1`
  - Alcance: S

- [ ] **Tarea 3: Crear función de análisis de build files**
  - Descripción: Desarrollar función que analice archivos de build para extraer dependencias
  - Criterios de aceptación:
    - [ ] Función `Analyze-BuildFiles` acepta ruta como parámetro
    - [ ] Detecta y analiza: build.gradle.kts, pom.xml, package.json
    - [ ] Extrae lista de dependencias/tecnologías
    - [ ] Retorna hashtable con tecnologías identificadas
  - Verificación: Ejecutar con proyecto ValaquiaStore
  - Dependencias: Tarea 1
  - Archivos tocados: `scripts/extract-project-info.ps1`
  - Alcance: M

- [ ] **Tarea 4: Crear función de búsqueda de características**
  - Descripción: Desarrollar función que busque palabras clave en código fuente
  - Criterios de aceptación:
    - [ ] Función `Find-ProjectFeatures` acepta ruta como parámetro
    - [ ] Busca patrones comunes: MVC, API, CRUD, Authentication, etc.
  - Verificación: Ejecutar con proyecto Reto_Libreria
  - Dependencias: Tarea 1
  - Archivos tocados: `scripts/extract-project-info.ps1`
  - Alcance: M

- [ ] **Tarea 5: Crear función de generación de markdown**
  - Descripción: Desarrollar función que genere markdown estructurado
  - Criterios de aceptación:
    - [ ] Función `Generate-ProjectMarkdown` acepta datos del proyecto
  - Verificación: Generar markdown de prueba
  - Dependencias: Tareas 2, 3, 4
  - Archivos tocados: `scripts/extract-project-info.ps1`
  - Alcance: M

- [ ] **Tarea 6: Crear función de manejo de imágenes**
  - Descripción: Desarrollar función para extraer/buscar imágenes
  - Criterios de aceptación:
    - [ ] Función `Get-ProjectImages` acepta ruta como parámetro
  - Verificación: Ejecutar con proyecto que tenga imágenes
  - Dependencias: Tarea 1
  - Archivos tocados: `scripts/extract-project-info.ps1`
  - Alcance: S

- [ ] **Tarea 7: Crear script principal orchestrador**
  - Descripción: Script principal que coordine todas las funciones
  - Criterios de aceptación:
    - [ ] Script acepta ruta de proyecto como parámetro
  - Verificación: Ejecutar con cada proyecto
  - Dependencias: Tareas 2-6
  - Archivos tocados: `scripts/extract-project-info.ps1`
  - Alcance: S

### Checkpoint: Script Completo
- [ ] Todas las funciones del script funcionan correctamente
- [ ] Script genera markdown válido para cada proyecto
- [ ] No hay errores en ejecución

### Fase 3: Ejecución y Extracción

- [ ] **Tarea 8: Ejecutar extracción para ValaquiaStore**
  - Descripción: Ejecutar script en proyecto ValaquiaStore
  - Criterios de aceptación:
    - [ ] Archivo `project-images/valaquiastore.md` generado
    - [ ] Información completa: descripción, tech stack, características
  - Verificación: Revisar contenido del markdown
  - Dependencias: Tarea 7
  - Archivos tocados: `project-images/valaquiastore.md`
  - Alcance: S

- [ ] **Tarea 9: Ejecutar extracción para Reto_Libreria**
  - Descripción: Ejecutar script en proyecto Reto_Libreria
  - Criterios de aceptación:
    - [ ] Archivo `project-images/reto-libreria.md` generado
    - [ ] Información completa de versión web
  - Verificación: Revisar contenido del markdown
  - Dependencias: Tarea 7
  - Archivos tocados: `project-images/reto-libreria.md`
  - Alcance: S

- [ ] **Tarea 10: Ejecutar extracción para Reto2_Libreria**
  - Descripción: Ejecutar script en proyecto Reto2_Libreria
  - Criterios de aceptación:
    - [ ] Información de versión desktop integrada en `reto-libreria.md`
    - [ ] Ambas versiones documentadas correctamente
  - Verificar: Revisar markdown unificado
  - Dependencias: Tarea 9
  - Archivos tocados: `project-images/reto-libreria.md`
  - Alcance: S

### Checkpoint: Extracción Completa
- [ ] Todos los markdowns generados
- [ ] Información verificada y completa
- [ ] Listo para refinamiento manual

### Fase 4: Refinamiento Manual

- [ ] **Tarea 11: Revisar y refinar markdown de ValaquiaStore**
  - Descripción: Revisar calidad del contenido extraído
  - Criterios de aceptación:
    - [ ] Descripción clara y concisa
    - [ ] Tech stack completo y preciso
    - [ ] Características relevantes destacadas
  - Verificación: Revisión humana del contenido
  - Dependencias: Tarea 8
  - Archivos tocados: `project-images/valaquiastore.md`
  - Alcance: S

- [ ] **Tarea 12: Revisar y refinar markdown de Reto Librería**
  - Descripción: Revisar calidad del contenido unificado
  - Criterios de aceptación:
    - [ ] Ambas versiones (web y desktop) documentadas
    - [ ] Comparación clara entre versiones
    - [ ] Tech stack completo para ambas
  - Verificación: Revisión humana del contenido
  - Dependencias: Tarea 10
  - Archivos tocados: `project-images/reto-libreria.md`
  - Alcance: S

### Checkpoint: Contenido Refinado
- [ ] Markdowns revisados y aprobados
- [ ] Listos para integración en HTML

### Fase 5: Integración en Portfolio

- [ ] **Tarea 13: Preparar imágenes para el portfolio**
  - Descripción: Crear placeholders o extraer imágenes existentes
  - Criterios de aceptación:
    - [ ] Archivos de imagen en `images/` para cada proyecto
    - [ ] Nombres consistentes: project05.jpg, project06.jpg
  - Verificación: Verificar que imágenes existen y son válidas
  - Dependencias: Tareas 11, 12
  - Archivos tocados: `images/project05.jpg`, `images/project06.jpg`
  - Alcance: S

- [ ] **Tarea 14: Actualizar sección de proyectos en index.html**
  - Descripción: Agregar nuevas tarjetas de proyecto al HTML
  - Criterios de aceptación:
    - [ ] Nuevos `<article>` agregados en sección `#four`
    - [ ] Estructura HTML consistente con proyectos existentes
    - [ ] Tech tags correctamente formateados
    - [ ] Enlaces placeholder para demo y código
  - Verificación: Abrir en navegador y verificar visualización
  - Dependencias: Tarea 13
  - Archivos tocados: `index.html`
  - Alcance: M

- [ ] **Tarea 15: Verificar responsive design**
  - Descripción: Probar que las nuevas tarjetas se ven bien en diferentes dispositivos
  - Criterios de aceptación:
    - [ ] Tarjetas se ven bien en desktop (1200px+)
    - [ ] Tarjetas se ven bien en tablet (768px-1199px)
    - [ ] Tarjetas se ven bien en móvil (< 768px)
  - Verificación: Prueba manual en diferentes tamaños de ventana
  - Dependencias: Tarea 14
  - Archivos tocados: Ninguno (solo verificación)
  - Alcance: S

### Checkpoint: Integración Completa
- [ ] Nuevos proyectos visibles en el portfolio
- [ ] Responsive design funciona correctamente
- [ ] Consistencia con proyectos existentes

### Fase 6: Verificación Final

- [ ] **Tarea 16: Verificación completa del portfolio**
  - Descripción: Prueba final de todo el portfolio
  - Criterios de aceptación:
    - [ ] Todos los proyectos se muestran correctamente
    - [ ] Navegación funciona (enlaces internos)
    - [ ] Formulario de contacto funcional
    - [ ] Imágenes cargan correctamente
    - [ ] No hay errores de consola en navegador
  - Verificación: Prueba completa en navegador
  - Dependencias: Tarea 15
  - Archivos tocados: Ninguno (solo verificación)
  - Alcance: S

## Puntos de Verificación

### Después de Fase 2 (Script)
- [ ] Script PowerShell creado y funcional
- [ ] Todas las funciones pasan pruebas básicas
- [ ] Documentación de uso del script completada

### Después de Fase 3 (Extracción)
- [ ] Markdowns generados para todos los proyectos
- [ ] Información técnica completa en cada markdown
- [ ] Estructura de archivos correcta

### Después de Fase 5 (Integración)
- [ ] Portfolio actualizado con nuevos proyectos
- [ ] Responsive design verificado
- [ ] Consistencia visual mantenida

## Riesgos y Mitigaciones

| Riesgo | Impacto | Mitigación |
|--------|---------|------------|
| Script PowerShell falla en algunos archivos | Medio | Implementar manejo de errores robusto y logging |
| Imágenes no disponibles | Bajo | Generar placeholders descriptivos, usuario tomará capturas después |
| Incompatibilidad con CSS actual | Medio | Seguir patrones existentes, probar en navegador frecuentemente |
| Información incompleta en READMEs | Bajo | Análisis manual adicional del código fuente |

## Preguntas Abiertas

1. ¿El usuario tiene imágenes de estos proyectos o necesita generarlas?
2. ¿Hay enlaces de demo o código fuente disponibles para agregar?
3. ¿El usuario quiere agregar descripciones en español o inglés?

## Próximos Pasos Después del Plan

1. Aprobación del plan por el usuario
2. Inicio de implementación con Fase 1
3. Seguimiento del progreso en cada checkpoint
4. Ajustes según sea necesario durante la implementación
