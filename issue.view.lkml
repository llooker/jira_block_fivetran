view: issue {
<<<<<<< HEAD
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

  dimension: project_id {
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
=======
  sql_table_name: JIRA.ISSUE ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: _original_estimate {
    type: number
    sql: ${TABLE}._ORIGINAL_ESTIMATE ;;
  }

  dimension: _remaining_estimate {
    type: number
    sql: ${TABLE}._REMAINING_ESTIMATE ;;
  }

  dimension: _time_spent {
    type: number
    sql: ${TABLE}._TIME_SPENT ;;
  }

  dimension: assignee {
    type: string
    sql: ${TABLE}.ASSIGNEE ;;
  }

  dimension: capture_for_jira_browser {
    type: string
    sql: ${TABLE}.CAPTURE_FOR_JIRA_BROWSER ;;
  }

  dimension: capture_for_jira_document_mode {
    type: string
    sql: ${TABLE}.CAPTURE_FOR_JIRA_DOCUMENT_MODE ;;
  }

  dimension: capture_for_jira_j_query_version {
    type: string
    sql: ${TABLE}.CAPTURE_FOR_JIRA_J_QUERY_VERSION ;;
  }

  dimension: capture_for_jira_operating_system {
    type: string
    sql: ${TABLE}.CAPTURE_FOR_JIRA_OPERATING_SYSTEM ;;
  }

  dimension: capture_for_jira_screen_resolution {
    type: string
    sql: ${TABLE}.CAPTURE_FOR_JIRA_SCREEN_RESOLUTION ;;
  }

  dimension: capture_for_jira_url {
    type: string
    sql: ${TABLE}.CAPTURE_FOR_JIRA_URL ;;
  }

  dimension: capture_for_jira_user_agent {
    type: string
    sql: ${TABLE}.CAPTURE_FOR_JIRA_USER_AGENT ;;
  }

  dimension: created {
    type: string
    sql: ${TABLE}.CREATED ;;
  }

  dimension: creator {
    type: string
    sql: ${TABLE}.CREATOR ;;
  }

  dimension: custom_cascade {
    type: number
    sql: ${TABLE}.CUSTOM_CASCADE ;;
  }

  dimension: custom_checkbox {
    type: number
    sql: ${TABLE}.CUSTOM_CHECKBOX ;;
  }

  dimension_group: custom {
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
    datatype: date
    sql: ${TABLE}.CUSTOM_DATE ;;
  }

  dimension: custom_date_time {
    type: string
    sql: ${TABLE}.CUSTOM_DATE_TIME ;;
  }

  dimension: custom_label {
    type: string
    sql: ${TABLE}.CUSTOM_LABEL ;;
  }

  dimension: custom_multi_user {
    type: string
    sql: ${TABLE}.CUSTOM_MULTI_USER ;;
  }

  dimension: custom_parent {
    type: number
    sql: ${TABLE}.CUSTOM_PARENT ;;
  }

  dimension: custom_project {
    type: number
    sql: ${TABLE}.CUSTOM_PROJECT ;;
  }

  dimension: custom_select {
    type: number
    sql: ${TABLE}.CUSTOM_SELECT ;;
  }

  dimension: custom_single_user {
    type: string
    sql: ${TABLE}.CUSTOM_SINGLE_USER ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension_group: due {
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
    datatype: date
    sql: ${TABLE}.DUE_DATE ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}.ENVIRONMENT ;;
  }

  dimension: epic_color {
    type: string
    sql: ${TABLE}.EPIC_COLOR ;;
  }

  dimension: epic_link {
    type: number
    sql: ${TABLE}.EPIC_LINK ;;
  }

  dimension: epic_name {
    type: string
    sql: ${TABLE}.EPIC_NAME ;;
  }

  dimension: epic_status {
    type: number
    sql: ${TABLE}.EPIC_STATUS ;;
  }

  dimension: issue_type {
    type: number
    sql: ${TABLE}.ISSUE_TYPE ;;
  }

  dimension: key {
    type: string
    sql: ${TABLE}.KEY ;;
  }

  dimension: last_viewed {
    type: string
    sql: ${TABLE}.LAST_VIEWED ;;
  }

  dimension: multi_select_list {
    type: number
    sql: ${TABLE}.MULTI_SELECT_LIST ;;
  }

  dimension: original_estimate {
    type: number
    sql: ${TABLE}.ORIGINAL_ESTIMATE ;;
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}.PARENT_ID ;;
  }

  dimension: parent_link {
    type: number
    sql: ${TABLE}.PARENT_LINK ;;
  }

  dimension: priority {
    type: number
    sql: ${TABLE}.PRIORITY ;;
  }

  dimension: project {
    type: number
    sql: ${TABLE}.PROJECT ;;
  }

  dimension: raised_during {
    type: string
    sql: ${TABLE}.RAISED_DURING ;;
  }

  dimension: remaining_estimate {
    type: number
    sql: ${TABLE}.REMAINING_ESTIMATE ;;
  }

  dimension: reporter {
    type: string
    sql: ${TABLE}.REPORTER ;;
  }

  dimension: resolution {
    type: number
    sql: ${TABLE}.RESOLUTION ;;
  }

  dimension: resolved {
    type: string
    sql: ${TABLE}.RESOLVED ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}.STATUS ;;
  }

  dimension: story_points {
    type: number
    sql: ${TABLE}.STORY_POINTS ;;
  }

  dimension: summary {
    type: string
    sql: ${TABLE}.SUMMARY ;;
  }

  dimension: test_sessions {
    type: string
    sql: ${TABLE}.TEST_SESSIONS ;;
  }

  dimension: testing_status {
    type: string
    sql: ${TABLE}.TESTING_STATUS ;;
  }

  dimension: time_spent {
    type: number
    sql: ${TABLE}.TIME_SPENT ;;
  }

  dimension: updated {
    type: string
    sql: ${TABLE}.UPDATED ;;
  }

  dimension: work_ratio {
    type: number
    sql: ${TABLE}.WORK_RATIO ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      epic_name,
      comment.count,
      issue_assignee_history.count,
      issue_custom_checkbox.count,
      issue_custom_checkbox_history.count,
      issue_custom_date_history.count,
      issue_custom_date_time_history.count,
      issue_custom_label.count,
      issue_custom_multi_user.count,
      issue_custom_multi_user_history.count,
      issue_custom_select_history.count,
      issue_custom_single_user_history.count,
      issue_epic_link_history.count,
      issue_fix_version_history.count,
      issue_fix_version_s.count,
      issue_labels.count,
      issue_link.count,
      issue_multi_select_list.count,
      issue_multi_select_list_history.count,
      issue_priority_history.count,
      issue_project_history.count,
      issue_reporter_history.count,
      issue_resolution_history.count,
      issue_sprint.count,
      issue_sprint_history.count,
      issue_status_history.count,
      issue_sub_tasks.count
    ]
  }
>>>>>>> branch 'master' of git@github.com:llooker/jira_block_fivetran.git
}
