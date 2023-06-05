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
Connect-Freshservice [-Name] <String> [-PassThru] [-NoBanner] [-NoThrottle] [<CommonParameters>]
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

### -NoThrottle
Disable artificial throttling.

**WARNING** The API rate limit is applied on an account wide basis irrespective of factors such as
the number of agents or IP addresses used to make the calls.  There are numerous API calls that can consume multiple API calls
for single get operations (e.g. Get-FSAsset -IncludeTypeFields = 3 API credits for each call). Throttling will slow
the API calls down ggadually the closer the query gets to consuming all calls forcing a 429 Retry-After which affects all API
calls to the account.  Here is the breakdown:

Consumed calls greater than 70% = 5 seconds
Consumed calls greater than 80% = 15 seconds
Consumed calls greater than 90% = 30 seconds

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
This module was developed and tested with Freshservice REST API v2.

## RELATED LINKS
