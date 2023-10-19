---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Set-FreshServiceConnection

## SYNOPSIS
Updates a Freshservice connection.

## SYNTAX

```
Set-FreshServiceConnection [-Name] <String> [[-NewName] <String>] [[-ApiKey] <String>] [[-Tenant] <String>]
 [[-EmailAddress] <String>] [[-Environment] <String>] [-Default] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a Freshservice connection and stores it in a configuration file %APPDATA%\FreshservicePS\FreshservicePS.config.
Freshservice is a session-less API, the settings created with this cmdlet are used as
global variables for function\cmdlet execution in the module.

Note: The API Key is encrypted using Powershell encyption, which requires decryption by the same user and machine the encryption occured with. 
This configuration will only work on the same machine\same user.

## EXAMPLES

### EXAMPLE 1
```
Set-FreshServiceConnection -Name acme -ApiKey 'goiureU89h98hhn9i8un'
```

Name         : acme
ApiKey       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000007e4a195d8e42ce4d992875f98947a69c000000000200000000001066000000010000200000007d6b0edd48041f1e0f8fb47cb760a57bbbc9479a686928278e8044c09cca5a13000000000e8000000002000020000000bb98d9971951f36853d81a4aab84e6cf2c8d0d34789d834fc1fe373870a4764930000
            000951d09207552e120eb4e64b3edb263d7988d67533d64137c85645ce3a9e99b4a204c9b434c68823b2eea1f99f662bb1c400000004e3cd039c10be12adbdee7a8bd683575df2dcd70c98e60751366cf0332c9e69eecc29db7bbfc0e6e9a135fb8d0c155c2f96364bfbadda7dd7f29283d42322f2d
Tenant       : acme-corp
BaseUri      : https://acme-corp.freshservice.com/api/v2
EmailAddress : john.smith@acme-corp.com
Environment  : Production
Default      : True

Update a Freshservice connection configuration with a new API key.

### EXAMPLE 2
```
Set-FreshServiceConnection -Name acme -NewName acme_prod
```

Name         : acme_prod
ApiKey       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000007e4a195d8e42ce4d992875f98947a69c000000000200000000001066000000010000200000007d6b0edd48041f1e0f8fb47cb760a57bbbc9479a686928278e8044c09cca5a13000000000e8000000002000020000000bb98d9971951f36853d81a4aab84e6cf2c8d0d34789d834fc1fe373870a4764930000
            000951d09207552e120eb4e64b3edb263d7988d67533d64137c85645ce3a9e99b4a204c9b434c68823b2eea1f99f662bb1c400000004e3cd039c10be12adbdee7a8bd683575df2dcd70c98e60751366cf0332c9e69eecc29db7bbfc0e6e9a135fb8d0c155c2f96364bfbadda7dd7f29283d42322f2d
Tenant       : acme-corp
BaseUri      : https://acme-corp.freshservice.com/api/v2
EmailAddress : john.smith@acme-corp.com
Environment  : Production
Default      : True

Update a Freshservice connection configuration with a new friendly name.
Then connecting to the environment would be Connect-Freshservice -Name acme_prod

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

### -NewName
The new name to rename the friendly name of this configuration.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ApiKey
API Key name of the environment. 
This value is stored encypted in the configuration file.
The API Key is encrypted using Powershell encyption, which requires decryption by the same user and machine the encryption occured with.
This configuration will only work on the same machine\same user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tenant
The name of the Freshservice tenant.
For example, if the url was https://acmecorp.freshservice.com would be tenant "acmecorp".

```yaml
Type: String
Parameter Sets: (All)
Aliases: ComputerName, Instance

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EmailAddress
Email address of the user for the API key.
This is not mandatory, but is simply for reference to know who the API key is linked to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Environment
The type of environment this configuration will connect to, Production or Sandbox.
This builds the url for the Freshservice tenant:

Production =  https://TENANT.freshservice.com/api/v2
Sandbox    =  https://TENANT-fs-sandbox.freshservice.com/api/v2

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Default
Setting Default to $true will automatically connect to this tenant during module import.
If no default is set, Connect-FreshService will need to be executed after module import to establish variables.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
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
