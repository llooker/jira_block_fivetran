view: sprint_by_date {
  derived_table: {
    persist_for: "12 hours"
    # For Redshift only
    #sortkeys: ["sprint_id","issue_id"]
    #distribution_style: all
    sql: SELECT "issue_id",
       "time" as start_time,
       (select NVL(min(time), '9999-01-01') as end_time from jira.issue_sprint_history ish2
          where ish2.issue_id = ish.issue_id and ish2.time > ish.time) as end_time,
       "value",
       "sprint_id"
FROM jira.issue_sprint_history ish
UNION
SELECT ist.issue_id as issue_id,
      i.created as start_time,
      '9999-01-01' as end_time,
      NULL as value,
      ist.sprint_id as sprint_id
FROM jira.issue_sprint ist
   LEFT OUTER JOIN jira.issue i on ist.issue_id = i.id
WHERE 1 = 1
AND  NOT EXISTS (select issue_id from jira.issue_sprint_history where issue_id = ist.issue_id)
 ;;

    indexes: ["sprint_id", "issue_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: issue_id {
    type: number
    sql: ${TABLE}.issue_id ;;
  }

  dimension_group: start_time {
    type: time
    sql: ${TABLE}.start_time ;;
  }

  dimension_group: end_time {
    type: time
    sql: ${TABLE}.end_time ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }

  dimension: sprint_id {
    type: number
    sql: ${TABLE}.sprint_id ;;
  }

  set: detail {
    fields: [issue_id, start_time_time, end_time_time, value, sprint_id]
  }
}
