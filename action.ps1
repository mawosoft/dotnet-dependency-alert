# Copyright (c) 2023 Matthias Wolf, Mawosoft.

#Requires -Version 7.2 # Required by ListPackageHelper

using namespace System

[CmdletBinding()]
param(
    [Parameter(Mandatory, Position = 0)]
    [ValidateNotNullOrEmpty()]
    [string]$InputsJson
)

Set-StrictMode -Version 3.0
$ErrorActionPreference = 'Stop'

class Inputs {
    hidden [hashtable]$_inputs

    Inputs([string]$json) {
        $ht = ConvertFrom-Json -InputObject $json -AsHashtable -NoEnumerate
        $this._inputs = [hashtable]::new($ht, [StringComparer]::OrdinalIgnoreCase)
    }

    [string] GetString([string]$key) {
        return "$($this._inputs[$key])".Trim()
    }

    [string[]] GetArray([string]$key) {
        return "$($this._inputs[$key])".Split([char]"`n", [StringSplitOptions]::TrimEntries -bor [StringSplitOptions]::RemoveEmptyEntries)
    }

    [bool] GetBool([string]$key) {
        return $this._inputs[$key] -eq 'true'
    }

    [int] GetInt([string]$key) {
        return $this._inputs[$key]
    }
}

$inputs = [Inputs]::new($InputsJson)

$workingdir = $inputs.GetString('working-directory')
if ($workingdir) {
    Set-Location -LiteralPath $workingdir
}

$params = @{
    GitHubToken               = ConvertTo-SecureString -String $inputs.GetString('token') -AsPlainText
    Projects                  = $inputs.GetArray('projects')
    NoRestore                 = $inputs.GetBool('no-restore')
    NuGetConfig               = $inputs.GetString('nuget-config')
    NuGetSources              = $inputs.GetArray('nuget-sources')
    IncludeOutdatedTransitive = $inputs.GetBool('include-outdated-transitive')
    ArtifactName              = $inputs.GetString('artifact-name')
    IssueLabels               = $inputs.GetArray('issue-labels')
}

& "$PSScriptRoot/src/checkDependencies.ps1" @params
