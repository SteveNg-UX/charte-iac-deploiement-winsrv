$DATA = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\Web-Server\donnee.yaml").DONNEE

if ((Get-WindowsFeature -Name "Web-Server").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "Web-Server" -IncludeManagementTools -Force
}