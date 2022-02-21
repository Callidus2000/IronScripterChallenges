# Task:
# Write PowerShell code to take a string like ‘PowerShell’ and display it in reverse. Your solution can be a simple script or function.
function ConvertTo-ReverseString{
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$TheOriginalString
    )
    $charArray = $TheOriginalString.ToCharArray()
    [array]::Reverse($charArray)
    return -join($charArray)
}
Write-Host "'Powershell' reversed spells like $(ConvertTo-ReverseString 'Powershell')"