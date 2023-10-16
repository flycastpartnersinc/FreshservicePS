---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceCustomObject

## SYNOPSIS
Returns a Freshservice Custom Object.

## SYNTAX

### default (Default)
```
Get-FreshServiceCustomObject [[-workspace_id] <Int32>] [[-per_page] <Int32>] [[-page] <Int32>]
 [<CommonParameters>]
```

### id
```
Get-FreshServiceCustomObject [-Id] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Custom Object via REST API.

https://api.freshservice.com/#list_all_custom_objects

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceCustomObject
```

id              : 21000011818
title           : Service Item Approvals
description     : This is a sample object to store additional information about the Items available on the Service
                Catalog such as designated Approvers, Vendor Information and Category.
When a request for an item
                in this list is raised, you can use this information within the workflows to enrich your
                automations.
Check out our sample workflow "Service Item Approvals/Routing with Custom Objects"
updated_at      : 8/29/2022 2:17:57 PM
last_updated_by : @{email=system-noreply@its-fine.freshservice.com; id=21000418007; name=System}

Returns all Freshservice Custom Objects.

### EXAMPLE 2
```
Get-FreshServiceCustomObject -id 21000011818
```

id          : 21000011818
name        : service_item_approva_11
title       : Service Item Approvals
description : This is a sample object to store additional information about the Items available on the Service
            Catalog such as designated Approvers, Vendor Information and Category.
When a request for an item in
            this list is raised, you can use this information within the workflows to enrich your automations.
            Check out our sample workflow "Service Item Approvals/Routing with Custom Objects"
fields      : {@{name=item_name; label=Item Name; type=lookup; required=True; choices=System.Object\[\]; meta=},
            @{name=approver; label=Approver; type=lookup; required=False; choices=System.Object\[\]; meta=},
            @{name=vendor_information; label=Vendor Information; type=text; required=False;
            choices=System.Object\[\]; meta=}, @{name=category; label=Category; type=dropdown; required=False;
            fields=System.Object\[\]; choices=System.Object\[\]; meta=}...}
meta        : @{total_records_count=10}

Returns a Freshservice Custom Object by Id.

## PARAMETERS

### -Id
Unique id of the Custom Object.

```yaml
Type: Int64
Parameter Sets: id
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -workspace_id
Workspace id filter is applicable only for accounts with Workspaces feature enabled. Providing a Workspace_id will return tickets from a specific workspace.

If the workspace_id(s) parameter is NOT provided, data will only be returned for the Default\Primary Workspace.
If the workspace_id(s) parameter is provided, data will be returned from the specified Workspaces.
If the workspace_id value is 0, data will be returned from all workspaces (the user has access to), with only global level fields.

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -per_page
Number of records to return per page during pagination. 
Maximum of 100 records.

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 2
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
The page number to retrieve during pagination.

```yaml
Type: Int32
Parameter Sets: default
Aliases:

Required: False
Position: 3
Default value: 1
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
