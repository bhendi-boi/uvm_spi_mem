load -run test_error
report_metrics -detail -out coverage_error.rpt -metrics all -source on
merge  test_error -out merged_data -initial_model test_directed
load -run merged_data
report_metrics -detail -out merged.rpt -metrics all   -source on
# quit
