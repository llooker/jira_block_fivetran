view: comment {
  sql_table_name: JIRA.COMMENT ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: author_id {
    type: string
    sql: ${TABLE}.AUTHOR_ID ;;
  }

  dimension: body {
    type: string
    sql: ${TABLE}.BODY ;;
  }

  dimension: created {
    type: string
    sql: ${TABLE}.CREATED ;;
  }

  dimension: issue_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.ISSUE_ID ;;
  }

  dimension: update_author_id {
    type: string
    sql: ${TABLE}.UPDATE_AUTHOR_ID ;;
  }

  dimension: updated {
    type: string
    sql: ${TABLE}.UPDATED ;;
  }

  measure: count {
    type: count
    drill_fields: [id, issue.id, issue.epic_name]
  }
}
