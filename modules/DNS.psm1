$DATA = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\DNS\donnee.yaml").DONNEE

if ((Get-WindowsFeature -Name "DNS").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "DNS" -IncludeManagementTools -Force
}