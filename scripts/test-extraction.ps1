# test-extraction.ps1
# Script de prueba para verificar que las funciones de extracción funcionan

# Cargar el script principal
. "C:/xampp/htdocs/Portfolio/Portfolio-Mikel/scripts/extract-project-info.ps1"

Write-Host "Probando extracción de README para ValaquiaStore..." -ForegroundColor Yellow

# Probar extracción de README
$readmeResult = Extract-ReadmeContent -Path "C:/xampp/htdocs/Portfolio/Portfolio-Mikel/Proyectos pendientes/ValaquiaStore" -Verbose

if ($readmeResult.Found) {
    Write-Host "✓ README encontrado en: $($readmeResult.Path)" -ForegroundColor Green
    Write-Host "  Tamaño del contenido: $($readmeResult.Content.Length) caracteres" -ForegroundColor Gray
} else {
    Write-Host "✗ No se encontró README" -ForegroundColor Red
}

Write-Host "`nProbando análisis de build files..." -ForegroundColor Yellow

# Probar análisis de build files
$buildResult = Analyze-BuildFiles -Path "C:/xampp/htdocs/Portfolio/Portfolio-Mikel/Proyectos pendientes/ValaquiaStore" -Verbose

Write-Host "Tecnologías encontradas: $($buildResult.Technologies.Count)" -ForegroundColor Green
foreach ($tech in $buildResult.Technologies) {
    Write-Host "  - $tech" -ForegroundColor Gray
}

Write-Host "Dependencias encontradas: $($buildResult.Dependencies.Count)" -ForegroundColor Green
foreach ($dep in $buildResult.Dependencies) {
    Write-Host "  - $dep" -ForegroundColor Gray
}

Write-Host "`nProbando búsqueda de características..." -ForegroundColor Yellow

# Probar búsqueda de características
$featuresResult = Find-ProjectFeatures -Path "C:/xampp/htdocs/Portfolio/Portfolio-Mikel/Proyectos pendientes/ValaquiaStore" -Verbose

Write-Host "Características encontradas: $($featuresResult.Count)" -ForegroundColor Green
foreach ($feature in $featuresResult) {
    Write-Host "  - $feature" -ForegroundColor Gray
}

Write-Host "`nProbando generación de markdown..." -ForegroundColor Yellow

# Probar generación de markdown
$markdown = Generate-ProjectMarkdown -ProjectName "ValaquiaStore" -Description "Tienda de juegos Android con servidor Spring Boot" -TechStack $buildResult.Technologies -Features $featuresResult

Write-Host "Markdown generado con $($markdown.Length) caracteres" -ForegroundColor Green
Write-Host "`nPrimeras 500 caracteres del markdown:" -ForegroundColor Yellow
Write-Host $markdown.Substring(0, [Math]::Min(500, $markdown.Length)) -ForegroundColor Gray

Write-Host "`n✓ Pruebas completadas exitosamente" -ForegroundColor Green
