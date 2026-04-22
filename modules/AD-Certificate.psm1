$DONNEE = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML "..\data\AD-Certificate\donnee.yaml").DONNEE
$MDP_FICHIER_CERT = (Read-Host "Mot de passe utilisateur" -AsSecureString)

if ((-not (Get-Command -Name "Get-ADDomain" -ErrorAction SilentlyContinue)) -and ($DONNEE.SRV_ADDS_ADDR -ne '')) {
    Set-DnsClientServerAddress -ServerAddresses $DONNEE.SRV_ADDS_ADDR -InterfaceAlias "Ethernet"
    Add-Computer -DomainName $DONNEE.CACommonName
}

if ((Get-WindowsFeature -Name "AD-Certificate").InstallState -ne 'Installed'){
    Install-WindowsFeature -Name "AD-Certificate" -IncludeManagementTools -IncludeAllSubFeature
}

Import-Module -Name "ADCSDeployment"

Switch -Exact ($DONNEE.CAType){
    'StandaloneRootCa' {
        $params = @{
            CAType = $DONNEE.CAType
            CryptoProviderName = $DONNEE.CryptoProviderName
            HashAlgorithmName = $DONNEE.HashAlgorithmName
            KeyLength = $DONNEE.KeyLength
            AllowAdministratorInteraction = $DONNEE.AllowAdministratorInteraction
            ValidityPeriod = $DONNEE.ValidityPeriod
            ValidityPeriodUnits = $DONNEE.ValidityPeriodUnits
            CADistinguishedNameSuffix = $DONNEE.CADistinguishedNameSuffix
            DatabaseDirectory = $DONNEE.DatabaseDirectory
            LogDirectory = $DONNEE.LogDirectory
        }
        Install-AdcsCertificationAuthority @params
    }
    'StandaloneSubordinateCA' {
        $params = @{
            CAType = $DONNEE.CAType
            CryptoProviderName = $DONNEE.CryptoProviderName
            HashAlgorithmName = $DONNEE.HashAlgorithmName
            KeyLength = $DONNEE.KeyLength
            AllowAdministratorInteraction = $DONNEE.AllowAdministratorInteraction
            CADistinguishedNameSuffix = $DONNEE.CADistinguishedNameSuffix
            DatabaseDirectory = $DONNEE.DatabaseDirectory
            LogDirectory = $DONNEE.LogDirectory
            ParentCA = $DONNEE.ParentCA
            OutputCertRequestFile = $DONNEE.OutputCertRequestFile
        }
        Install-AdcsCertificationAuthority @params
    }
    'EnterpriseRootCa' {
    }
    'EnterpriseSubordinateCa' {
        $params = @{
            AllowAdministratorInteraction = $DONNEE.AllowAdministratorInteraction
            ValidityPeriod = $DONNEE.ValidityPeriod
            ValidityPeriodUnits = $DONNEE.ValidityPeriodUnits
            CACommonName = $DONNEE.CACommonName
            CADistinguishedNameSuffix = $DONNEE.CADistinguishedNameSuffix
            CAType = $DONNEE.CAType
            CryptoProviderName = $DONNEE.CryptoProviderName
            DatabaseDirectory = $DONNEE.DatabaseDirectory
            HashAlgorithmName = $DONNEE.HashAlgorithmName
            IgnoreUnicode = $DONNEE.IgnoreUnicode
            KeyLength = $DONNEE.KeyLength
            LogDirectory = $DONNEE.LogDirectory
            OutputCertRequestFile = $DONNEE.OutputCertRequestFile
            OverwriteExistingCAinDS = $DONNEE.OverwriteExistingCAinDS
            OverwriteExistingKey = $DONNEE.OverwriteExistingKey
            ParentCA = $DONNEE.ParentCA
            OverwriteExistingDatabase = $DONNEE.OverwriteExistingDatabase
            CertFilePassword = $MDP_FICHIER_CERT
        }
        Install-AdcsCertificationAuthority @params
    }
}