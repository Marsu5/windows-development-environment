## Setup Windows 10 for Modern/Hipster Development
A fresh Windows isn't entirely ready for modern development, but all the tools you need are available. A good terminal, popular bash tools, Git, a decent package manager - when properly setup, modern development on Windows can be a lot of fun. In particular, this document outlines how to configure your Windows in such a way that it can easily handle most development tasks usually run on a Mac OS X or a Linux distro.

## A Word about Ubuntu Linux on Windows
:point_up: While [Bash on Windows](https://msdn.microsoft.com/en-us/commandline/wsl/about) isn't perfect yet, it's an amazing tool that can make development a lot easier - especially when you're dealing with Bash scripts, Ruby, or Ubuntu binaries. I would currently (January 2017) not recommend it as a replacement for Git, Node, or Go - mostly because those tools are already pretty performant on Windows itself. However, they run just fine in Bash, so if you feel like moving most of your development over, go for it. Here's the how-to:

 * Ensure that you're running Windows 10 Anniversary Update (build 14311 and up)
 * Enable Developer Mode (Settings - Update & security > For developers)
 * Search for “Windows Features” and choose “Turn Windows features on or off” and enable Windows Subsystem for Linux (Beta).
 * To get Bash installed, open Command Prompt and type “bash”

## Automate it!
Below, you can see the all the things I need to actually go and work on stuff. If you like all those things, you can automate the installation thanks to the magic of [Boxstarter](http://boxstarter.org/). Simply start PowerShell as Administrator and run:

```
START http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/Marsu5/windows-development-environment/master/boxstarter
```

## The Goods
 * [Package Management](#package-management-chocolatey)
 * [Terminal](#terminal-cmder-with-powershell-support)
 * [Bash Tools](#bash-tools-wget-curl-etc-gow)
 * [Node.js](#node)
 * [npm](#npm)
 * [Git](#git)
 * [Atom, Sublime, VS Code](#code-editors-atom-sublime-vs-code)
 * [Go](#go)
 * [Python](#python)
 * [SSH](#ssh)
 * [Basic Tools](#basic-tools)

#### Package Management: Chocolatey
Chocolatey is a powerful package manager for Windows, working sort of like apt-get or homebrew. Let's get that first. Fire up CMD.exe as Administrator and run:

```
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
```

Once done, you can install packages by running `cinst` (short for `choco install`). Most packages below will be installed with Chocolatey.

###### Bonus: Use Windows 10 & OneGet
Windows 10 comes with [OneGet](https://github.com/OneGet/oneget), a universal package manager that can use Chocolatey to find and install packages. To install, run:

```
Get-PackageProvider -name chocolatey
```

Once done, you can look for all Chrome packages by typing `Find-Package -Name Chrome` or install it by typing `Install-Package -Name GoogleChrome`.

#### Terminal: CMDer (with PowerShell Support)
The PowerShell in Windows 10 got a bunch of upgrades, but it's even better if used with [CMDer](https://github.com/bliker/cmder/) or [Hyper](https://hyper.is/), both poweful toosl to do more command-line things with. CMDer is the old-school veteran, while Hyper hasn't been around for long. Try both and see what you like more! Install with:

```
cinst cmder -pre
cinst hyper
```

Even if you don't want to use CMDer, you should enable your PowerShell to execute scripts. You're a developer - the terminal is your friend.

```
Set-ExecutionPolicy Unrestricted -Scope CurrentUser
```

If you want to go even futher, check out the attached PowerShell Profile in this repository. It's my personal one and might not be perfect for you, but it makes my personal life a lot easier. You can edit your PowerShell profile with your favorite editor by calling `$PROFILE`, so if you're using Visual Studio Code, call `code $PROFILE` (or `vim $PROFILE` - you get the idea).


#### Node
A bunch of tools are powered by Node and installed via npm. This applies to you even if you don't care about Node development. If you want to install tools for React, Azure, TypeScript, or Cordova, you'll need this.

```
cinst nodejs.install
```

#### NPM
You just installed Node, which means that you also installed a slightly outdated version of npm. npm@3 is currently in development and offers a bunch of benefits for Windows users. You probably want to upgrade to npm@3.

```
npm install -g npm-windows-upgrade
npm-windows-upgrade
```

#### Bash Tools (wget, curl, etc): Gow
If you're coming from a Unix machine, you might miss commands like curl, diff, grep and many other. Luckily git includes a huge collection of Unix tools recompiled for Windows. 

#### Version Control: Git
Obviously. If you want Git to be able to save credentials (so you don't have to enter SSH keys / passwords every single time you do anything), also install the Git Credential Manager for Windows.

```
cinst git.install /GitAndUnixToolsOnPath 
cinst poshgit

# Restart PowerShell / CMDer before moving on - or run
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
```

#### Code Editors: Atom, Sublime, VS Code
I won't join the war debating which editor is the best, but if you're looking for an editor and not a full IDE, chances are that you'll end up using one of those three.

```
cinst SublimeText3
cinst sublimetext3-contextmenu
cinst SublimeText3.PackageControl
cinst SublimeText3.PowershellAlias

cinst Atom
cinst visualstudiocode
```

##### Visual Studio 2017
If you already own Visual Studio, you should obviously install the version you bought with your precious money. If you don't, do know that Visual Studio 2017 Community Edition is free (for [most people](https://www.visualstudio.com/support/legal/dn877550)).

```
cinst visualstudio2017community
```

#### Go
Sure, why not.
```
cinst golang
```

#### Python
Python is a complex world with a bunch of flavors, but Python 3, pip, and easy_install should have you prepared for most things.

```
cinst python
cinst pip
````

#### SSH
If you installed CMDer or Gow as indicated above, you're already set - simply run `ssh` from CMD, CMDer, or PowerShell. If you didn't, use the official Microsoft port of OpenSSH:

```
cinst openssh
```

### Basic Tools
You'll recognize many of these names. Nothing here is crazy unique, it's just stuff you probably want installed to have a well-running machine.

```
cinst vlc
cinst GoogleChrome
cinst 7zip.install
cinst sysinternals
cinst DotNet3.5
```

If you're not running Windows 10, also install:

```
cinst DotNet4.0 -- not needed on windows 8
cinst DotNet4.5 -- not needed on windows 10
cinst PowerShell -- not needed on windows 10
```
