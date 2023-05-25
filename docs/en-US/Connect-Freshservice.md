---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Connect-Freshservice

## SYNOPSIS
Sets the required variables for the Freshservice tenant with named connection created with
New-FreshServiceConnection.
This is required to be run at the start of a new session to establish
the tenant that will be used for cmdlet execution.

## SYNTAX

```
Connect-Freshservice [-Name] <String> [-PassThru] [-NoBanner] [<CommonParameters>]
```

## DESCRIPTION
Imports the saved configuration and sets the required variables for the Freshservice tenant with named
connection created with New-FreshServiceConnection.
This is required to be run at the start of a new session to establish
the tenant that will be used for cmdlet execution.

## EXAMPLES

### EXAMPLE 1
```
Connect-Freshservice -Name acme_prod
```

Use a stored connection created with New-FreshServiceConnection to establish variables for FreshservicePS cmdlets.

## PARAMETERS

### -Name
Friendly name of the connection created with New-FreshServiceConnection (e.g.
acme_prod). 
See existing connections, seeh Get-FreshServiceConnection.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Return session data.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoBanner
No banner for the hard working team building the module.
;)

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: LeaveMeAlone

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
This module was developed and tested with Freshservice REST API v2.

## RELATED LINKS
