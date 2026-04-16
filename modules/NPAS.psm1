$DATA = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\NPAS\donnee.yaml").DONNEE

if ((Get-WindowsFeature -Name "NPAS").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "NPAS" -IncludeManagementTools -Force
}