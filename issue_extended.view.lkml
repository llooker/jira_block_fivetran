### ISSUE_EXTENDED
# The issue_extended table is designed to make it easier for
# end users to work with the issue table.  The issue table
# contains many foreign keys to other tables and many subsidiary
# tables that contain the values of multi value select fields.
# This PDT is designed to consolidate all of that data in one
# place without the user having to worry about fanouts from joining
# to tables with multiple matching rows or any of the other complexities
# of working with the issue table.
# If any of the fields in the issue table aren't used as part of
# your business process, set them to "hidden: yes" to limit what the
# end user has to work with to only what they need.
# Make liberal user of "group_label" to organize the data in a way
# that is meaningful for your users.  There can be lots of columns
# so make them as easy to work woth as possible.

explore: issue_extended {}

view: issue_extended {
  derived_table: {
    datagroup_trigger: fivetran_datagroup
    sql: SELECT issue.*
               -- Include the values associated with foreign keys
               -- in the issue table
               -- if you add a field in this section, you will
               -- need to add another field to the GROUP BY clause
               -- You will also need to add each one as a new
               -- dimension below

               -- department_name is used as an example of a custom single
               -- value select field.  Use it as a template for your single
               -- select fields
               ,department.name as department_name

               ,project.name as project_name
               ,resolution.name as resolution_name
               ,severity.name as severity_name
               ,status.name as status_name
               ,issue_type.name as issue_type_name

               -- Include all of the values for multi-value fields associated
               -- with the issue. Each of these fields is stored in its
               -- own separate table
               -- We will use LISTAGG to combine them into a
               -- single field so that we end up with a single record for
               -- each issue
               -- You will also need to add each one as a new
               -- dimension below
               -- Depending on your preferred output style, you may want to
               -- use LISTAGG DISTINCT to eliminate duplicate values

               -- supported_browsers is used as an example of a multi value
               -- select field.  Use it as a template for your multi-value
               -- select fields
               ,LISTAGG(issue_supported_browsers.value, ', ') as browser_list

               ,LISTAGG(component.name, ', ') as component_list
               ,LISTAGG(version.name, ', ') as fix_version_list
               ,LISTAGG(issue_link.related_issue_id, ', ') as related_issues_list

         FROM jira.issue issue
         -- Single value fields.
         -- If the field contains an id, look it up
         -- in the appropriate table.  Many of them will
         -- be in the field_option table.  The
         -- field_option table must have a unique alias
         -- each time it is referenced
         LEFT OUTER JOIN jira.field_option department -- unique alias
            ON issue.department = department.id
         LEFT OUTER JOIN jira.project
            ON issue.project = project.id
         LEFT OUTER JOIN jira.field_option severity -- unique alias
            ON issue.severity = severity.id
         LEFT OUTER JOIN jira.status
            ON issue.status = status.id
         LEFT OUTER JOIN jira.issue_type
            ON issue.issue_type = issue_type.id

         -- Multi-value fields
         LEFT OUTER JOIN jira.issue_supported_browsers
            ON issue.id = issue_supported_browsers.issue_id

         -- Multi vlaue field that stores ids.  In this example
         -- the issue_component table stores component_id's
         -- which are looked up in the component table
         LEFT OUTER JOIN jira.issue_component
            ON issue.id = issue_component.issue_id
         LEFT OUTER JOIN jira.component
            ON issue_component.component_id = component.id

         LEFT OUTER JOIN jira.issue_fix_version
            ON issue.id = issue_fix_version.issue_id
         LEFT OUTER JOIN jira.version
            ON issue_fix_version_s.version_id = version.id

         LEFT OUTER JOIN jira.issue_link
            ON issue.id = issue_link.issue_id

         -- Each non-aggregated field (not included in a LISTAGG) needs to
         -- be included i the GROUP BY clause, so that's every field in the
         -- issue table along with each additional single value field.

         GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
                ,21,22,23,24,25,26,27

        ;;

    indexes: ["id"]
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: _fivetran_synced {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension: external_issue_id {
    type: string
    sql: ${TABLE}.external_issue_id ;;
  }

  dimension: _original_estimate {
    type: number
    sql: ${TABLE}._original_estimate ;;
  }

  dimension: _remaining_estimate {
    type: number
    sql: ${TABLE}._remaining_estimate ;;
  }

  dimension: _time_spent {
    type: number
    sql: ${TABLE}._time_spent ;;
  }

  dimension: assignee {
    type: string
    sql: ${TABLE}.assignee ;;
  }

  dimension_group: created {
    group_label: "Dates"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created ;;
  }

  dimension: department {
    hidden: yes
    type: number
    sql: ${TABLE}.op_department ;;
  }

  # Additional dimension for the denormailzed department_name
  dimension: department_name {
    type: string
    sql: ${TABLE}.op_department_name ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension_group: due {
    group_label: "Dates"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.due_date ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
  }

  dimension: issue_type {
    hidden: yes
    type: number
    sql: ${TABLE}.issue_type ;;
  }

  # Additional dimension for the denormailzed issue_type_name
  dimension: issue_type_name {
    type: string
    sql: ${TABLE}.issue_type_name ;;
  }


  dimension: original_estimate {
    type: number
    sql: ${TABLE}.original_estimate ;;
  }

  dimension: project_id {
    label: "Current Project"
    hidden: yes
    type: number
    sql: ${TABLE}.project ;;
  }

  # Additional dimension for the denormailzed project_name
  dimension: project_name {
    label: "Current Project"
    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension: resolution {
    group_label: "Resolution"
    hidden: yes
    type: number
    sql: ${TABLE}.resolution ;;
  }

  # Additional dimension for the denormailzed resolution_name
  dimension: resolution_name {
    group_label: "Resolution"
    type: string
    sql: ${TABLE}.resolution_name ;;
  }

  dimension_group: resolved {
    group_label: "Resolution"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.resolved ;;
  }

  # Additional field for a simple way to determine
  # if an issue is resolved
  dimension: is_issue_resolved {
    group_label: "Resolution"
    type: yesno
    sql: ${resolved_date} IS NOT NULL ;;
  }

  # Custom dimensions for time to resolve issue
  dimension: hours_to_resolve_issue {
    group_label: "Resolution"
    label: "Time to Resolve (Hours)"
    type: number
    sql: DATEDIFF(h,${created_raw},${resolved_raw}) ;;
    value_format_name: decimal_0
  }

  dimension: minutes_to_resolve_issue {
    group_label: "Resolution"
    label: "Time to Resolve (Minutes)"
    type: number
    sql: DATEDIFF(m,${created_raw},${resolved_raw}) ;;
    value_format_name: decimal_0
  }

  dimension: days_to_resolve_issue {
    group_label: "Resolution"
    label: "Time to Resolve (Days)"
    type: number
    sql: DATEDIFF(d,${created_raw},${resolved_raw}) ;;
    value_format_name: decimal_0
  }

  measure: total_time_to_resolve_issues_hours {
    group_label: "Resolution"
    label: "Total Time to Resolve Issues per Grouping"
    description: "The total hours required to resolve all issues in the chosen dimension grouping"
    type: sum
    sql: ${days_to_resolve_issue} ;;
    value_format_name: decimal_0
  }

  measure: avg_time_to_resolve_issues_hours {
    group_label: "Resolution"
    label: "Avg Time to Resolve Issues per Grouping"
    description: "The average hours required to resolve all issues in the chosen dimension grouping"
    type: average
    sql: ${days_to_resolve_issue} ;;
    value_format_name: decimal_0
  }

  dimension: severity {
    hidden: yes
    type: number
    sql: ${TABLE}.severity ;;
  }

  dimension: severity_name {
    type: string
    sql: ${TABLE}.severity_name ;;
  }

  dimension: status {
    hidden: yes
    type: number
    sql: ${TABLE}.status ;;
  }

  dimension: status_name {
    type: string
    sql: ${TABLE}.status_name ;;
  }

  dimension: story_points {
    type: number
    sql: ${TABLE}.story_points ;;
  }

  measure: total_story_points {
    type: sum
    sql: ${story_points} ;;
  }

# # measure: total_open_story_points {
#    type: sum
#    sql: ${story_points} ;;
##    filters: {
#      field: status.name
#      value:"Open, In Progress, In Development, In QA, In Review"
#    }
#  }

#  measure: total_closed_story_points {
#    type: sum
#    sql: ${story_points} ;;
#    filters: {
#      field: status.name
#      value:"Closed, Done, Ready for Production"
#    }
#  }

  dimension_group: updated {
    group_label: "Dates"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated ;;
  }


  ## Additional dimensions for the LISTAGGS defined
  ## in the query

  dimension: browser_list {
    type: string
    sql: ${TABLE}.browser_list ;;
  }

  dimension: component_list {
    type: string
    sql: ${TABLE}.component_list ;;
  }

  dimension: fix_version_list {
    type: string
    sql: ${TABLE}.fix_version_list ;;
  }

  dimension: related_issues_list {
    type: string
    sql: ${TABLE}.related_issues_list ;;
  }

  measure: count {
    type: count
    drill_fields: [id, days_to_resolve_issue, created_date, severity ]
  }

  # ----- Sets of fields for drilling ------
  #set: detail {
  #  fields: [
  #    external_issue_id,
  #  ]
  #}
}
