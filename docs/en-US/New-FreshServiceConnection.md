---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# New-FreshServiceConnection

## SYNOPSIS
Creates a new Freshservice connection.

## SYNTAX

```
New-FreshServiceConnection [-Name] <String> [-ApiKey] <String> [-Tenant] <String> [[-EmailAddress] <String>]
 [[-Environment] <String>] [[-Default] <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new Freshservice connection and stores it in a configuration file %APPDATA%\FreshservicePS\FreshservicePS.config.
Freshservice is a session-less API, the settings created with this cmdlet are used as
global variables for function\cmdlet execution in the module.

Note: The API Key is encrypted using Powershell encyption, which requires decryption by the same user and machine the encryption occured with. 
This configuration will only work on the same machine\same user.

## EXAMPLES

### EXAMPLE 1
```
New-FreshServiceConnection -Name acme -ApiKey 'd8werre9whw9fhwe9we' -Tenant 'acme-corp' -Environment Production -Email 'john.smith@acme-corp.com' -Default $true
```

Name         : acme
ApiKey       : 01000000d08c9ddf0115d1118c7a00c04fc297eb010000007e4a195d8e42ce4d992875f98947a69c000000000200000000001066000000010000200000008d165ed92b4f54b17914ff7a7b310584a63f994655b4902a43acc5923ba7ce8d000000000e8000000002000020000000d2f87099660baffe819ba17f9376db4072427dd6a7ae8adc05ac916c0d38be3c30000
            0004a2510e4b9c34b47c44e1e23d187e92897c1880d3979e1b08d115a7e438a79b11b905166ecd165cc3247a2ea8762f1d440000000531a8820dbd5df4424f33761db4e743590b872fb34917cde887136dde71aec21f49dd5ede02259770e726030ff6647b70b69730e5dd1fdcaba4c86f640cf2076
Tenant       : acme-corp
BaseUri      : https://acme-corp.freshservice.com/api/v2
EmailAddress : john.smith@acme-corp.com
Environment  : Production
Default      : True

Create a new Freshservice connection configuration. 
Default will automatically connect with these settings during module import.

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
Accept pipeline input: False
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

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tenant
The name of the Freshservice tenant.
For example, if the url was https://acmecorp.freshservice.com would be tenant "acmecorp".

```yaml
Type: String
Parameter Sets: (All)
Aliases: ComputerName, Instance

Required: True
Position: 3
Default value: None
Accept pipeline input: False
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
Position: 4
Default value: None
Accept pipeline input: False
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
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Default
Setting Default to $true will automatically connect to this tenant during module import.
If no default is set, Connect-FreshService will need to be executed after module import to establish variables.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
