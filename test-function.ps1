function Test-Function {
    param (
        # Kohustuslik parameeter
        [Parameter(Mandatory=$true)][string]$RequiredParam,
        # Positsiooniline parameeter (2. positsioon) 1 selle pärast et 0, 1
        [Parameter(Position=1)][int]$PositionParam,
        #Vaike väärtusega parameeter
        [string]$OptionalParam = "Vaikeväärtus", 
        # Lubatud väärtustega parameeter
        [ValidateSet("Valik1", "Valik2", "Valik3")][string]$RestrictedParam,
        # "Kohustuslik", kindlal positsioonil vaikeväärtusega parameeter
        [Parameter(Position=2, Mandatory=$false)]
        [string]$MandatoryPositionParam = "VaikimisiDefaultVäärtus"
    )
    Write-Host $RequiredParam $PositionParam $OptionalParam $RestrictedParam $MandatoryPositionParam
    
}

Test-Function -RequiredParam "Tere"
# Test-Function # Küsitakse puuduvat väärtust RequiredParam
Test-Function -RequiredParam "Head aega" -PositionParam 100
Test-Function -RequiredParam "Welcome" -PositionParam 50 -OptionalParam "Muudetud"
Test-Function -RequiredParam "Hüva leili" 45 -RestrictedParam Valik2
Test-Function -OptionalParam "Uues kohas" 1000 -RequiredParam "Loomad teel"
Test-Function -MandatoryPositionParam "Proov" 1000 -RequiredParam "Loomad teel"
Test-Function -MandatoryPositionParam "Proov" -PositionParam 1 -RequiredParam "Test"

Test-Function -RequiredParam "Proov" 1 "Test"
#Test-Function "Proov" 1 "Test" # katki



