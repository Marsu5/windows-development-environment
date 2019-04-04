#requires -Version 2 -Modules posh-git
function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )
    $prompt = ''
    #check for elevated prompt
    If (Test-Administrator) {
        $prompt += Write-Prompt -Object "$($sl.PromptSymbols.ElevatedSymbol) " -ForegroundColor $sl.Colors.AdminIconForegroundColor
    }

    #check the last command state and indicate if failed
    If ($lastCommandFailed) {
        $prompt += Write-Prompt -Object "$($sl.PromptSymbols.PromptIndicator) " -ForegroundColor $sl.Colors.CommandFailedIconForegroundColor
    }else{
        $prompt += Write-Prompt -Object "$($sl.PromptSymbols.PromptIndicator) " -ForegroundColor $sl.Colors.PromptSymbolColor
    }

    # Writes the drive portion
    $prompt += Write-Prompt -Object "$(Get-ShortPath -dir $pwd)" -ForegroundColor $sl.Colors.DriveForegroundColor

    $status = Get-VCSStatus
    if ($status) {
        $prompt += Write-Prompt -Object " git:($($status.Branch))" -ForegroundColor $sl.Colors.PromptForegroundColor
        if($status.HasUntracked){
            $prompt += Write-Prompt -Object " x" -ForegroundColor $sl.Colors.CommandFailedIconForegroundColor
        }
    }

    # write virtualenv
    if (Test-VirtualEnv) {
        $prompt += Write-Prompt -Object 'env:' -ForegroundColor $sl.Colors.PromptForegroundColor
        $prompt += Write-Prompt -Object " $(Get-VirtualEnvName)" -ForegroundColor $themeInfo.VirtualEnvForegroundColor
    }

    if ($with) {
        $prompt += Write-Prompt -Object " $($with.ToUpper())" -BackgroundColor $sl.Colors.WithBackgroundColor -ForegroundColor $sl.Colors.WithForegroundColor
    }

    # Writes the postfixes to the prompt
    $prompt += ' '
    $prompt
}

$sl = $global:ThemeSettings #local settings
$sl.PromptSymbols.PromptIndicator = [char]::ConvertFromUtf32(0x25B3)
$sl.Colors.PromptForegroundColor = [ConsoleColor]::White
$sl.Colors.PromptSymbolColor = [ConsoleColor]::White
$sl.Colors.PromptHighlightColor = [ConsoleColor]::DarkBlue
$sl.Colors.GitForegroundColor = [ConsoleColor]::Black
$sl.Colors.WithForegroundColor = [ConsoleColor]::DarkRed
$sl.Colors.WithBackgroundColor = [ConsoleColor]::Magenta
$sl.Colors.VirtualEnvBackgroundColor = [System.ConsoleColor]::Red
$sl.Colors.VirtualEnvForegroundColor = [System.ConsoleColor]::White