$DONNEE = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\AD-Domain-Services\donnee.yaml").DONNEE
$MDP_SECOURS = (Read-Host "Mot de passe de secours" -AsSecureString)

if ((Get-WindowsFeature -Name "AD-Domain-Services").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools -IncludeAllSubFeature
}

Import-Module -Name "ADDSDeployment"
Install-ADDSForest `
    -CreateDnsDelegation:$false `
    -DatabasePath $DONNEE.Chemin_BDD `
    -DomainMode "Win2025" `
    -DomainName $DONNEE.Domaine `
    -DomainNetbiosName $DONNEE.Netbios `
    -ForestMode "Win2025" `
    -InstallDns:$true `
    -LogPath $DONNEE.Chemin_Journal `
    -NoRebootOnCompletion:$false `
    -SysvolPath $DONNEE.Chemin_Sysvol `
    -SafeModeAdministratorPassword (ConvertTo-SecureString $MDP_SECOURS -AsPlainText -Force) `
    -Force:$true