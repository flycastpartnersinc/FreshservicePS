---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Remove-FreshServiceConnection

## SYNOPSIS
Delete a Freshservice Connection.

## SYNTAX

```
Remove-FreshServiceConnection [-Name] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Delete a named Freshservice Connection stored in the configuration file %APPDATA%\PSFreshservice\PSFreshservice.config.

## EXAMPLES

### EXAMPLE 1
```
Remove-FreshServiceConnection -Name acme_sandbox
```

Name         : acme_prod
ApiKey       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000007e4a195d8e42ce4d992875f98947a69c000000000200000000001066000000010000200000007d6b0edd48041f1e0f8fb47cb760a57bbbc9479a686928278e8044c09cca5a13000000000e8000000002000020000000bb98d9971951f36853d81a4aab84e6cf2c8d0d34789d834fc1fe373870a4764930000
            000951d09207552e120eb4e64b3edb263d7988d67533d64137c85645ce3a9e99b4a204c9b434c68823b2eea1f99f662bb1c400000004e3cd039c10be12adbdee7a8bd683575df2dcd70c98e60751366cf0332c9e69eecc29db7bbfc0e6e9a135fb8d0c155c2f96364bfbadda7dd7f29283d42322f2d
Tenant       : acme-corp
BaseUri      : https://acme-corp.freshservice.com/api/v2
EmailAddress : john.smith@acme-corp.com
Environment  : Production
Default      : True

Remove a Freshservice Connection.

## PARAMETERS

### -Name
Friendly name of the configuration being saved. 
This is what will be referenced with the Connect-FreshService cmdlet. 
For instance,
if this was the configuration for the production service account for Acme, you could do Acme_Prod.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
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
