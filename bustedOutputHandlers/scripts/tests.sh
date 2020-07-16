#!/bin/bash

cur_dir="$(pwd)"
cur_date="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
report_folder="${cur_dir}/bustedOutputHandlers/reports/output_${cur_date}"
mkdir -p "${report_folder}"

run_busted() {
  filename=$1
  filename_no_extension="${filename/.lua/}"

  busted -v --output="${cur_dir}/bustedOutputHandlers/junitPrint.lua" \
    -Xoutput "${report_folder}/${filename_no_extension}.xml" -- "${filename}"
}

exit_status=0

cd "list"
tests_arr=("List_spec.lua" "Extra_spec.lua")

for test_file in ${tests_arr[*]}; do
  pwd
  run_busted "${test_file}" 
  exit_status=$(($exit_status || $?))
done

# Clean up!
cd "${cur_dir}"

exit $exit_status

