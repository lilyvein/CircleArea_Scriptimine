#Administraatorina
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
Get-Date
$username = Read-Host -Prompt "Sisesta kasutajanimi" # Palub kasutajal sisestada väärtuse. -Prompt annab sõnumi, mida kuvatakse kasutajale ("Sisesta kasutajanimi").
if($username -eq $env:USERNAME){    # $env: See on keskkonnamuutuja, mis sisaldab praeguse kasutaja nime.
    Write-Host "Õige kasutajanimi"
} else {
    Write-Host "Vale kasutajanimi $username"
}
[int]$year = Read-Host "Sisesta aasta" # Read-Host küsib aastaarvu ja salvestab selle muutujasse $year, teisendades selle täisarvuks ([int]).
if($year -eq (Get-Date).Year) { # Kontrollitakse, kas sisestatud aasta ($year) on võrdne praeguse aastaga ((Get-Date).Year). 
    Write-Host "Käesolev aasta"
} else {
    Write-Host "Mõni teine aasta $year"
}

$numbers = @() # @(): Loob tühja massiivi ($numbers).
# +=: Lisab massiivi väärtusi (5, 43, 23, 432), et saada lõpuks massiiv [5, 43, 23, 432].
$numbers += 5
$numbers += 43
$numbers += 23
$numbers += 432

$number = 0
$number += 5
$number += 2
Write-Host $numners # Näitab kogu massiivi sisu
Write-Host $number # Näitab arvutise tulemust (7)
Write-Host $numbers[0] # $numbers[0]: Kuvab massiivi esimese elemendi (5), kuna massiivid algavad indeksiga 0.

# foreach-loo: See tsükkel käib läbi iga massiivi $numbers elemendi ja kuvab selle ($x on iga element ükshaaval). 

Write-Host "___"
foreach($x in $numbers){
Write-Host $x
}
<# Tulemus
5
43
23
432
 #>


Write-Host "___"
for($x=0; $x -lt $numbers.Count; $x++) {
    Write-Host $x $numbers[$x]  # Write-Host $x $numbers[$x]: Kuvab indeksi ($x) ja selle indeksiga elemendi väärtuse massiivis.
}
<# Tulemus
0 5
1 43
2 23
3 432 #>


<#
$mixed_array = @(4, "marko", 5.32, "mida 54"): Loob massiivi, mis sisaldab erinevat tüüpi elemente: täisarv 4, tekst marko, koma-arv 5.32 ja tekst mida 54.
foreach: See tsükkel käib läbi iga elemendi mixed_array massiivis ja kuvab selle.
#>
Write-Host "___"
$mixed_array = @(4, "marko", 5.32, "mida 54") # 4 elementi 
foreach($value in $mixed_array){
    Write-Host $value
}
<#
4
marko
5,32
mida 54
#>

Write-Host "___"  # teeb alakriipsu ___
