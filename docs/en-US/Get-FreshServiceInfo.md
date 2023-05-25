---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceInfo

## SYNOPSIS
Returns a Freshservice information.

## SYNTAX

```
Get-FreshServiceInfo [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice information via REST API.

This is a test\helper command to see what tenant is currently connected and show the consumption of API throttle limits.
Ideally,
there would be an endpoint to GET basic tenant information like owners, licensing details, etc.
that could be used. 
There is
and alias 'whofs' to validate connection quickly and cmdlets support -WhatIf and will show impacted url.

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceInfo
```

Returns a Freshservice connection information.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
This module was developed and tested with Freshservice REST API v2.

## RELATED LINKS
