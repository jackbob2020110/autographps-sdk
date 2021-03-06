# <img src="https://raw.githubusercontent.com/adamedx/autographps-sdk/master/assets/PoshGraphIcon.png" width="50"> AutoGraphPS-SDK

| [Documentation](https://github.com/adamedx/autographps/blob/master/docs/WALKTHROUGH.md) | [Installation](#Installation) | [Using AutoGraphPS-SDK](#Usage) | [Command inventory](#Reference) | [Contributing and development](#contributing-and-development) |
|-------------|-------------|-------------|-------------|-------------|

[![Build Status](https://adamedx.visualstudio.com/AutoGraphPS/_apis/build/status/AutoGraphPS-SDK-CI?branchName=master)](https://adamedx.visualstudio.com/AutoGraphPS/_build/latest?definitionId=4&branchName=master)

## Overview

**AutoGraphPS-SDK** automates the [Microsoft Graph API](https://graph.microsoft.io/) through PowerShell. AutoGraphPS-SDK enables the development of PowerShell-based applications and automation of the Microsoft Graph REST API gateway; the PowerShell Graph exploration UX [AutoGraphPS](https://github.com/adamedx/autographps) is one such application based on the SDK. The Graph exposes a growing list of services such as

* Azure Active Directory (AAD)
* OneDrive
* Exchange / Outlook
* SharePoint
* And many more!

The project is in the earliest stages of development and almost but not quite yet ready for collaborators.

### System requirements

On the Windows operating system, PowerShell 5.1 and higher are supported. On Linux, PowerShell 6.1.2 and higher are supported. MacOS has not been tested, but should work with PowerShell 6.1.2 and higher.

## Installation
AutoGraphPS-SDK is available through the [PowerShell Gallery](https://www.powershellgallery.com/packages/autographps-sdk); run the following command to install the latest stable release of AutoGraphPSGraph-SDK into your user profile:

```powershell
Install-Module AutoGraphPS-SDK -scope currentuser
```

## Usage
Once you've installed, you can use an AutoGraphPS-SDK cmdlet like `Get-GraphItem` below to test out your installation. You'll need to authenticate using a [Microsoft Account](https://account.microsoft.com/account) or an [Azure Active Directory (AAD) account](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-whatis):

```powershell
PS> get-graphitem me
```

After you've responded to the authentication prompt, you should see output that represents your user object similar to the following:

    id                : 82f53da9-b996-4227-b268-c20564ceedf7
    officeLocation    : 7/3191
    @odata.context    : https://graph.microsoft.com/v1.0/$metadata#users/$entity
    surname           : Okorafor
    mail              : starchild@mothership.io
    jobTitle          : Professor
    givenName         : Starchild
    userPrincipalName : starchild@mothership.io
    businessPhones    : +1 (313) 360 3141
    displayName       : Starchild Okorafor

Now you're ready to use any of AutoGraphPS-SDK's cmdlets to access and explore Microsoft Graph! Visit the [WALKTHROUGH](https://github.com/adamedx/autographps/blob/master/docs/WALKTHROUGH.md) for detailed usage of the cmdlets.

### How do I use the cmdlets from the CLI?

If you're familiar with the Microsoft Graph REST API or you've used [Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer), you know that Graph is accessed via [URI's that look like the following](https://developer.microsoft.com/en-us/graph/docs/concepts/overview#popular-requests):

```
https://graph.microsoft.com/v1.0/me/calendars
https://graph.microsoft.com/v1.0/me/people
https://graph.microsoft.com/v1.0/users
```

With the AutoGraphPS-SDK cmdlets, you can invoke REST methods from PowerShell and omit the common `https://graph.microsoft.com/v1.0` of the URI as follows:

```powershell
Get-GraphItem me/calendars
Get-GraphItem me/people
Get-GraphItem users
```

These commands retrieve the same data as a `GET` for the full URIs given earlier. Of course, `Get-GraphItem` supports a `-AbsoluteUri` option to allow you to specify that full Uri if you so desire.

As with any PowerShell cmdlet, you can use AutoGraphPS-SDK cmdlets interactively or from within simple or even highly complex PowerShell scripts and modules since the cmdlets emit and operate upon PowerShell objects.

For more detailed information on how to use AutoGraphPS-SDK cmdlets, see the [WALKTHROUGH](https://github.com/adamedx/autographps/blob/master/docs/WALKTHROUGH.md) for the separate AutoGraphPS module, which documents a superset of cmdlets contained in this SDK in additions to those found in that module.

### How do I use it in my PowerShell application?

If your application is packaged as a PowerShell module, simply include it in the `NestedModules` section of your module's [PowerShell module manifest](https://technet.microsoft.com/en-us/library/dd878337%28v=VS.85%29.aspx). This will allow you to publish your module to a repository like PSGallery and ensure that users who install your module from the gallery also get the installation of AutoGraphPS-SDK needed for your module to function. You should add the line `import-module autographps-sdk` to the beginning of the script you use to initialize your module.

If you're using a script module (`.psm1` file) or simply a plain PowerShell `ps1` script, you should ensure the module has been already been installed on the system using `Install-Module` or a similar deployment mechanism, then add a line `import-module autographps-sdk` to the beginning of your script or script module.

## Reference

The full list of cmdlets in this module is given below; note that `Invoke-GraphRequest` may be used not just for reading from the Graph, but also for write operations. Use `Connect-Graph` to request additional permissions as described in the [Graph permissions documentation](https://developer.microsoft.com/en-us/graph/docs/concepts/permissions_reference). Additional cmdlets will be added to this module as development matures.

| Cmdlet (alias)                       | Description                                                                                                                                             |
|--------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| Clear-GraphLog                       | Clear the log of REST requests to Graph made by the module's commands                                                                                   |
| Connect-Graph                        | Establishes authentication and authorization context used across cmdlets for the current graph                                                          |
| Disconnect-Graph                     | Clears authentication and authorization context used across cmdlets for the current graph                                                               |
| Find-GraphLocalCertificate           | Gets a list of local certificates created by AutoGraphPS-SDK to for app-only or confidential delegated auth to Graph                                    |
| Format-GraphLog (fgl)                | Emits the Graph request log to the console in a manner optimized for understanding Graph and troubleshooting requests                                   |
| Get-GraphApplication                 | Gets a list of Azure AD applications in the tenant                                                                                                      |
| Get-GraphApplicationCertificate      | Gets the certificates with public keys configured on the application                                                                                    |
| Get-GraphApplicationConsent          | Gets the list of the tenant's consent grants (entries granting an app access to capabilities of users)                                                  |
| Get-GraphApplicationServicePrincipal | Gets the service principal for the application in the tenant                                                                                            |
| Get-GraphConnectionInfo              | Gets information about a connection to a Graph endpoint, including identity and  `Online` or `Offline`                                                  |
| Get-GraphError (gge)                 | Retrieves detailed errors returned from Graph in execution of the last command                                                                          |
| Get-GraphItem  (ggi)                 | Given a relative (to the Graph or current location) Uri gets information about the entity                                                               |
| Get-GraphLog (ggl)                   | Gets the local log of all requests to Graph made by this module                                                                                         |
| Get-GraphLogOption                   | Gets the configuration options for logging of requests to Graph including options that control the detail level of the data logged                      |
| Get-GraphToken                       | Gets an access token for the Graph -- helpful in using other tools such as [Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer) |
| Invoke-GraphRequest                  | Executes a REST method (e.g. `GET`, `PUT`, `POST`, `DELETE`, etc.) for a Graph Uri                                                                      |
| New-GraphApplication                 | Creates an Azure AD application configured to authenticate to Microsoft Graph                                                                           |
| New-GraphApplicationCertificate      | Creates a new certificate in the local certificate store and configures its public key on an application                                                |
| New-GraphConnection                  | Creates an authenticated connection using advanced identity customizations for accessing a Graph                                                        |
| New-GraphLocalCertificate            | Creates a certificate in the local certificate store for use in authenticating as an application                                                        |
| Register-GraphApplication            | Creates a registration in the tenant for an existing Azure AD application                                                                               |
| Remove-GraphApplication              | Deletes an Azure AD application                                                                                                                         |
| Remove-GraphApplicationCertificate   | Removes a public key from the application for a certificate allowed to authenticate as that application                                                 |
| Remove-GraphApplicationConsent       | Removes consent grants for an Azure AD application                                                                                                      |
| Remove-GraphItem                     | Makes generic ``DELETE`` requests to a specified Graph URI to delete items                                                                              |
| Set-GraphApplicationConsent          | Sets a consent grant for an Azure AD application                                                                                                        |
| Set-GraphConnectionStatus            | Configures `Offline` mode for use with local commands like `GetGraphUri` or re-enables `Online` mode for accessing the Graph service                    |
| Set-GraphLogOption                   | Sets the configuration options for logging of requests to Graph including options that control the detail level of the data logged                      |
| Test-Graph                           | Retrieves unauthenticated diagnostic information from instances of your Graph endpoint                                                                  |
| Unregister-GraphApplication          | Removes consent and service principal entries for the application from the tenant                                                                       |

### Limited support for Azure Active Directory (AAD) Graph

Some AutoGraphPS-SDK cmdlets also work with [Azure Active Directory Graph](https://msdn.microsoft.com/Library/Azure/Ad/Graph/howto/azure-ad-graph-api-operations-overview), simply by specifying the `-aadgraph` switch as in the following:

```powershell
Get-GraphItem me -aadgraph
```

Most functionality of AAD Graph is currently available in MS Graph itself, and in the future all of it will be accessible from MS Graph. In the most common cases where a capability is accessible via either graph, use MS Graph to ensure long-term support for your scripts and code and your ability to use the full feature set of AutoGraphPS-SDK.

### More about how it works

If you'd like a behind the scenes look at the implementation of AutoGraphPS-SDK, take a look at the following article:

* [Microsoft Graph via PowerShell](https://adamedx.github.io/softwarengineering/2018/08/09/Microsoft-Graph-via-PowerShell.html)

## Developer installation from source
For developers contributing to AutoGraphPS-SDK or those who wish to test out pre-release features that have not yet been published to PowerShell Gallery, run the following PowerShell commands to clone the repository and then build and install the module on your local system:

```powershell
git clone https://github.com/adamedx/autographps-sdk
cd autographps-sdk
.\build\install-fromsource.ps1
```

## Contributing and development

Read about our contribution process in [CONTRIBUTING.md](CONTRIBUTING.md).

See the [Build README](build/README.md) for instructions on building and testing changes to AutoGraphPS-SDK.

## Quickstart
The Quickstart is a way to try out AutoGraphPS-SDK without installing the AutoGraphPS-SDK module. In the future it will feature an interactive tutorial. Additionally, it is useful for developers to quickly test out changes without modifying the state of the operating system or user profile. Just follow these steps on your workstation to start **AutoGraphPS-SDK**:

* [Download](https://github.com/adamedx/autographps-sdkarchive/master.zip) and extract the zip file for this repository **OR** clone it with the following command:

  `git clone https://github.com/adamedx/autographps-sdk`

* Within a **PowerShell** terminal, `cd` to the extracted or cloned directory
* Execute the command for **QuickStart**:

  `.\build\quickstart.ps1`

This will download dependencies, build the AutoGraphPS-SDK module, and launch a new PowerShell console with the module imported. You can execute a AutoGraphPS-SDK cmdlet like the following in the console -- try it:

  `Test-Graph`

This should return something like the following:

    ADSiteName : wst
    Build      : 1.0.9736.8
    DataCenter : west us
    Host       : agsfe_in_29
    PingUri    : https://graph.microsoft.com/ping
    Ring       : 4
    ScaleUnit  : 000
    Slice      : slicea
    TimeLocal  : 2/6/2018 6:05:09 AM
    TimeUtc    : 2/6/2018 6:05:09 AM

If you need to launch another console with AutoGraphPS, you can run the faster command below which skips the build step since QuickStart already did that for you (though it's ok to run QuickStart again):

    .\build\import-devmodule.ps1

These commmands can also be used when testing modifications you make to AutoGraphPS-SDK, and also give you an isolated environment in which to test and develop applications and tools that depend on AutoGraphPS-SDK.

License and authors
-------------------
Copyright:: Copyright (c) 2018 Adam Edwards

License:: Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

