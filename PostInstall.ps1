function setupprofile () {
    if(Test-Path $HOME\Documents\WindowsPowerShell\){
        Copy-Item .\Microsoft.PowerShell-profile.ps1 $HOME\Documents\WindowsPowerShell\profile.ps1
    }else{
        mkdir $HOME\Documents\WindowsPowerShell\
        setupprofile
    }
}

Write-Output "Seting up powershell profile."
setupprofile
Copy-Item .\PostInstall.ps1 $env:temp\postinstall.ps1
Write-Output "Installation complete. Press any key to quit ..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")