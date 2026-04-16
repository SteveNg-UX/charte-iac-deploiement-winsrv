$DATA = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\AD-Certificate\donnee.yaml").DONNEE

if ((Get-WindowsFeature -Name "AD-Certificate").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "AD-Certificate" -IncludeManagementTools -Force
}