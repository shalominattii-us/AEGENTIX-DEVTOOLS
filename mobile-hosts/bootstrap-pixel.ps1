$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "$root/pixel"

Write-Host 'AEGENTIX Pixel build bootstrap' -ForegroundColor Cyan
if (-not $env:JAVA_HOME) { Write-Warning 'JAVA_HOME is not set. Android Studio can supply JDK 17; set JAVA_HOME to that JDK before running Gradle.' }
if (Get-Command java -ErrorAction SilentlyContinue) { java -version }
if (Get-Command adb -ErrorAction SilentlyContinue) { adb version }
if (Test-Path '.\gradlew.bat') { .\gradlew.bat :app:assembleDebug }
else { Write-Warning 'Gradle wrapper is not checked in yet. Generate it with Gradle 9.1.0 or Android Studio, then rerun.' }
