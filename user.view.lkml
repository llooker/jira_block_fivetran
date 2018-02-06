view: user {
  sql_table_name: JIRA."USER" ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.EMAIL ;;
  }

  dimension: locale {
    type: string
    sql: ${TABLE}.LOCALE ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: time_zone {
    type: string
    sql: ${TABLE}.TIME_ZONE ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      issue_assignee_history.count,
      issue_custom_multi_user.count,
      issue_custom_multi_user_history.count,
      issue_custom_single_user_history.count,
      issue_reporter_history.count,
      user_group.count
    ]
  }
}
