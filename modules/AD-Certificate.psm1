$DONNEE = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\AD-Certificate\donnee.yaml").DONNEE
$MDP_FICHIER_CERT = (Read-Host "Mot de passe utilisateur" -AsSecureString)

if ((Get-WindowsFeature -Name "AD-Certificate").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "AD-Certificate" -IncludeManagementTools -IncludeAllSubFeature
}

Import-Module -Name "ADCSDeployment"
Install-AdcsCertificationAuthority `
    -AllowAdministratorInteraction:$DONNEE.AllowAdministratorInteraction `
    -ValidityPeriod $DONNEE.ValidityPeriod `
    -ValidityPeriodUnits $DONNEE.ValidityPeriodUnits `
    -CACommonName $DONNEE.CACommonName `
    -CADistinguishedNameSuffix $DONNEE.CADistinguishedNameSuffix `
    -CAType $DONNEE.CAType `
    -CryptoProviderName $DONNEE.CryptoProviderName `
    -DatabaseDirectory $DONNEE.DatabaseDirectory `
    -HashAlgorithmName $DONNEE.HashAlgorithmName `
    -IgnoreUnicode:$DONNEE.IgnoreUnicode `
    -KeyLength $DONNEE.KeyLength `
    -LogDirectory $DONNEE.LogDirectory `
    -OutputCertRequestFile $DONNEE.OutputCertRequestFile `
    -OverwriteExistingCAinDS:$DONNEE.OverwriteExistingCAinDS `
    -OverwriteExistingKey:$DONNEE.OverwriteExistingKey `
    -ParentCA $DONNEE.ParentCA `
    -OverwriteExistingDatabase:$DONNEE.OverwriteExistingDatabase
    -CertFilePassword $MDP_FICHIER_CERT