# extract-all-projects.ps1
# Script principal para extraer información de todos los proyectos pendientes

# Cargar funciones de extracción
. "C:/xampp/htdocs/Portfolio/Portfolio-Mikel/scripts/extract-project-info.ps1"

# Configuración
$projectsPath = "C:/xampp/htdocs/Portfolio/Portfolio-Mikel/Proyectos pendientes"
$outputPath = "C:/xampp/htdocs/Portfolio/Portfolio-Mikel/project-images"

# Crear directorio de salida si no existe
if (-not (Test-Path $outputPath)) {
    New-Item -ItemType Directory -Path $outputPath -Force | Out-Null
}

Write-Host "=== Extracción de Proyectos para Portfolio ===" -ForegroundColor Cyan
Write-Host ""

# Proyecto 1: ValaquiaStore
Write-Host "Procesando ValaquiaStore..." -ForegroundColor Yellow
$valaquiaPath = Join-Path $projectsPath "ValaquiaStore"

# Extraer README
$valaquiaReadme = Extract-ReadmeContent -Path $valaquiaPath -Verbose
if ($valaquiaReadme.Found) {
    Write-Host "  ✓ README encontrado" -ForegroundColor Green
} else {
    Write-Host "  ✗ README no encontrado, usando descripción por defecto" -ForegroundColor Yellow
}

# Analizar build files
$valaquiaBuild = Analyze-BuildFiles -Path $valaquiaPath
Write-Host "  ✓ Tecnologías: $($valaquiaBuild.Technologies.Count)" -ForegroundColor Green

# Buscar características
$valaquiaFeatures = Find-ProjectFeatures -Path $valaquiaPath
Write-Host "  ✓ Características: $($valaquiaFeatures.Count)" -ForegroundColor Green

# Buscar imágenes
$valaquiaImages = Get-ProjectImages -Path $valaquiaPath
Write-Host "  ✓ Imágenes: $($valaquiaImages.Count)" -ForegroundColor Green

# Generar descripción completa
$valaquiaDescription = @"
Aplicación completa de tienda de juegos desarrollada como proyecto académico. Consta de un cliente Android para dispositivos móviles y un servidor Spring Boot para la API REST. Incluye funcionalidades de catálogo de juegos, consejos de salud vinculados a cada juego, y sistema de descarga segura con verificación de integridad.

### Componentes Principales
- **Cliente Android:** Aplicación móvil con interfaz Material Design, consumo de API REST con Retrofit, y gestión de imágenes con Glide
- **Servidor Spring Boot:** API REST con Java 22, endpoints para gestión de juegos y consejos de salud
- **Funcionalidades:** Catálogo de juegos, consejos de salud, descarga de archivos con verificación SHA-256
"@

# Generar markdown
$valaquiaMarkdown = Generate-ProjectMarkdown -ProjectName "ValaquiaStore" -Description $valaquiaDescription -TechStack $valaquiaBuild.Technologies -Features $valaquiaFeatures -Images $valaquiaImages

# Guardar markdown
$valaquiaMarkdownPath = Join-Path $outputPath "valaquiastore.md"
$valaquiaMarkdown | Out-File -FilePath $valaquiaMarkdownPath -Encoding UTF8
Write-Host "  ✓ Markdown guardado en: $valaquiaMarkdownPath" -ForegroundColor Green

Write-Host ""

# Proyecto 2: Reto_Libreria (Web)
Write-Host "Procesando Reto_Libreria (Web)..." -ForegroundColor Yellow
$retoLibreriaPath = Join-Path $projectsPath "Reto_Libreria"

# Extraer README
$retoLibreriaReadme = Extract-ReadmeContent -Path $retoLibreriaPath -Verbose
if ($retoLibreriaReadme.Found) {
    Write-Host "  ✓ README encontrado" -ForegroundColor Green
} else {
    Write-Host "  ✗ README no encontrado, usando descripción por defecto" -ForegroundColor Yellow
}

# Analizar build files
$retoLibreriaBuild = Analyze-BuildFiles -Path $retoLibreriaPath
Write-Host "  ✓ Tecnologías: $($retoLibreriaBuild.Technologies.Count)" -ForegroundColor Green

# Buscar características
$retoLibreriaFeatures = Find-ProjectFeatures -Path $retoLibreriaPath
Write-Host "  ✓ Características: $($retoLibreriaFeatures.Count)" -ForegroundColor Green

# Buscar imágenes
$retoLibreriaImages = Get-ProjectImages -Path $retoLibreriaPath
Write-Host "  ✓ Imágenes: $($retoLibreriaImages.Count)" -ForegroundColor Green

# Proyecto 3: Reto2_Libreria (Desktop)
Write-Host "Procesando Reto2_Libreria (Desktop)..." -ForegroundColor Yellow
$reto2LibreriaPath = Join-Path $projectsPath "Reto2_Libreria"

# Extraer README
$reto2LibreriaReadme = Extract-ReadmeContent -Path $reto2LibreriaPath -Verbose
if ($reto2LibreriaReadme.Found) {
    Write-Host "  ✓ README encontrado" -ForegroundColor Green
} else {
    Write-Host "  ✗ README no encontrado, usando descripción por defecto" -ForegroundColor Yellow
}

# Analizar build files
$reto2LibreriaBuild = Analyze-BuildFiles -Path $reto2LibreriaPath
Write-Host "  ✓ Tecnologías: $($reto2LibreriaBuild.Technologies.Count)" -ForegroundColor Green

# Buscar características
$reto2LibreriaFeatures = Find-ProjectFeatures -Path $reto2LibreriaPath
Write-Host "  ✓ Características: $($reto2LibreriaFeatures.Count)" -ForegroundColor Green

# Buscar imágenes
$reto2LibreriaImages = Get-ProjectImages -Path $reto2LibreriaPath
Write-Host "  ✓ Imágenes: $($reto2LibreriaImages.Count)" -ForegroundColor Green

# Combinar tecnologías de ambas versiones
$allTech = @($retoLibreriaBuild.Technologies) + @($reto2LibreriaBuild.Technologies) | Select-Object -Unique
$allFeatures = @($retoLibreriaFeatures) + @($reto2LibreriaFeatures) | Select-Object -Unique
$allImages = @($retoLibreriaImages) + @($reto2LibreriaImages

# Si no se encontraron tecnologías, usar lista por defecto
if ($allTech.Count -eq 0) {
    $allTech = @("PHP", "JavaFX", "MySQL", "HTML5", "CSS3", "JavaScript", "MVC", "API REST")
}

# Generar descripción unificada
$retoLibreriaDescription = @"
Sistema completo de gestión de librería desarrollado en dos versiones: una aplicación web con PHP y una aplicación de escritorio con JavaFX. Ambas versiones comparten la misma base de datos MySQL y funcionalidades, pero están optimizadas para sus respectivos entornos.

### Versión Web (PHP)
- Arquitectura MVC limpia con API REST
- Frontend con HTML5, CSS3 y JavaScript
- Contrato JSON consistente: `{status, code, message, data}`
- Seguridad: password_hash, password_verify, session_regenerate_id
- Cliente web: apiFetch() común para llamadas API

### Versión Desktop (JavaFX)
- Interfaz gráfica con FXML
- Connection pooling con DBCP2
- Mismas funcionalidades que la versión web
- Optimizada para entorno de escritorio

### Características Comunes
- Base de datos MySQL compartida
- Procedimientos almacenados
- Gestión de usuarios y autenticación
- CRUD completo de libros y usuarios
"@

# Generar markdown unificado
$retoLibreriaMarkdown = Generate-ProjectMarkdown -ProjectName "Reto Librería - Sistema de Gestión" -Description $retoLibreriaDescription -TechStack $allTech -Features $allFeatures -Images $allImages

# Guardar markdown
$retoLibreriaMarkdownPath = Join-Path $outputPath "reto-libreria.md"
$retoLibreriaMarkdown | Out-File -FilePath $retoLibreriaMarkdownPath -Encoding UTF8
Write-Host "  ✓ Markdown unificado guardado en: $retoLibreriaMarkdownPath" -ForegroundColor Green

Write-Host ""
Write-Host "=== Extracción completada ===" -ForegroundColor Cyan
Write-Host "Archivos generados:" -ForegroundColor White
Write-Host "  1. $valaquiaMarkdownPath" -ForegroundColor Gray
Write-Host "  2. $retoLibreriaMarkdownPath" -ForegroundColor Gray
Write-Host ""
Write-Host "Próximos pasos:" -ForegroundColor Yellow
Write-Host "  1. Revisar los archivos markdown generados" -ForegroundColor Gray
Write-Host "  2. Tomar capturas de pantalla de cada proyecto" -ForegroundColor Gray
Write-Host "  3. Actualizar el index.html con los nuevos proyectos" -ForegroundColor Gray
