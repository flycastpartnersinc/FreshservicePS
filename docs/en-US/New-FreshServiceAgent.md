---
external help file: PSFreshservice-help.xml
Module Name: PSFreshservice
online version:
schema: 2.0.0
---

# New-FreshServiceAgent

## SYNOPSIS
Creates a new Freshservice Agent.

## SYNTAX

```
New-FreshServiceAgent [-first_name] <String> [[-last_name] <String>] [[-occasional] <Boolean>]
 [[-job_title] <String>] [-email] <String> [[-work_phone_number] <String>] [[-mobile_phone_number] <String>]
 [[-department_ids] <Int64[]>] [[-can_see_all_tickets_from_associated_departments] <Boolean>]
 [[-reporting_manager_id] <Int64>] [[-address] <String>] [[-time_zone] <String>] [[-time_format] <String>]
 [[-language] <String>] [[-location_id] <Int64>] [[-background_information] <String>]
 [[-scoreboard_level_id] <Int32>] [[-member_of] <Int64[]>] [[-observer_of] <Int64[]>] [-roles] <Object[]>
 [[-signature] <String>] [[-custom_fields] <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new Freshservice Agent via REST API.

https://api.freshservice.com/#create_an_agent

## EXAMPLES

### EXAMPLE 1
```
$newFreshServiceAgentRoleConfigSplat1 = @{
   role_id          = 21000150301 #IT Ops Agent - Get-FreshServiceAgentRole
   assignment_scope = 'specified_groups'
   groups           = 21000188388,21000188389 #Incident Team and Major Incident Team- Get-FreshServiceAgentGroup
}
```

$newFreshServiceAgentRoleConfigSplat2 = @{
   role_id          = 21000150294 #SD Supervisor - Get-FreshServiceAgentRole
   assignment_scope = 'specified_groups'
   groups           = 21000188403 #Helpdesk Monitoring Team - Get-FreshServiceAgentGroup
}

$agentRoles = foreach ($splat in @($newFreshServiceAgentRoleConfigSplat1, $newFreshServiceAgentRoleConfigSplat2)) {
   New-FreshServiceAgentRoleConfig @splat
}

$newFreshServiceAgentSplat = @{
   first_name             = 'Ralph'
   last_name              = 'smith'
   job_title              = 'Code Monkey'
   email                  = 'Alex.agent@example.com'
   background_information = 'Awesome helpdesk training'
   roles = $agentRoles
}

New-FreshServiceAgent @newFreshServiceAgentSplat

active                                          : True
address                                         :
auto_assign_status_changed_at                   :
auto_assign_tickets                             : True
background_information                          : Awesome helpdesk training
can_see_all_tickets_from_associated_departments : False
created_at                                      : 3/27/2023 5:10:31 PM
custom_fields                                   : @{employee_id=}
department_ids                                  : {}
department_names                                :
email                                           : Alex.agent2@example.com
external_id                                     :
first_name                                      : Ralph
has_logged_in                                   : False
id                                              : 21001941828
job_title                                       : Code Monkey
language                                        : en
last_active_at                                  :
last_login_at                                   :
last_name                                       : Smith
location_id                                     :
location_name                                   :
mobile_phone_number                             :
occasional                                      : False
reporting_manager_id                            :
role_ids                                        : {21000150301, 21000150294}
roles                                           : {@{role_id=21000150294; assignment_scope=specified_groups;
                                               groups=System.Object\[\]}, @{role_id=21000150301;
                                               assignment_scope=specified_groups; groups=System.Object\[\]}}
scopes                                          : @{ticket=; problem=; change=; asset=; solution=; contract=}
scoreboard_level_id                             : 1
scoreboard_points                               :
signature                                       :
time_format                                     : 12h
time_zone                                       : Eastern Time (US & Canada)
updated_at                                      : 3/27/2023 5:10:31 PM
vip_user                                        : False
work_phone_number                               :
group_ids                                       : {}
member_of                                       : {}
observer_of                                     : {}
member_of_pending_approval                      : {}
observer_of_pending_approval                    : {}

Adds a new Freshservice Agent.
There is a helper function New-FreshServiceAgentRoleConfig to assist with creating roles
based on the documentation format, which generates a PSObject.
Note there are dependent ids that can be obtained from other cmdlets
(e.g.
Get-FreshServiceAgentRole and Get-FreshServiceAgentGroup) Multiple roles can be mapped to a single Agent.

## PARAMETERS

### -first_name
First name of the agent.

```yaml
Type: String
Parameter Sets: (All)
Aliases: FirstName

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -last_name
Last name of the agent.

```yaml
Type: String
Parameter Sets: (All)
Aliases: LastName

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -occasional
True if the agent is an occasional agent, and false if full-time agent.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -job_title
Job title of the agent.

```yaml
Type: String
Parameter Sets: (All)
Aliases: JobTitle

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -email
Email address of the agent.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -work_phone_number
Work phone number of the agent.

```yaml
Type: String
Parameter Sets: (All)
Aliases: WorkNumber, WorkPhoneNumber

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -mobile_phone_number
Mobile phone number of the agent.

```yaml
Type: String
Parameter Sets: (All)
Aliases: MobilePhone, MobilePhoneNumber

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -department_ids
Unique IDs of the departments associated with the agent.

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases: DepartmentId

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -can_see_all_tickets_from_associated_departments
Set to true if the agent must be allowed to view tickets filed by other members of the department, and false otherwise.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -reporting_manager_id
User ID of the agent's reporting manager.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: ReportingManagerId

Required: False
Position: 10
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -address
Address of the agent.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -time_zone
Time zone of the agent.

```yaml
Type: String
Parameter Sets: (All)
Aliases: TimeZone

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -time_format
Time format for the agent.
Possible values:

    12h (12 hour format)
    24h (24 hour format)

```yaml
Type: String
Parameter Sets: (All)
Aliases: TimeFormat

Required: False
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -language
Language used by the agent.
The default language is "en" (English).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -location_id
Unique ID of the location associated with the agent.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases: LocationId

Required: False
Position: 15
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -background_information
Background information of the agent.

```yaml
Type: String
Parameter Sets: (All)
Aliases: BackgroundInformation

Required: False
Position: 16
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -scoreboard_level_id
Unique ID of the level of the agent in the Arcade.
Possible values:--1 (Beginner)--2 (Intermediate)--3 (Professional)--4 (Expert)--5 (Master)--6 (Guru)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ScoreboardLevel

Required: False
Position: 17
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -member_of
Unique IDs of the groups that the agent is a member of.
The response value for this field would only contain the list of groups that the agent is an approved member of.
The member_of_pending_approval read-only attribute in the response will include the list of groups for which the agent's member access is pending approval by a group leader.

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases: MemberOf

Required: False
Position: 18
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -observer_of
Unique IDs of the groups that the agent is an observer of.
The response value for this field would only contain the list of groups that the agent is an approved observer
of.
The observer_of_pending_approval read-only attribute in the response will include the list of groups for which the agent's observer access is pending approval by a group leader.

```yaml
Type: Int64[]
Parameter Sets: (All)
Aliases: ObserverOf

Required: False
Position: 19
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -roles
Each individual role is a hash in the roles array that contains the attributes.role_id: Unique ID of the role assigned"assignment_scope: The scope in which the
agent can use the permissions granted by this role.
Possible values include entire_helpdesk (all plans)

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 20
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -signature
Signature of the agent in HTML format.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -custom_fields
Key-value pair containing the names and values of the (custom) agent fields.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: CustomFields

Required: False
Position: 22
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
