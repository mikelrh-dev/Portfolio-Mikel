# generate-reto-libreria.ps1
# Script para generar el markdown de Reto Librería

$description = @"
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

$techStack = @(
    "PHP",
    "JavaFX",
    "MySQL",
    "HTML5",
    "CSS3",
    "JavaScript",
    "MVC",
    "API REST",
    "FXML",
    "DBCP2",
    "Connection Pooling",
    "Password Hashing",
    "Session Management"
)

$features = @(
    "Arquitectura MVC limpia (API → Controller → DAO → Entities)",
    "Contrato JSON consistente: {status, code, message, data}",
    "Seguridad: password_hash, password_verify, session_regenerate_id",
    "Validación de uploads (extensión, tamaño, MIME real)",
    "Cliente web: apiFetch() común para llamadas API",
    "Cliente desktop: Connection pooling con DBCP2",
    "Gestión de usuarios y autenticación",
    "CRUD completo de libros y usuarios",
    "Base de datos MySQL compartida",
    "Procedimientos almacenados"
)

# Generar markdown
$markdown = @"
# Reto Librería - Sistema de Gestión

## Descripción

$description

## Tech Stack

"@

foreach ($tech in $techStack) {
    $markdown += "- $tech`n"
}

$markdown += "`n## Características Clave`n`n"

foreach ($feature in $features) {
    $markdown += "- $feature`n"
}

$markdown += @"

## Imágenes

*Las imágenes de las pantallas de la aplicación se agregarán después de tomar capturas de pantalla.*

### Versión Web
![Vista web de la librería](placeholder-web.jpg)

### Versión Desktop
![Vista desktop de la librería](placeholder-desktop.jpg)
"@

# Guardar markdown
$outputPath = "C:/xampp/htdocs/Portfolio/Portfolio-Mikel/project-images/reto-libreria.md"
$markdown | Out-File -FilePath $outputPath -Encoding UTF8

Write-Host "Markdown generado exitosamente en: $outputPath" -ForegroundColor Green
Write-Host "Tamaño del archivo: $((Get-Item $outputPath).Length) bytes" -ForegroundColor Gray
