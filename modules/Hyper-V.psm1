$DATA = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\Hyper-V\donnee.yaml").DONNEE

if ((Get-WindowsFeature -Name "Hyper-V").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "Hyper-V" -IncludeManagementTools -Force
}