<#
Loo kasutajatele kasutaja nimi ja emaili aadress
Kasutajanimi ei sisalda täpitähti. Kasutajanimi on
eesnimi.perenimi  Eesnimes olev tühik ja sidekriips eemaldada.
Kasutaja nimi on väikeste tähtedega.
EMail on kasutajanimi@juhe.metsas.ee
Tulemus uude faili ja vanast failist ainult Eesnimi; Perenimi; Sünniaeg
Uued veerud on Kasutajanimi; Email
#>

$src = Join-Path -Path $PSScriptRoot -ChildPath "Persons.csv"
$dst = Join-Path -Path $PSScriptRoot -ChildPath "Persons_account.csv"
$domain = "@juhe.metsas.ee"
$heading = "Eesnimi;Perenimi;Sünniaeg;Kasutajanimi;EMail"

function Remove-Diacritics {
    param ([String]$src = [String]::Empty)
    $normalized = $src.Normalize( [Text.NormalizationForm]::FormD )
    $sb = new-object Text.StringBuilder
    $normalized.ToCharArray() | % { 
        if( [Globalization.CharUnicodeInfo]::GetUnicodeCategory($_) -ne [Globalization.UnicodeCategory]::NonSpacingMark) {
            [void]$sb.Append($_)
        }
    }
    $sb.ToString()
}

#Kustuta uus fail kui on olemas
if(Test-Path $dst){
    Remove-Item -Path $dst
}
#Kirjutame uude faili päise
Out-File -FilePath $dst -Append -InputObject $heading

# loeme originaal csv faili
Import-Csv $src -Delimiter ";" | ForEach-Object {  # import csv eeldab et andmetel on päis olemas
    $first_name = $_.Eesnimi
    $last_name = $_.Perenimi
    #Write-Host $_ # Test  kirjutab konsooli kogu tabeli sisu

    # Eemaldame eesnimest tühiku ja side kriipsu
    $first_name = $first_name -replace " ", ""
    $first_name = $first_name -replace "-", ""

    # Loome kasutaja nime
    $username = Remove-Diacritics($first_name + "." + $last_name).ToLower()

    # Teeme e-maili
    $email = $username + $domain
    
    # Teeme massiivi
    $array = $_.Eesnimi, $_.Perenimi, $_.Sünniaeg, $username, $email
    # Teeme uue rea
    $new_line = $array -join ";"

    # Kirjuta rida faili
    Out-File -FilePath $dst -Append -InputObject $new_line
}

