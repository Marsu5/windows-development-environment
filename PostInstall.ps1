function setupprofile () {
    if(Test-Path $HOME\Documents\WindowsPowerShell\){
        Invoke-WebRequest "https://raw.githubusercontent.com/Marsu5/windows-development-environment/master/Microsoft.PowerShell-profile.ps1" -OutFile "Microsoft.PowerShell-profile.ps1"
        Copy-Item .\Microsoft.PowerShell-profile.ps1 $HOME\Documents\WindowsPowerShell\profile.ps1
    }else{
        mkdir $HOME\Documents\WindowsPowerShell\
        setupprofile
    }
}

Write-Output "Seting up powershell profile."
setupprofile
Write-Output "Installing global npm packages"
npm install --global --production windows-build-tools
npm install -g npm-windows-upgrade
npm install -g hpm-cli
Write-Output "Installation complete. Press any key to quit ..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")