# Copyright (c) 2023 Matthias Wolf, Mawosoft.

#Requires -Version 7.2

[CmdletBinding()]
param(
    [Parameter(Mandatory, Position = 0)]
    [ValidateNotNullOrEmpty()]
    [string]$InputsJson
)

# TODO Validate inputs and pass to real script
