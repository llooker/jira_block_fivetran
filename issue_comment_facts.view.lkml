view: issue_comment_facts {
  derived_table: {
    sql: SELECT issue_id,
      count(distinct author_id) as number_of_issue_commenters,
      count(*) as number_of_issue_comments
      FROM jira.comment
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: issue_id {
    type: number
    sql: ${TABLE}.issue_id ;;
  }

  dimension: number_of_issue_commenters {
    type: number
    hidden: yes
    sql: ${TABLE}.number_of_issue_commenters ;;
  }

  dimension: number_of_issue_comments {
    type: number
    hidden: yes
    sql: ${TABLE}.number_of_issue_comments ;;
  }

  measure: total_number_issue_commenters {
    type: sum
    sql: ${number_of_issue_commenters} ;;
  }

  measure: total_number_issue_comments {
    type: sum
    sql: ${number_of_issue_commenters} ;;
  }

  set: detail {
    fields: [issue_id, number_of_issue_commenters, number_of_issue_comments]
  }
}
