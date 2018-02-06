view: sprint {
  sql_table_name: JIRA.SPRINT ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: board_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.BOARD_ID ;;
  }

  dimension: complete_date {
    type: string
    sql: ${TABLE}.COMPLETE_DATE ;;
  }

  dimension: end_date {
    type: string
    sql: ${TABLE}.END_DATE ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: start_date {
    type: string
    sql: ${TABLE}.START_DATE ;;
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
      board.id,
      board.name,
      issue_sprint.count,
      issue_sprint_history.count
    ]
  }
}
