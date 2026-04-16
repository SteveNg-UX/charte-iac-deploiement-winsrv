$DATA = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\VolumeActivation\donnee.yaml").DONNEE

if ((Get-WindowsFeature -Name "VolumeActivation").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "VolumeActivation" -IncludeManagementTools -Force
}