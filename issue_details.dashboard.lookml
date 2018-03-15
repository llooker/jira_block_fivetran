- dashboard: issue_details
  title: Issue Details
  layout: newspaper
  load_configuration: wait
  elements:
  - title: Issue Severity
    name: Issue Severity
    model: jira_block
    explore: issue_extended
    type: single_value
    fields:
    - issue_extended.severity_name
    sorts:
    - issue_extended.severity_name
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Issue ID: issue_extended.id
    row: 0
    col: 7
    width: 8
    height: 2
  - title: Issue Description
    name: Issue Description
    model: jira_block
    explore: issue_extended
    type: looker_single_record
    fields:
    - issue_extended.description
    sorts:
    - issue_extended.description
    limit: 500
    column_limit: 50
    show_view_names: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Issue ID: issue_extended.id
    title_hidden: true
    row: 0
    col: 15
    width: 9
    height: 2
  - title: Issue Status
    name: Issue Status
    model: jira_block
    explore: issue_extended
    type: single_value
    fields:
    - issue_extended.status_name
    sorts:
    - issue_extended.status_name
    limit: 500
    query_timezone: America/New_York
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Issue ID: issue_extended.id
    row: 0
    col: 3
    width: 4
    height: 2
  - title: Issue Sprint History
    name: Issue Sprint History
    model: jira_block
    explore: sprint
    type: table
    fields:
    - issue.id
    - sprint.name
    - sprint.board_id
    - sprint.start_date
    - sprint.complete_date
    - sprint.end_date
    sorts:
    - sprint.start_date
    limit: 500
    query_timezone: America/New_York
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: jira_block/issue_details.dashboard.lookml
        __LINE_NUM: 285
      bold: false
      italic: false
      strikethrough: false
      fields:
      __FILE: jira_block/issue_details.dashboard.lookml
      __LINE_NUM: 280
    listen:
      Issue ID: issue.id
    row: 2
    col: 10
    width: 14
    height: 3
  - title: Issue ID
    name: Issue ID
    model: jira_block
    explore: issue_extended
    type: single_value
    fields:
    - issue_extended.id
    limit: 500
    query_timezone: America/New_York
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Issue ID: issue_extended.id
    row: 2
    col: 0
    width: 3
    height: 2
  - title: issue
    name: issue
    model: jira_block
    explore: issue_history_2
    type: looker_single_record
    fields:
    - issue.id
    - issue.assignee
    - issue.created_date
    - issue.project
    - issue.due_date
    - issue.environment
    - issue.external_issue_id
    - issue._original_estimate
    - issue.original_estimate
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Issue ID: issue.id
    row: 4
    col: 0
    width: 10
    height: 33
  - title: Issue Change History
    name: Issue Change History
    model: jira_block
    explore: issue_history_2
    type: table
    fields:
    - issue_history_all.issue_id
    - issue_history_all.time_date
    - issue_history_all.value
    - issue_history_all.changed
    sorts:
    - issue_history_all.time_date desc
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Issue ID: issue.id
    row: 8
    col: 10
    width: 14
    height: 9
  - title: Issue Version History
    name: Issue Version History
    model: jira_block
    explore: version
    type: table
    fields:
    - version.name
    - version.start_date
    - version.release_date
    - issue_extended.id
    sorts:
    - version.start_date desc
    limit: 500
    query_timezone: America/New_York
    hidden_fields:
    - issue.id
    listen:
      Issue ID: issue_extended.id
    row: 5
    col: 10
    width: 14
    height: 3
  filters:
  - name: Issue ID
    title: Issue ID
    type: field_filter
    default_value: ''
    model: jira_block
    explore: issue_history_2
    field: issue.id
    listens_to_filters: []
    allow_multiple_values: true
    required: false
