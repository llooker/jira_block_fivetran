      view: field_option {
        sql_table_name: JIRA.FIELD_OPTION ;;

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

        measure: count {
          type: count
          drill_fields: [detail*]
        }

        # ----- Sets of fields for drilling ------
        set: detail {
          fields: [
            id,
            name,
          ]
        }
      }
