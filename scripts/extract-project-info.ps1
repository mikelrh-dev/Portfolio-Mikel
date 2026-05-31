# extract-project-info.ps1
# Script para extraer información de proyectos y generar markdown para el portfolio

function Extract-ReadmeContent {
    <#
    .SYNOPSIS
    Extrae contenido de archivos README de un directorio
    
    .DESCRIPTION
    Busca archivos README.md, Readme.md, readme.md en el directorio especificado
    y extrae su contenido completo
    
    .PARAMETER Path
    Ruta del directorio donde buscar el README
    
    .EXAMPLE
    Extract-ReadmeContent -Path "C:\proyectos\mi-proyecto"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )
    
    # Buscar archivos README con búsqueda case-insensitive
    $readmeFiles = Get-ChildItem -Path $Path -Filter "readme*" -File -Recurse -Depth 3 -ErrorAction SilentlyContinue | 
        Where-Object { $_.Name -match "readme\.(md|txt)$" -or $_.Name -match "README\.(md|txt)$" }
    
    foreach ($readmeFile in $readmeFiles) {
        try {
            $content = Get-Content -Path $readmeFile.FullName -Raw -Encoding UTF8 -ErrorAction Stop
            Write-Verbose "README encontrado: $($readmeFile.FullName)"
            return @{
                Path = $readmeFile.FullName
                Content = $content
                Found = $true
            }
        }
        catch {
            Write-Warning "Error al leer $($readmeFile.FullName): $_"
        }
    }
    
    # Si no se encontró ningún README
    Write-Verbose "No se encontró README en $Path"
    return @{
        Path = $null
        Content = $null
        Found = $false
    }
}

function Analyze-BuildFiles {
    <#
    .SYNOPSIS
    Analiza archivos de build para extraer dependencias y tecnologías
    
    .DESCRIPTION
    Detecta y analiza build.gradle.kts, pom.xml, package.json para extraer
    la lista de tecnologías y dependencias utilizadas
    
    .PARAMETER Path
    Ruta del directorio del proyecto
    
    .EXAMPLE
    Analyze-BuildFiles -Path "C:\proyectos\mi-proyecto"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )
    
    $technologies = @()
    $dependencies = @()
    
    # Buscar build.gradle.kts (Android/Java)
    $gradleFiles = Get-ChildItem -Path $Path -Filter "build.gradle.kts" -Recurse -Depth 3 -ErrorAction SilentlyContinue
    
    foreach ($gradleFile in $gradleFiles) {
        try {
            $content = Get-Content -Path $gradleFile.FullName -Raw -Encoding UTF8 -ErrorAction Stop
            
            # Extraer plugins
            if ($content -match "plugins\s*\{([^}]+)\}") {
                $pluginsBlock = $Matches[1]
                if ($pluginsBlock -match "android\.application") {
                    $technologies += "Android"
                }
                if ($pluginsBlock -match "kotlin") {
                    $technologies += "Kotlin"
                }
            }
            
            # Extraer dependencias
            if ($content -match "dependencies\s*\{([^}]+)\}") {
                $depsBlock = $Matches[1]
                $depMatches = [regex]::Matches($depsBlock, 'implementation\("([^"]+)"\)')
                foreach ($dep in $depMatches) {
                    $depString = $dep.Groups[1].Value
                    if ($depString -match "retrofit") {
                        $technologies += "Retrofit"
                    }
                    if ($depString -match "glide") {
                        $technologies += "Glide"
                    }
                    if ($depString -match "appcompat") {
                        $technologies += "AndroidX"
                    }
                    if ($depString -match "material") {
                        $technologies += "Material Design"
                    }
                }
            }
            
            $dependencies += "Gradle"
        }
        catch {
            Write-Warning "Error al leer $($gradleFile.FullName): $_"
        }
    }
    
    # Buscar pom.xml (Maven/Spring Boot)
    $pomFiles = Get-ChildItem -Path $Path -Filter "pom.xml" -Recurse -Depth 3 -ErrorAction SilentlyContinue
    
    foreach ($pomFile in $pomFiles) {
        try {
            $content = Get-Content -Path $pomFile.FullName -Raw -Encoding UTF8 -ErrorAction Stop
            
            # Detectar Spring Boot
            if ($content -match "spring-boot-starter") {
                $technologies += "Spring Boot"
            }
            
            # Detectar Java version
            if ($content -match "<java\.version>(\d+)</java\.version>") {
                $javaVersion = $Matches[1]
                $technologies += "Java $javaVersion"
            }
            
            # Detectar dependencias principales
            if ($content -match "spring-boot-starter-web") {
                $technologies += "Spring Web"
            }
            if ($content -match "spring-boot-starter-data-jpa") {
                $technologies += "Spring Data JPA"
            }
            if ($content -match "mysql-connector") {
                $technologies += "MySQL"
            }
            
            $dependencies += "Maven"
        }
        catch {
            Write-Warning "Error al leer $($pomFile.FullName): $_"
        }
    }
    
    # Buscar package.json (Node.js)
    $packageFiles = Get-ChildItem -Path $Path -Filter "package.json" -Recurse -Depth 3 -ErrorAction SilentlyContinue
    
    foreach ($packageFile in $packageFiles) {
        try {
            $content = Get-Content -Path $packageFile.FullName -Raw -Encoding UTF8 -ErrorAction Stop
            $packageJson = $content | ConvertFrom-Json
            
            # Extraer dependencias
            if ($packageJson.dependencies) {
                $deps = $packageJson.dependencies.PSObject.Properties
                foreach ($dep in $deps) {
                    if ($dep.Name -match "react") {
                        $technologies += "React"
                    }
                    if ($dep.Name -match "vue") {
                        $technologies += "Vue.js"
                    }
                    if ($dep.Name -match "angular") {
                        $technologies += "Angular"
                    }
                    if ($dep.Name -match "express") {
                        $technologies += "Express.js"
                    }
                }
            }
            
            $dependencies += "npm"
        }
        catch {
            Write-Warning "Error al leer $($packageFile.FullName): $_"
        }
    }
    
    # Buscar composer.json (PHP)
    $composerFiles = Get-ChildItem -Path $Path -Filter "composer.json" -Recurse -Depth 3 -ErrorAction SilentlyContinue
    
    foreach ($composerFile in $composerFiles) {
        try {
            $content = Get-Content -Path $composerFile.FullName -Raw -Encoding UTF8 -ErrorAction Stop
            $composerJson = $content | ConvertFrom-Json
            
            if ($composerJson.require) {
                $deps = $composerJson.require.PSObject.Properties
                foreach ($dep in $deps) {
                    if ($dep.Name -match "php") {
                        $technologies += "PHP"
                    }
                    if ($dep.Name -match "laravel") {
                        $technologies += "Laravel"
                    }
                }
            }
            
            $dependencies += "Composer"
        }
        catch {
            Write-Warning "Error al leer $($composerFile.FullName): $_"
        }
    }
    
    # Eliminar duplicados
    $technologies = $technologies | Select-Object -Unique
    $dependencies = $dependencies | Select-Object -Unique
    
    return @{
        Technologies = $technologies
        Dependencies = $dependencies
    }
}

function Find-ProjectFeatures {
    <#
    .SYNOPSIS
    Busca palabras clave en el código fuente para identificar características
    
    .DESCRIPTION
    Analiza archivos de código fuente para encontrar patrones y características
    comunes del proyecto
    
    .PARAMETER Path
    Ruta del directorio del proyecto
    
    .EXAMPLE
    Find-ProjectFeatures -Path "C:\proyectos\mi-proyecto"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )
    
    $features = @()
    
    # Patrones de búsqueda con sus descripciones (usando strings simples en lugar de regex)
    $patterns = @{
        "MVC" = @{
            Patterns = @("Controller", "Model", "View", "MVC")
            Description = "Arquitectura MVC"
        }
        "API" = @{
            Patterns = @("api/", "API", "endpoint", "REST", "fetch(", "axios")
            Description = "API REST"
        }
        "Authentication" = @{
            Patterns = @("login", "auth", "session", "token", "password")
            Description = "Autenticación"
        }
        "Database" = @{
            Patterns = @("SELECT", "INSERT", "UPDATE", "DELETE", "query", "database", "mysql", "postgresql")
            Description = "Base de datos"
        }
        "CRUD" = @{
            Patterns = @("create", "read", "update", "delete", "findAll", "findById")
            Description = "Operaciones CRUD"
        }
        "Security" = @{
            Patterns = @("password_hash", "password_verify", "hash", "encrypt", "decrypt", "sha256")
            Description = "Seguridad"
        }
        "FileUpload" = @{
            Patterns = @("upload", "file", "multipart", "image")
            Description = "Subida de archivos"
        }
        "Async" = @{
            Patterns = @("async", "await", "Thread", "Promise", "Observable")
            Description = "Programación asíncrona"
        }
        "ConnectionPool" = @{
            Patterns = @("pool", "connection", "DataSource", "DBCP")
            Description = "Pool de conexiones"
        }
        "JavaFX" = @{
            Patterns = @("FXML", "Stage", "Scene", " javafx.")
            Description = "JavaFX"
        }
        "Android" = @{
            Patterns = @("Activity", "Fragment", "Intent", "AndroidManifest")
            Description = "Android"
        }
        "Spring" = @{
            Patterns = @("Spring", "Controller", "Service", "Repository")
            Description = "Spring Framework"
        }
        "PHP" = @{
            Patterns = @("$_GET", "$_POST", "$_SESSION", "php")
            Description = "PHP"
        }
        "MySQL" = @{
            Patterns = @("mysql", "MySQL", "CREATE TABLE", "ALTER TABLE")
            Description = "MySQL"
        }
    }
    
    # Buscar archivos de código fuente
    $codeExtensions = @("*.java", "*.php", "*.js", "*.ts", "*.py", "*.cs", "*.fxml", "*.xml")
    $codeFiles = @()
    
    foreach ($ext in $codeExtensions) {
        $foundFiles = Get-ChildItem -Path $Path -Filter $ext -Recurse -File -ErrorAction SilentlyContinue
        $codeFiles += $foundFiles
    }
    
    # Analizar cada archivo
    foreach ($file in $codeFiles) {
        try {
            $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8 -ErrorAction Stop
            
            foreach ($featureKey in $patterns.Keys) {
                $featureInfo = $patterns[$featureKey]
                $found = $false
                
                foreach ($pattern in $featureInfo.Patterns) {
                    if ($content -match [regex]::Escape($pattern)) {
                        $found = $true
                        break
                    }
                }
                
                if ($found) {
                    $features += @{
                        Key = $featureKey
                        Description = $featureInfo.Description
                        File = $file.Name
                    }
                }
            }
        }
        catch {
            Write-Warning "Error al leer $($file.FullName): $_"
        }
    }
    
    # Eliminar duplicados y retornar características únicas
    $uniqueFeatures = @()
    $seenKeys = @{}
    
    foreach ($feature in $features) {
        if (-not $seenKeys.ContainsKey($feature.Key)) {
            $seenKeys[$feature.Key] = $true
            $uniqueFeatures += $feature.Description
        }
    }
    
    return $uniqueFeatures | Select-Object -Unique
}

function Get-ProjectImages {
    <#
    .SYNOPSIS
    Busca imágenes existentes en el proyecto
    
    .DESCRIPTION
    Busca archivos de imagen (.jpg, .png, .gif, .svg) en el directorio del proyecto
    
    .PARAMETER Path
    Ruta del directorio del proyecto
    
    .EXAMPLE
    Get-ProjectImages -Path "C:\proyectos\mi-proyecto"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )
    
    $imageExtensions = @("*.jpg", "*.jpeg", "*.png", "*.gif", "*.svg", "*.bmp")
    $images = @()
    
    foreach ($ext in $imageExtensions) {
        $foundImages = Get-ChildItem -Path $Path -Filter $ext -Recurse -File -ErrorAction SilentlyContinue
        
        foreach ($image in $foundImages) {
            # Excluir imágenes de node_modules, .git, y otros directorios no relevantes
            if ($image.FullName -notmatch "node_modules|\.git|bin|obj|target|build|dist") {
                $images += @{
                    Path = $image.FullName
                    Name = $image.Name
                    Size = $image.Length
                }
            }
        }
    }
    
    return $images
}

function Generate-ProjectMarkdown {
    <#
    .SYNOPSIS
    Genera markdown estructurado para un proyecto
    
    .DESCRIPTION
    Combina toda la información extraída en un archivo markdown formateado
    
    .PARAMETER ProjectName
    Nombre del proyecto
    
    .PARAMETER Description
    Descripción del proyecto
    
    .PARAMETER TechStack
    Array de tecnologías utilizadas
    
    .PARAMETER Features
    Array de características del proyecto
    
    .PARAMETER Architecture
    Descripción de la arquitectura
    
    .PARAMETER Images
    Array de imágenes encontradas
    
    .EXAMPLE
    Generate-ProjectMarkdown -ProjectName "Mi Proyecto" -Description "Descripción" -TechStack @("Java", "MySQL")
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ProjectName,
        
        [Parameter(Mandatory = $true)]
        [string]$Description,
        
        [Parameter(Mandatory = $true)]
        [array]$TechStack,
        
        [Parameter(Mandatory = $false)]
        [array]$Features = @(),
        
        [Parameter(Mandatory = $false)]
        [string]$Architecture = "",
        
        [Parameter(Mandatory = $false)]
        [array]$Images = @()
    )
    
    # Construir markdown
    $markdown = @"
# $ProjectName

## Descripción

$Description

## Tech Stack

"@
    
    # Agregar tecnologías
    foreach ($tech in $TechStack) {
        $markdown += "- $tech`n"
    }
    
    # Agregar características si existen
    if ($Features.Count -gt 0) {
        $markdown += "`n## Características Clave`n`n"
        foreach ($feature in $Features) {
            $markdown += "- $feature`n"
        }
    }
    
    # Agregar arquitectura si existe
    if ($Architecture) {
        $markdown += "`n## Arquitectura`n`n$Architecture`n"
    }
    
    # Agregar imágenes si existen
    if ($Images.Count -gt 0) {
        $markdown += "`n## Imágenes`n`n"
        foreach ($image in $Images) {
            $markdown += "![$($image.Name)]($($image.Path))`n`n"
        }
    }
    
    return $markdown
}

# Las funciones están disponibles para uso cuando se carga el script con dot-sourcing
