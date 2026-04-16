$DATA = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\WDS\donnee.yaml").DONNEE

if ((Get-WindowsFeature -Name "WDS").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "WDS" -IncludeManagementTools -Force
}