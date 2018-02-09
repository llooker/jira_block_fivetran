  view: board {
    sql_table_name: JIRA.BOARD ;;

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.ID ;;
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
      sql: ${TABLE}._FIVETRAN_SYNCED ;;
    }

    dimension: name {
      type: string
      sql: ${TABLE}.NAME ;;
    }

    dimension: type {
      type: string
      sql: ${TABLE}.TYPE ;;
    }

    measure: count {
      type: count
      drill_fields: [id, name, sprint.count]
    }
  }
