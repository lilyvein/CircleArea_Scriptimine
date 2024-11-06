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
$line_nr = 0 # failist ridade lugemiseks

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

$contents = Get-Content $src -Encoding UTF8

foreach($line in $contents){
    if($line_nr -gt 0) {
    $parts = $line.Split(";") # tulemuseks on massiiv
    $first_name = $parts[0]
    $last_name = $parts[1]

    $first_name = $first_name -replace " ", ""
    $first_name = $first_name -replace "-", ""

    $username = Remove-Diacritics($first_name + "." + $last_name).ToLower()

    $email = $username + $domain
    
    $array = $parts[0], $parts[1], $parts[2], $username, $email
    $new_line = $array -join ";"

    #Write-Host $new_line
    Out-File -FilePath $dst -Append -InputObject $new_line
    }
    $line_nr++
}