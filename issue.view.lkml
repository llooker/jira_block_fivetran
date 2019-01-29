view: issue {
  sql_table_name: jira.issue ;;

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

  dimension: JK_key {
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: JK_epic_name {
    type: string
    sql: ${TABLE}.epic_name ;;
  }

  dimension: JK_IssueSummary {
    type: string
    sql: ${TABLE}.summary ;;
  }
  dimension: JK_IssueType {
    type: string
    sql: ${TABLE}.issue_type ;;
  }

  dimension: JK_EpicLink {
    type: string
    sql: ${TABLE}.epic_link ;;
  }
  dimension:  JK_Resolution {
    type: string
    sql:  ${TABLE}.resolution ;;
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

  dimension: original_estimate {
    type: number
    sql: ${TABLE}.original_estimate ;;
  }

  dimension: priority {
    type: number
    hidden: yes
    sql: ${TABLE}.priority ;;
  }

  dimension: project {
    label: "Current Project"
    hidden: yes
    type: number
    sql: ${TABLE}.project ;;
  }

  dimension: resolution {
    group_label: "Resolution"
    hidden: yes
    type: number
    sql: ${TABLE}.resolution ;;
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

  dimension: status {
    hidden: yes
    type: number
    sql: ${TABLE}.status ;;
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
