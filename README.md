# Jira Block

### Why use the Looker Jira Block?
**(1) Rapid Time To Value** - gain insights from your Jira data in hours, not weeks. The Jira Block includes pre-built dashboards and content focusing on the Agile methodology, with analysis around Projects, Versions, Springs, and Issues. Additionally, this Data is organized to mask many of the complexities of Jira.

**(2) Centralized Place for Analysis** -  No Jira access required to do self-service reporting. Plus, you can combine your Jira data with other data in your warehouse (e.g. Bitbucket or Github commits) for end-to-end analysis.

**(3) Enterprise Data Platform** - Project Managers and Scrum Masters can easily build their own dashboards, and any user is equipped to ask and answer their own questions, save and share their own reports. Additionally, you can take advantage of Looker's advanced scheduling functionality to get Alerts whenever workflows are disrupted.

  
### Jira Data Structure and Schema

Looker’s Jira Block is designed to work with the Fivetran Jira schema.  Fivetran has abstracted away many of the complexities of the Jira data model to make it easier for reporting purposes.  Because the Jira schema is very customizable and is different for every implementation, rather than attempting to replicate the exact structure of the Jira schema, Fivetran stores the data in more compact format, with Issues as the central focus.

The Fivetran schema for Jira data can be found [here](https://www.fivetran.com/docs/applications/jira).

A more detailed description of how to deploy Looker Blocks in your environment can be found [here](https://discourse.looker.com/t/copying-a-lookml-project-into-looker-from-a-github-repo/1209).


Understanding the Fivetran implementation of the Jira data model is important for understanding the LookML model and how you will enhance it based on your own customized version of Jira.  In a typical implementation, the majority of the customizations will be related to the `issue` table, so most of the following discussion will focus on the `issue` table.  

#### The `issue` table is comprised of three primary types of fields:

* **1. A standard text field** -  A standard text field appears on the Jira UI as a text box that you can type a value into.  There are some more sophisticated ways of doing this in Jira, such as a Date Picker field, but the result is still a single value. When the data is stored in the database, the actual value that you entered is stored as a field in the `issue` table.

* **2. A Single Value Select Field** -  A Single Value Select Field allows you to choose one value from a pre-defined list of values.  This may be from a dropdown list in the UI, or a set of radio buttons.  When the data is stored in the database, rather than storing the value that you chose, a numeric id is stored in the `issue` table.  The text value associated with this id is found in another table.  In most cases, the id will be found in the table `field_option` which contains the id and associated value for most custom Select fields.  There are some exceptions.  If the Select field is referencing an entity that has its own dimension table, then the id would be found in the corresponding dimension table.  For example, if you selected the `Issue Status` from a drop-down list, the id stored in the `issue` table would correspond to an id in the `status` table.

* **3.  A Multi Value Select Field** -  A Multi Value Select Field allows you to choose one or more values from a pre-defined list of values.  This may be from a dropdown list in the UI or a set of checkboxes.  When the data is stored in the database, the id associated with the selection is stored in the database similar to how it is described in the Single Value Select Field.  However, instead of being stored in the `issue` table, the id(s) will be stored in a standalone table that follows the naming convention `issue_[field_name]`.  For example, if you had added a new Multi Value Select Field to the `issue` table called `Browsers Supported`, and provided a list of possible values that a user could choose from, the ids associated with those selections would be stored in a table named `issue_browsers_supported` along with the associated issue id, and the value associated with the browser supported id would be found in the `field_option` table.  Every Multi Value Select Field associated with the issue will have its own standalone table.

#### History tables

* Fivetran also provides history tables that store the change history of each field in the issue table, including multi value select fields.  Each field will have a separate history table associated with it which follows the naming convention `issue_[field_name]_history`.  These tables store the issue id, the previous value of the field and the date of the change.

* It is worth noting that Fivetran will not create a table until you insert data in the corresponding table in Jira.  For example, until you modify the status of any issue at least once, your schema will not contain an `issue_status_history` table.  For Jira installations that have been in use for a while, the only tables that won't be part of your initial Fivetran schema would be related to new custom fields that you add.  For newer installations, it's possible that there will be new history tables added periodically as fields are updated for the first time, as well as new tables associated with new custom fields.  These tables will need to be added manually to your LookML Model.

### Jira Block Structure

The `issue` table is highly customizable.  Administrators can add any additional fields necessary for capturing the data that makes tracking and reporting more effective.  These additional fields can be either Single Select Fields or Multi-Select Fields.  As the names imply, a Single Select Field can only contain one value, and a Multi-Select field can contain several values.  Single Select issue fields are stored in the `issue` table.  Multi-Select fields are stored in separate tables.  For example, an issue may affect several customers, so it is represented by a multi-select field in the Jira UI, and stored in a separate table in the Fivetran Jira schema named `issue_customer_impacted`.

The `issue_extended` table is a denormalized Looker PDT that contains all of the information related to an issue.  The view file contains detailed information on how to update the PDT for your Jira environment.  Any changes made to the `issue` table will generally need to be reflected in the `issue_extended` PDT as well.

### Customizations

* (1) The number of custom fields and associated history tables will differ for each Jira installation.  As a result, the Looker Jira Block will require customization before it can be used.  The LookML model and view files included with the block provide a good general template, but will definitely differ from your Fivetran schema.  In particular, the following changes will need to be made to the model:
The fields in the issue table will need to be updated to match your own issue table.  You will likely need to add new fields to the Looker issue view file for your own custom fields, as well as removing fields from the view file that are not included in your installation.
* (2) Looker view files will need to be removed that are associated with Multi-Select Fields that are not included in your installation.  These tables have the naming convention `issue_<field_name>`
* (3) Looker view files that are associated with history tables associated with both Single Select Fields and Multi Select Fields that are not included in your installation will need to be removed.  These tables have the naming convention `issue_<field_name>_history`.
* (4) Additional View Files will need to be added for the additional fields and history tables included in your installation.  Adding these additional view files is a simple process.  While in Development Mode, select “Create View From Table” from the “Add Files” menu.  Select the correct connection and schema, and then add select each of that tables that do not already appear in your current list of view files.  Looker will automatically generate the view files for each additional table.
* (5) Modify the Looker view file `issue_history_all` to remove any of the `UNION`s defined for tables that are not part of your installation.
* (6) Modify the Looker view file `issue_history_all` to add any new `UNION`s required for history tables that are not currently included.

#### Notes for updating #5 and #6 above:

When adding new tables to the `UNION` in `issue_history_all`, there are two different forms that the new UNIONed table can take -
* (1)  A history table for a standard field.  This is a field that is included as part of the default Jira schema.  These history tables can be identified by examining the table definition.  History tables for standard fields will contain a column named value, which will contain the actual text representation of the value.  For example, in the table `issue_browser_history`, which stores the history for a standard field, the value column contains entries such as Chrome, Safari and Firefox.
* (2)  A history table for a custom field.  This is a field that was added by the Jira administrator and is not part of the default Jira schema.  These history tables can also be identified by examining the table definition.  History tables for custom fields will contain a column named `field_option_id`.  This field contains a numeric value, which is actually a foreign key to the table `field_option`, which contains the domain of allowable values for each custom field.

Format for adding a history table for a standard field:
```
select "issue_id", "time", "value", 'Issue Browser' as "changed" from jira.issue_browser_history
```
Format for adding a history table for a custom field:
```
select erh."issue_id", erh."time", fo."name", 'Op Equipment Request' as "changed" from jira.issue_op_equipment_request_history erh
LEFT OUTER JOIN jira.field_option fo on erh.field_option_id = fo.id
```

### What if I find an error? Suggestions for improvements?

Great! Blocks were designed for continuous improvement through the help of the entire Looker community, and we'd love your input. To log an error or improvement recommentation, simply create a "New Issue" in the corresponding [Github repo for this Block](https://github.com/llooker/jira_block_fivetran/issues). Please be as detailed as possible in your explanation, and we'll address it as quick as we can.

