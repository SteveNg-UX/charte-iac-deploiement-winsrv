Import-Module -Name ".\core\loader"
Import-Module -Name ".\core\logger"
Import-Module -Name ".\core\utils"



function Deployer-Service {
    $serveurs = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML '.\data\hotes.yaml').SERVEURS
    $service = $(Charger-DonneYAML -CHEMIN_FICHIER_YAML '.\data\deploiement-service.yaml').SERVICES

    Install-Module -Name 'Posh-SSH' -Force
    Import-Module -Name 'Posh-SSH'

    Foreach ($srv in $serveurs){
        Foreach ($dm in $service){
            if ($dm.NomServeurs -contains $srv.Nom){
                $Session = @{
                    HostName    = $srv.Nom
                    UserName    = $srv.Utilisateur
                    KeyFilePath = $srv.Cle_SSH
                }
                Invoke-Command -FilePath '.\modules\${dm.Role}.psm1' -SSHConnection $Session
            }
        }
    }
}