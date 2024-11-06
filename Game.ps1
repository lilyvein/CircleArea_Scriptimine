<#
Äraarvanuse mäng. Number vahemikus 1-100
Tagauks.
Kui mäng on läbi siis küsi nime ja sammude arv kirjutatakse faili result.txt
#>
$pc_nr = Get-Random -Minimum 1 -Maximum 100  # See rida genereerib juhusliku arvu vahemikus 1 kuni 100 ja salvestab selle muutujasse $pc_nr. 

# $game_over: See muutuja näitab, kas mäng on läbi või mitte. Algväärtus on false, sest mäng pole veel lõppenud.
[System.Boolean]$game_over = $false
$Global:steps = 0 # Globaalne sammude lugeja  alustab nullist
# $filename: Määrab faili nime (result.txt), kuhu mängu tulemus salvestatakse. Join-Path ühendab skripti asukohatee ja faili nime.
$filename = Join-Path -Path $PSScriptRoot -childPath "result.txt"
#Write-Host $filename

<#
WriteToFile: See funktsioon küsib mängija nime ja salvestab nime koos sammude arvuga faili result.txt.

    Read-Host "Mängija nimi" küsib mängijalt nime.
    Out-File -Append kirjutab andmed faili ilma olemasolevat sisu kustutamata.
#>
function WriteToFile {
    $name = Read-Host "Mängija nimi"
    ($name + ";" + $Global:steps) | Out-File -FilePath $filename -Append # Out-File -Append kirjutab andmed faili ilma olemasolevat sisu kustutamata.
      
}


<#
Show-Scoreboard: See funktsioon loeb faili result.txt sisu ja kuvab iga rea eraldi.

    Get-Content loeb faili ja salvestab selle sisu massiivi.
    Split(";") eraldab mängija nime ja sammude arvu, mis on failis semikooloniga (;) eraldatud.
#>
function Show-Scoreboard {
    $contents = Get-Content -Path $filename # loe failisisu massiivi
    foreach($line in $contents) { # kä faili sisu rea kaupa läbi
        Write-Host $line.Split(";")  # näita faili rida nagu ta on split tükeldab võtab ära ;
    }
}

<#
LetsPlay: See funktsioon küsib kasutajalt arvatava numbri, suurendab sammude arvu ja kontrollib, kas sisestatud number on:

    Väiksem kui arvuti valitud number ($pc_nr): siis kuvatakse sõnum "Suurem".
    Võrdne arvuti valitud numbriga: siis mängija võidab ja kuvatakse "Leidsid õige numbri".
    Suurem kui arvuti valitud number: siis kuvatakse "Väiksem".
    Tagauks: Kui mängija sisestab numbri 1000, kuvatakse õige vastus (arvuti valitud number) kohe.

Tagastab $game_over, mis näitab, kas mäng on läbi.
#>
function LetsPlay {
   [int]$user_nr = Read-Host "Siesta number"  #int-täisarve
   $Global:steps += 1 # Sammud kasvavad ühe võrra
   
   if(($user_nr -lt $pc_nr) -and ($user_nr -ne 1000)) {
       Write-Host "Suurem"
       $game_over = $false
   } elseif(($user_nr -eq $pc_nr)  -and ($user_nr -ne 1000)) {
       Write-Host "Leidsid õige numbri $Global:steps sammuga."
       $game_over = $true
   } elseif (($user_nr -gt $pc_nr) -and ($user_nr -ne 1000)) {  # Kui kasutaja  number on võrdne 1000
         Write-Host "Väiksem"
            $game_over = $false
   } elseif($user_nr -eq 1000) {
       Write-Host "Oled leidnud salaukse. Õige number on $pc_nr"
       $game_over = $false
   }
   return $game_over
}

# Test
Write-Host $pc_nr


<#
while-loop: See tsükkel käib seni, kuni $game_over on false.

    LetsPlay: Kutsutakse mängu loogika funktsioon iga kord, kui mängija sisestab numbri.
    Kui mäng on läbi:
        WriteToFile: Küsitakse mängija nime ja salvestatakse tulemused.
        Show-Scoreboard: Kuvab senised tulemused.
        Kas mängime veel?: Küsib, kas mängija tahab uuesti proovida.
        Kui vastus on J või j, genereeritakse uus number, steps nullitakse ja mäng algab uuesti.
#>
while($game_over -eq $false) {
    $game_over = LetsPlay
    if($game_over){
        WriteToFile  # Küsi nime ja kirjuta faili nimi ja sammude arv
        Show-Scoreboard # näita konsoolis edetabelit
        # Mäng on läbi, küsime kas mängime veel
        $answer = Read-Host "Kas mängime veel? [J/E]"
        if($answer -eq "J" -or $answer -eq "j") {
            $pc_nr = Get-Random -Minimum 1 -Maximum 100
            [System.Boolean]$game_over = $false
            $Global:steps = 0
    
        }
    }
}




