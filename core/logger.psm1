function Write-Log {
    param([string]$Message)
    $time = Get-Date -Format "dd-MM-yyyy HH:mm:ss"
    Write-Host "[$time] $Message"
}