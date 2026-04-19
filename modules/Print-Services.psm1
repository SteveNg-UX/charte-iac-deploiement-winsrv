$DATA = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\Print-Services\donnee.yaml").DONNEE

if ((Get-WindowsFeature -Name "Print-Services").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "Print-Services" -IncludeManagementTools -IncludeAllSubFeature
}