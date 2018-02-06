view: issue_sprint {
  sql_table_name: JIRA.ISSUE_SPRINT ;;

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: issue_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.ISSUE_ID ;;
  }

  dimension: sprint_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.SPRINT_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [issue.id, issue.epic_name, sprint.id, sprint.name]
  }
}
