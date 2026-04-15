functionfunction Charger-DonneYAML {
    param(
        [String]$CHEMIN_FICHIER_YAML = ".\data.yaml"
    )
    try {
        return Get-Content -Path $CHEMIN_FICHIER_YAML | ConvertFrom-Yaml
    }
    catch {
        Write-Host $_
    }
}