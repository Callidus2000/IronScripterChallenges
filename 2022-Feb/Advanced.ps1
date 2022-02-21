# Advanced
# Once you’ve accomplished the intermediate-level task, create a PowerShell
# script to display a WPF form. The form should have a place where the user can
# enter a plaintext or encoded string and then buttons to encode or decode. The
# encoded or decoded value should be displayed in the form and copied to the
# clipboard. For bonus points, toggle upper and lower case when reversing the
# word. For example, ‘Shell’ should become ‘LLEHs.’

function ConvertTo-ReverseString {
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [string]$TheOriginalString,
        [switch]$ReverseCase
    )
    begin {
        $returnValues = @()
    }
    process {
        $charArray = $TheOriginalString.ToCharArray()
        [array]::Reverse($charArray)
        if ($ReverseCase) {
            for ($i = 0; $i -lt $charArray.Count; $i++) {
                if ($charArray[$i] -cmatch "[A-Z]") {
                    $charArray[$i] = [System.Char]::ToLower($charArray[$i])
                }
                else {
                    $charArray[$i] = [System.Char]::ToUpper($charArray[$i])
                }
            }
        }
        $returnValues += -join ($charArray)
    }
    end {
        return $returnValues
    }
}
Add-Type -Assembly PresentationFramework
[xml]$xaml = Get-content "$PSScriptRoot\IronScripter-TextReverse.xaml"
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)
$convertButton = $window.FindName("ConvertButton")
$inputTextBox = $window.FindName("txtInput")
$outputTextBox = $window.FindName("txtOutput")
$convertButton.Add_Click( {
        If ($inputTextBox.Text) {
            $outputTextBox.Text = $inputTextBox.Text | ConvertTo-ReverseString -ReverseCase
            $outputTextBox.Text | Set-Clipboard
        }
    })
$window.ShowDialog()
