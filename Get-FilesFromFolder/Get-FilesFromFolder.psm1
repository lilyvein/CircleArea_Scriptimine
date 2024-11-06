function Get-FilesFromFolder {
    <#
    .SYNOPSIS
    Tagastab etteantud kaustast etteantud failitüübid.
    .DESCRIPTION
    Tagastab etteantud kaustast (vaikimisi C:\Users\<kasutajanimi>\Desktop\testing)
    etteantud failitüübid (vaikimmisi *.*) ehk kõik failid. s.h alamkaustad.
    .PARAMETER FolderPath
    Kausta täeilik tee kust kohast faili  otsitakse.
    .PARAMETER FileType
    Failitüübid mida otsida. Vaikimisi kõik failid (*.*). Näited: *.docx, *.log, ?.*
    .EXAMPLE
    Get-FilesFromFolder
    Tagastab kõik failid kaustast C:\Users\<kasutajanimi>\Desktop\testing
    .EXAMPLE
    Get-FilesFromFolder -FolderPath "C:\Windows\System32" -FileType "?.*"
    Tagastab ühetähelised suvalise laiendiga failid kaustast C:\Windows\System32
    .INPUTS
    [string] - Kaustatee (FolderPath)
    [string] - Failitüüp (FileType)
    .OUTPUTS
    [Syste.IO.FileInfo] - Tagastab failide info objektina
    .NOTES
    Autor: Lily Veinberg
    Versioon: 0.1
    Kuupäev: 24.10.2024
    .LINK
    https://www.google.com/search?client=firefox-b-d&sca_esv=3a7f9d0ba2a1d9a5&q=powershell+search+files+from+folder

    #>
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

