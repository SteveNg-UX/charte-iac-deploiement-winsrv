$DATA = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\Remote-Desktop-Services\donnee.yaml").DONNEE

if ((Get-WindowsFeature -Name "Remote-Desktop-Services").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "Remote-Desktop-Services" -IncludeManagementTools -Force
}