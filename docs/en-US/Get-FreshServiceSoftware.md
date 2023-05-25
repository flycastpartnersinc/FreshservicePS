---
external help file: FreshservicePS-help.xml
Module Name: FreshservicePS
online version:
schema: 2.0.0
---

# Get-FreshServiceSoftware

## SYNOPSIS
Returns a Freshservice Software.

## SYNTAX

### default (Default)
```
Get-FreshServiceSoftware [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### license
```
Get-FreshServiceSoftware [-Id] <Int64> [-licenses] [<CommonParameters>]
```

### relationship
```
Get-FreshServiceSoftware [-Id] <Int64> [-relationships] [<CommonParameters>]
```

### id
```
Get-FreshServiceSoftware [-Id] <Int64> [<CommonParameters>]
```

### field
```
Get-FreshServiceSoftware [-fields] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Software via REST API.

https://api.freshservice.com/#view_a_software

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceSoftware
```

additional_data    : @{overview=; graph_data=; last_sync_date=}
user_count         : 1
installation_count : 0
id                 : 21000240239
name               : Freshservice
description        :
notes              :
publisher_id       : 21000085374
created_at         : 8/29/2022 2:17:54 PM
updated_at         : 8/29/2022 2:17:54 PM
application_type   : saas
status             : managed
managed_by_id      : 21000418006
category           : IT Service Management
sources            : {}

additional_data    : @{overview=; graph_data=; last_sync_date=}
user_count         : 1
installation_count : 1
id                 : 21000240240
name               : Microsoft Office 365
description        :
notes              :
publisher_id       : 21000085375
created_at         : 8/29/2022 2:17:54 PM
updated_at         : 8/29/2022 2:17:54 PM
application_type   : desktop
status             : managed
managed_by_id      : 21000418006
category           : Office Suite
sources            : {}

Returns all Freshservice Software.

### EXAMPLE 2
```
Get-FreshServiceSoftware -id 21000240239
```

additional_data    : @{overview=; graph_data=; last_sync_date=}
user_count         : 1
installation_count : 0
id                 : 21000240239
name               : Freshservice
description        :
notes              :
publisher_id       : 21000085374
created_at         : 8/29/2022 2:17:54 PM
updated_at         : 8/29/2022 2:17:54 PM
application_type   : saas
status             : managed
managed_by_id      : 21000418006
category           : IT Service Management
sources            : {}

Returns specific Freshservice Software by Id.

### EXAMPLE 3
```
Get-FreshServiceSoftware -id 21000240239 -relationships
```

id                   : 21000037748
relationship_type_id : 21000356895
primary_id           : 21000240239
primary_type         : software
secondary_id         : 1
secondary_type       : asset
created_at           : 3/27/2023 2:35:44 PM
updated_at           : 3/27/2023 2:35:44 PM

Returns a Freshservice Software relationships (Asset).

### EXAMPLE 4
```
Get-FreshServiceSoftware -id 21000240239 -licenses
```

id contract_id created_time         updated_time
        -- ----------- ------------         ------------
21000035046 CNTR-2      8/29/2022 2:17:54 PM 8/29/2022 2:17:54 PM
21000105003 CNTR-23     3/27/2023 2:38:11 PM 3/27/2023 2:38:55 PM

Returns a Freshservice Software Licenses (Contracts).

### EXAMPLE 5
```
Get-FreshServiceSoftware -fields
```

id            : 4e62967fc6786cc38f3631fee24581486bc5
name          : name
default       : True
position      : 1
deleted       : False
required      : True
visible       : True
label         : Name
placeholder   : Enter Software Name
type          : 1001
choices       : {}
fields        : {}
field_options :
dom_type      : text
column_name   :
custom        : False
choices_hash  :
hint          :

id            : 69bbba5a2111dea1c23581a5e6e3db347034
name          : description
default       : True
position      : 2
deleted       : False
required      : False
visible       : True
label         : Description
placeholder   : Enter Description
type          : 1008
choices       : {}
fields        : {}
field_options :
dom_type      : paragraph
column_name   :
custom        : False
choices_hash  :
hint          :

id            : c910ea29f31d5440404810baa996542a7932
name          : status
default       : True
position      : 3
deleted       : False
required      : False
visible       : True
label         : Status
placeholder   : Select Software Status
type          : 1003
choices       : {}
fields        : {}
field_options :
dom_type      : dropdown_blank
column_name   :
custom        : False
choices_hash  :
hint          :

id            : 2d52ad2194d15d9b7bfe8d95a227dcd17dd7
name          : application_type
default       : True
position      : 4
deleted       : False
required      : True
visible       : True
label         : Type
placeholder   : Select Software Type
type          : 1003
choices       : {}
fields        : {}
field_options :
dom_type      : dropdown_blank
column_name   :
custom        : False
choices_hash  :
hint          :

id            : 7c33d090338783d7edd4b3c095de5df24838
name          : manufacturer_id
default       : True
position      : 5
deleted       : False
required      : False
visible       : True
label         : Publisher
placeholder   : Select Publisher
type          : 1003
choices       : {}
fields        : {}
field_options :
dom_type      : dropdown_blank
column_name   :
custom        : False
choices_hash  :
hint          :

id            : 39c79d5de50f8617c2fa0b55ecbd0a671aff
name          : category_id
default       : True
position      : 6
deleted       : False
required      : False
visible       : True
label         : Category
placeholder   : Select Software Category
type          : 1003
choices       : {}
fields        : {}
field_options :
dom_type      : dropdown_blank
column_name   :
custom        : False
choices_hash  :
hint          :

id            : 5dec971f547af6e86546583daf32054c7c79
name          : user_id
default       : True
position      : 7
deleted       : False
required      : False
visible       : True
label         : Managed by
placeholder   : Select User
type          : 1003
choices       : {}
fields        : {}
field_options :
dom_type      : dropdown_blank
column_name   :
custom        : False
choices_hash  :
hint          :

id            : f0457c87bedb0f3a4355d375d87c45ff0bc8
name          : notes
default       : True
position      : 8
deleted       : False
required      : False
visible       : True
label         : Notes
placeholder   : Enter Notes
type          : 1008
choices       : {}
fields        : {}
field_options :
dom_type      : paragraph
column_name   :
custom        : False
choices_hash  :
hint          :

id            : 86859e49-23de-4196-8016-54659cbd19cf
name          : cf_registry_path
default       : False
position      : 9
deleted       : False
required      : False
visible       : True
label         : Registry Path
placeholder   :
type          : 1001
choices       : {}
fields        : {}
field_options : @{pdf=true; date_only=true; required_for_create=false; visible_in_portal=true; visible_in_public=false; required_for_closure=false}
dom_type      : text
column_name   : cf_blob01
custom        : True
choices_hash  :
hint          :

Lists fields for Freshservice software.

## PARAMETERS

### -Id
Unique id of the Software.

```yaml
Type: Int64
Parameter Sets: license, relationship, id
Aliases: software_id

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -relationships
Lists all the relationships of a particular software.

```yaml
Type: SwitchParameter
Parameter Sets: relationship
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -licenses
List all licenses of a software (e.g.
Contracts)

```yaml
Type: SwitchParameter
Parameter Sets: license
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
Lists fields on Software form.

```yaml
Type: SwitchParameter
Parameter Sets: field
Aliases: form

Required: True
Position: 2
Default value: False
Accept pipeline input: False
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
Position: 3
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
Position: 4
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
