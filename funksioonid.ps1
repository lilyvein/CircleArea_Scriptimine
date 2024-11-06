function Get-FolderSize_v1 {
    param(
        [string]$FolderPath = "C:\Users\$env:USERNAME\Desktop"
        )
    if(Test-Path $FolderPath) {
        $folder = Get-ChildItem -Recurse -Force $FolderPath
        $folderSize = ($folder | Measure-Object -Property Length -Sum).Sum
        return $folderSize
    } else {
        return $null
    }
}

# väljastab mingi numbri
Get-FolderSize_v1 -FolderPath "C:\Users\kasutaja\Desktop\testing"
# see rida ei väljasta vastust
Get-FolderSize_v1 -FolderPath "C:\Users\kasutaja\Desktop\testing_pole"
# Documents kausta suurus
Get-FolderSize_v1 "C:\Users\kasutaja\Documents"
Get-FolderSize_v1("C:\Users\kasutaja\Desktop\testing")
Get-FolderSize_v1 -FolderPath "C:\Users\$env:USERNAME\Desktop\testing"
# väljastab nii : Ilma argumendita 419766
Write-Host "Ilma argumendita $(Get-FolderSize_v1)"

$a = 4
$b = 5
# väljastab tulemuseks 9
Write-Host "$($a + $b)"
# väljastab tulemuseks 4
Write-Host "$a"
