function Get-CircleArea {
    <#
    .SYNOPSIS
        Arvutab ringi pindala.
    .DESCRIPTION
        Funktsioon arvutab ringi pindala, kasutades valemit: Area = Pi * Radius^2.
        Kasutaja saab sisestada kas raadiuse või läbimõõdu.
    .PARAMETER Radius
        Ringi raadius.
    .PARAMETER Diameter
        Ringi läbimõõt.
    .EXAMPLE
        Get-CircleArea -Radius 5
        Tagastab ringi pindala raadiusega 5.
    .EXAMPLE
        Get-CircleArea -Diameter 10
        Tagastab ringi pindala läbimõõduga 10.
    .INPUTS
        [double] - Raadius või läbimõõt.
    .OUTPUTS
        [string] - Tagastab stringi ringi pindalaga.
    .NOTES
        Autor: Lily Veinberg
        Versioon: 0.2
        Kuupäev: 24.10.2024
    #>

    <#
    Mandatory=$true: See parameeter on kohustuslik, kui kasutaja valib 'Radius' parameetrikomplekti. 
    See tähendab, et kui kasutaja otsustab sisestada raadiuse, peab ta kindlasti lisama -Radius väärtuse käsureale.
    ParameterSetName='Radius': See määrab, et see parameeter kuulub 'Radius' komplekti. 
    Kui kasutaja annab funktsioonile -Radius parameetri, siis funktsioon käitub nii, et ta arvutab pindala raadiuse põhjal.
    #>

    param(
        # Ringi raadius
        [Parameter(Mandatory=$true, ParameterSetName='Radius')]    
        [double]$Radius,
        
        # Ringi läbimõõt
        [Parameter(Mandatory=$true, ParameterSetName='Diameter')]    
        [double]$Diameter
    )
    
    process {
        if ($PSCmdlet.ParameterSetName -eq 'Radius') {
            # Kui kasutaja sisestas raadiuse, arvutame pindala valemiga A = π * r^2
            $radiusSquared = $Radius * $Radius
            $pi = [Math]::PI
            $circleArea = $pi * $radiusSquared
        }
        elseif ($PSCmdlet.ParameterSetName -eq 'Diameter') {
            # Kui kasutaja sisestas läbimõõdu, teisendame selle raadiuseks ja arvutame pindala
            $Radius = $Diameter / 2
            $radiusSquared = $Radius * $Radius
            $pi = [Math]::PI
            $circleArea = $pi * $radiusSquared
        }
        
        # Kuvame arvutatud pindala koos lausega, ümardatuna kahe komakohani
        Write-Output ("Ringi pindala on {0:N2}" -f $circleArea)
    }
}
