- dashboard: cumulative_flow
  title: Cumulative Flow
  layout: newspaper
  elements:
  - title: Cumulative Flow Diagram
    name: Cumulative Flow Diagram
    model: jira_block
    explore: sprint_by_date
    type: looker_area
    fields:
    - issue.count
    - issue.created_date
    - status_category.name
    pivots:
    - status_category.name
    fill_fields:
    - issue.created_date
    sorts:
    - issue.created_date
    - status_category.name
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: cumulative_issues
      label: Cumulative Issues
      expression: running_total(${issue.count})
      value_format:
      value_format_name:
      _kind_hint: measure
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields:
    - issue.count
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    hidden_series: []
    listen:
      Issue Created Month: issue.created_month
    row: 0
    col: 0
    width: 23
    height: 12
  filters:
  - name: Issue Created Month
    title: Issue Created Month
    type: field_filter
    default_value: 3 months
    model: jira_block
    explore: issue_extended
    field: issue_extended.created_month
    listens_to_filters: []
    allow_multiple_values: true
    required: false
