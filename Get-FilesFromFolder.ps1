#Get-FilesFromFolder.ps1
function Get-FilesFromFolder {
    param (
        # Kaustatee
        [Parameter(Mandatory=$false)]
        [string]$FolderPath = "C:\Users\$env:USERNAME\Desktop\testing",
        # Valikuline failitüüp (*.*) kõik failid
        [string]$FileType = "*.*"  # *.* tähendab kõik failid
    )
    # Kui kausta ei ole
    if (-not (Test-Path $FolderPath)) {
        <# Action to perform if the condition is true #>
        Write-Host "Kausta ei leitud: $FolderPath"
        return # Funksioon lõpetab siin töö
    }
    # Kaust on siiski olemas
    try {
        $files = Get-ChildItem -Path $FolderPath -Filter $FileType
        return $files
    }
    catch {
        <#Do this if a terminating exception happens#>
        Write-Host "Tekkis viga failide hankimisel $_"
    }
}
# Testimine -  saan nimekirja (massiivi) failidest  mis on testing kaustas, see mille ta tagastab on objekt
Get-FilesFromFolder # Töötab vaikimisi väärtustega
$result = Get-FilesFromFolder -FileType  "*.txt" # saame failid .txt lõpuga
#$result = Get-FilesFromFolder -FileType  "????.txt" # saame failid teatud tähtede arvuga
#$result = Get-FilesFromFolder -FileType  "*.e?e" # saame failid .exe lõpuga
Write-Host $result
($result | Measure-Object -Property Length -Sum).Sum # saame failide mahu summa 3227
$result # väljastab tulemuse kus iga fail on eraldi rida
$result | Get-Member | Format-Table # Property
# väljastatakse failid mille suurus on rohkem kui 500
$result | Where-Object {$_.Length -gt 500} | Select-Object Name, Length  # gt suurem kui, lt väiksem kui 

Get-FilesFromFolder -FolderPath "C:\Windows" -FileType "*.dll"
