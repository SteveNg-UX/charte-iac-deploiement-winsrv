$SAFE_PASSWORD = Read-Host("Mot de passe de secours : ")
$DATA = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\AD-Domain-Services\donnee.yaml").DONNEE

if ((Get-WindowsFeature -Name "AD-Domain-Services").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools -Force
}

Add-WindowsFeature -Name "AD-Domain-Services", "DNS", "RSAT-AD-Tools", "RSAT-RemoteAccess", "GPMC" -IncludeAllSubFeature
Import-Module ADDSDeployment
Install-ADDSForest `
    -CreateDnsDelegation:$false `
    -DatabasePath $DATA.Chemin_BDD `
    -DomainMode "Win2025" `
    -DomainName $DATA.Domaine `
    -DomainNetbiosName $DATA.Netbios `
    -ForestMode "Win2025" `
    -InstallDns:$true `
    -LogPath $DATA.Chemin_Journal `
    -NoRebootOnCompletion:$false `
    -SysvolPath $DATA.Chemin_Sysvol `
    -SafeModeAdministratorPassword (ConvertTo-SecureString $SAFE_PASSWORD -AsPlainText -Force) `
    -Force:$true