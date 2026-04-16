$DATA = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\ADFS-Federation\donnee.yaml").DONNEE

if ((Get-WindowsFeature -Name "ADFS-Federation").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "ADFS-Federation" -IncludeManagementTools -Force
}