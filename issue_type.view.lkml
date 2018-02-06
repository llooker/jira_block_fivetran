view: issue_type {
  sql_table_name: JIRA.ISSUE_TYPE ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: subtask {
    type: yesno
    sql: ${TABLE}.SUBTASK ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
