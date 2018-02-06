view: fivetran_audit {
  sql_table_name: JIRA.FIVETRAN_AUDIT ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: done {
    type: string
    sql: ${TABLE}.DONE ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.MESSAGE ;;
  }

  dimension: progress {
    type: string
    sql: ${TABLE}.PROGRESS ;;
  }

  dimension: rows_updated_or_inserted {
    type: number
    sql: ${TABLE}.ROWS_UPDATED_OR_INSERTED ;;
  }

  dimension: schema {
    type: string
    sql: ${TABLE}.SCHEMA ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.START ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.STATUS ;;
  }

  dimension: table {
    type: string
    sql: ${TABLE}."TABLE" ;;
  }

  dimension: update_id {
    type: string
    sql: ${TABLE}.UPDATE_ID ;;
  }

  dimension: update_started {
    type: string
    sql: ${TABLE}.UPDATE_STARTED ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
