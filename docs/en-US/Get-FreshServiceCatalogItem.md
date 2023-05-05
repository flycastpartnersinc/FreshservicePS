---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# Get-FreshServiceCatalogItem

## SYNOPSIS
Returns a Freshservice Service Catalog Item.

## SYNTAX

### default (Default)
```
Get-FreshServiceCatalogItem [[-per_page] <Int32>] [[-page] <Int32>] [<CommonParameters>]
```

### id
```
Get-FreshServiceCatalogItem [[-display_id] <Int64>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Freshservice Service Catalog Item via REST API.

https://api.freshservice.com/#view_service_item

## EXAMPLES

### EXAMPLE 1
```
Get-FreshServiceCatalogItem
```

id                       : 21000487383
created_at               : 8/29/2022 2:17:51 PM
updated_at               : 11/2/2022 4:01:03 PM
name                     : Adobe Illustrator CC
delivery_time            :
display_id               : 33
category_id              : 21000104300
product_id               :
quantity                 :
deleted                  : False
icon_name                : service-catalog-adobe-illustrator-cc-new
group_visibility         : 1
agent_group_visibility   : 1
item_type                : 1
ci_type_id               :
visibility               : 1
cost_visibility          : False
delivery_time_visibility : False
botified                 : False
allow_attachments        : False
allow_quantity           : False
is_bundle                : False
create_child             : False
configs                  : @{attachment_mandatory=False; subject=Request for {{requested_for}} : {{item.name}}}

id                       : 21000487351
created_at               : 8/29/2022 2:17:48 PM
updated_at               : 11/1/2022 8:21:30 PM
name                     : Office Desktop
delivery_time            : 48
display_id               : 1
category_id              : 21000104299
product_id               :
quantity                 :
deleted                  : False
icon_name                : service-catalog-desktop-new
group_visibility         : 1
agent_group_visibility   : 1
item_type                : 1
ci_type_id               : 21000855303
visibility               : 2
cost_visibility          : True
delivery_time_visibility : True
botified                 : False
allow_attachments        : False
allow_quantity           : True
is_bundle                : False
create_child             : False
configs                  :

id                       : 21000487352
created_at               : 8/29/2022 2:17:49 PM
updated_at               : 11/1/2022 8:21:31 PM
name                     : Windows Laptop
delivery_time            : 48
display_id               : 2
category_id              : 21000104299
product_id               :
quantity                 :
deleted                  : False
icon_name                : service-catalog-windows-laptop-new
group_visibility         : 1
agent_group_visibility   : 1
item_type                : 1
ci_type_id               : 21000855304
visibility               : 2
cost_visibility          : True
delivery_time_visibility : True
botified                 : False
allow_attachments        : False
allow_quantity           : True
is_bundle                : False
create_child             : False
configs                  :

Returns all FreshService Catalog Items.

### EXAMPLE 2
```
Get-FreshServiceCatalogItem -display_id 33
```

id                       : 21000487383
created_at               : 8/29/2022 2:17:51 PM
updated_at               : 11/2/2022 4:01:03 PM
name                     : Adobe Illustrator CC
delivery_time            :
display_id               : 33
category_id              : 21000104300
product_id               :
quantity                 :
deleted                  : False
icon_name                : service-catalog-adobe-illustrator-cc-new
group_visibility         : 1
agent_group_visibility   : 1
item_type                : 1
ci_type_id               :
visibility               : 1
cost_visibility          : False
delivery_time_visibility : False
botified                 : False
allow_attachments        : False
allow_quantity           : False
is_bundle                : False
create_child             : False
configs                  : @{attachment_mandatory=False; subject=Request for {{requested_for}} : {{item.name}}}
description              : The industry-standard vector graphics software
                                                        used worldwide by designers to create digital graphics, illustrations, and typography
                        for all kinds of media: print, web, interactive,
                                                        video, and mobile.
20GB of cloud storage to keep your files organized across multiple
                        computers and share your work with colleagues
                                                        and clients.
\<br\>\<br\>\<b\>Features\</b\> : \<br\>Touch Type Tool\<br\>Images in brushes\<br\>Font
                        search \<br\>Multiple-file place\<br\>CSS
                                                        extraction\<br\>Sync Colors\<br\>File Packaging \<br\>Platform : \<br\>Windows 8, Windows 7, Mac
                        OS X 10.7 Lion, Mac OS X 10.6 Snow Leopard\<br\>
                                                        \<br\>\<b\>System Requirements \<br\>\<br\>\</b\>Windows : \<br\>\<ul\>\<li\>Intel Pentium 4 or AMD
                        Athlon 64 processor (2GHz or faster)\</li\>\<li\>
                                                        Microsoft Windows 7 with Service Pack 1 or Windows 8\</li\>\<li\>1GB of RAM (3GB
                        recommended) for 32 bit; 2GB of RAM (8GB recommended)
                                                        for 64 bit\</li\>\<li\>2GB of available hard-disk space for installation;\</li\>\</ul\>Mac OS :
                        \<br\>\<ul\>\<li\>Multicore Intel processor with
                                                        64-bit support\</li\>\<li\>Mac OS X v10.6.8, v10.7, or v10.8\</li\>\<li\>2GB of RAM (8GB
                        recommended)\</li\>\<li\>2GB of available hard-disk space
                                                        for installation \</li\>\</ul\>

short_description        : Request for Adobe Illustrator CC
cost                     :
custom_fields            : {@{created_at=11/2/2022 4:01:03 PM; deleted=False; description=;
                        id=04dd495a-4a48-4910-aa3c-dcf26fb1fd20; label=My Computer; name=my_computer;
                        updated_at=11/2/2022 4:01:03 PM; field_options=; visible_in_portal=True;
                        field_type=custom_lookup_bigint; item_id=21000487383; position=1; required=False;
                        choices=System.Object\[\]; nested_fields=System.Object\[\]}}
child_items              : {}
icon_url                 : https://assets10.freshservice.com/assets/cdn-ignored/sprites/service-catalog/adobe-illustrato
                        r-cc-new-1b32ece533333a26632dba7a339b371ac57292cc4fe1baa633af2b2e8f0b4b07.png

Return FreshService Catalog Item by Id.

## PARAMETERS

### -display_id
Unique display id of the FreshService Service Catalog Item.

```yaml
Type: Int64
Parameter Sets: id
Aliases: DisplayId

Required: False
Position: 1
Default value: 0
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
