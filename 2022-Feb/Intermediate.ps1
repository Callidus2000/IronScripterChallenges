# Intermediate
# Your challenge is based on the Beginner exercise. Take a sentence like, “This
# is how you can improve your PowerShell skills,” and write PowerShell code to
# display the entire sentence in reverse with each word reversed. You should be
# able to encode and decode text. Ideally, your functions should take pipeline
# input.

function ConvertTo-ReverseString {
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [string]$TheOriginalString
    )
    begin {
        $returnValues = @()
    }
    process {
        $charArray = $TheOriginalString.ToCharArray()
        [array]::Reverse($charArray)
        $returnValues += -join ($charArray)
    }
    end {
        return $returnValues
    }
}
$sentence = "This is how you can improve your PowerShell skills"
$reversed=ConvertTo-ReverseString $sentence
Write-Host "$sentence`n reversed spells like `n$reversed"
Write-Host " reversed again is `n$($reversed|ConvertTo-ReverseString)"