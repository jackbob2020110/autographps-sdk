#
# Module manifest for module 'poshgraph-sdk'
#
# Generated by: adamedx
#
# Generated on: 9/24/2017
#

@{

# Script module or binary module file associated with this manifest.
# RootModule = ''

# Version number of this module.
ModuleVersion = '0.2.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '4d32f054-da30-4af7-b2cc-af53fb6cb1b6'

# Author of this module
Author = 'Adam Edwards'

# Company or vendor of this module
CompanyName = 'Modulus Group'

# Copyright statement for this module
Copyright = '(c) 2018 Adam Edwards.'

# Description of the functionality provided by this module
Description = 'PowerShell SDK for Microsoft Graph interaction'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
ScriptsToProcess = @('./src/graph-sdk.ps1')

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @(@{ModuleName='scriptclass';ModuleVersion='0.13.7';Guid='9b0f5599-0498-459c-9a47-125787b1af19'})

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @()

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport = @(
        'Connect-Graph',
        'Disconnect-Graph',
        'Get-GraphConnectionStatus',
        'Get-GraphError',
        'Get-GraphItem',
        'Get-GraphSchema',
        'Get-GraphToken',
        'Get-GraphVersion',
        'Invoke-GraphRequest',
        'New-GraphConnection',
        'Set-GraphConnectionStatus',
        'Test-Graph'
    )

# Variables to export from this module
    VariablesToExport = @(
        'GraphVerboseOutputPreference',
        'LastGraphItems'
    )

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @('gge', 'ggi')

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @('')

# List of all files packaged with this module
    FileList = @(
        '.\poshgraph-sdk.psd1',
        '.\poshgraph-sdk.psm1',
        '.\src\aliases.ps1',
        '.\src\cmdlets.ps1',
        '.\src\graph-sdk.ps1',
        '.\src\client\Application.ps1',
        '.\src\client\graphapplication.ps1',
        '.\src\client\GraphConnection.ps1',
        '.\src\client\GraphContext.ps1',
        '.\src\client\GraphIdentity.ps1',
        '.\src\client\LogicalGraphManager.ps1',
        '.\src\cmdlets\connect-graph.ps1',
        '.\src\cmdlets\disconnect-graph.ps1',
        '.\src\cmdlets\Get-GraphConnectionStatus.ps1',
        '.\src\cmdlets\get-grapherror.ps1',
        '.\src\cmdlets\get-graphitem.ps1',
        '.\src\cmdlets\Get-GraphSchema.ps1',
        '.\src\cmdlets\Get-GraphToken.ps1',
        '.\src\cmdlets\Get-GraphVersion.ps1',
        '.\src\cmdlets\Invoke-GraphRequest.ps1',
        '.\src\cmdlets\New-GraphConnection.ps1',
        '.\src\cmdlets\Set-GraphConnectionStatus.ps1',
        '.\src\cmdlets\Test-Graph.ps1',
        '.\src\cmdlets\common\ItemResultHelper.ps1',
        '.\src\cmdlets\common\QueryHelper.ps1',
        '.\src\common\GraphAccessDeniedException.ps1',
        '.\src\common\GraphUtilities.ps1',
        '.\src\common\PreferenceHelper.ps1',
        '.\src\common\ProgressWriter.ps1',
        '.\src\graphservice\graphendpoint.ps1'
        '.\src\REST\GraphErrorRecorder.ps1',
        '.\src\REST\GraphRequest.ps1',
        '.\src\REST\GraphResponse.ps1',
        '.\src\REST\RestRequest.ps1',
        '.\src\REST\RestResponse.ps1'
    )

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('MSGraph', 'Graph', 'AADGraph', 'Azure', 'MicrosoftGraph', 'Microsoft-Graph', 'MS-Graph', 'AAD-Graph', 'REST', 'CRUD', 'GraphAPI')

        # A URL to the license for this module.
        LicenseUri = 'http://www.apache.org/licenses/LICENSE-2.0'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/adamedx/poshgraph-sdk'

        # A URL to an icon representing this module.
        IconUri = 'https://raw.githubusercontent.com/adamedx/poshgraph-sdk/master/assets/PoshGraphIcon.png'

        # Adds pre-release to the patch version according to the conventions of https://semver.org/spec/v1.0.0.html
        # Requires PowerShellGet 1.6.0 or greater
        Prerelease = '-preview'

        # ReleaseNotes of this module
        ReleaseNotes = @"
# PoshGraph-SDK 0.2.0 Release Notes

## New features

### Cmdlet features

* ``Connect-Graph`` cmdlet: ``-Reconnect`` option to reconnect a previously disconnected Graph
* ``Connect-Graph`` cmdlet: ``-ScopeNames`` supported with -Reconnect for permission elevation scenarios
* ``Connect-Graph`` is now deterministic -- no longer based on context unless you specify ``-Reconnect``
* ``Disconnect-Graph`` is now deterministic -- it removes cached tokens so that subsequent connection attempts behave as if it's the very first attempt
* ``New-GraphConnection`` cmdlet: ``-AuthProtocol`` option configures authentication protocol to overridde defaults if needed
* ``New-GraphConnection`` cmdlet: ``-RedirectUri`` option allows the use of custom applications with a particular redirect URI
* ``New-GraphConnection`` cmdlet: ``-TenantName`` option allows the use of custom non-converged applications that require the tenant (including 'organizations') to be specified during authentication

### Library features

* ``GraphIdentity`` now takes a ``TenantName`` argument to support v1 tenant-scoped applications
* ``GraphIdentity`` exposes a ``GetUserInformation`` method to return data about the authenticated user (if any)
* ``GraphEndpoint`` exposes a ``GetAuthUri`` method to return the URI for obtaining access tokens

## Fixed defects

* ``Get-GraphItem``, ``Invoke-GraphRequest`` were ignoring ``-Version`` option -- these commands could only access the Graph ``v1.0`` API version
* National cloud support through ``-Cloud`` arguments now works in commands like ``Connect-Graph``, ``New-GraphConnection``, etc.
* Fix ignored scopes when ``-ScopeNames`` was specified with ``Connect-Graph``
* Fix over-specification of parameters for ``New-GraphConnection`` due to missing default parameterset
* Fix exception in ``Disconnect-Graph`` cmdlet due to call to removed method
* 
"@

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}
