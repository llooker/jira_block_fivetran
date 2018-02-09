  view: issue_sprint_history {
    sql_table_name: JIRA.ISSUE_SPRINT_HISTORY ;;

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

    dimension_group: time {
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
      sql: ${TABLE}.TIME ;;
    }

    measure: count {
      type: count
      drill_fields: [issue.id, issue.epic_name, sprint.id, sprint.name]
    }
  }
