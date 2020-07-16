#!/bin/bash

cur_dir="$(pwd)"
cur_date="$(date +"%Y-%m-%dT%H:%M:%S")"
# report_folder="${cur_dir}/bustedOutputHandlers/reports/output_${cur_date}"
# Don't need current date for now
report_folder="${cur_dir}/bustedOutputHandlers/reports/"

# Important! Remove the rm line if you don't want to have an empty report folder for each run
rm -rf "${report_folder}"
mkdir -p "${report_folder}"

run_busted() {
  filename=$1
  if [ ! -f "${filename}" ]; then
    printf "File '%s' does not exist!\n" "${filename}"
    return 1
  fi

  filename_no_extension="${filename/.lua/}"

  busted -v --output="${cur_dir}/bustedOutputHandlers/junitPrint.lua" \
    -Xoutput "${report_folder}/${filename_no_extension}.xml" -- "${filename}"
}

exit_status=0

cd "list"
tests_arr=("List_spec.lua" "Extra_spec.lua")

for test_file in ${tests_arr[*]}; do
  run_busted "${test_file}" 
  exit_status=$(($exit_status || $?))
done

# Clean up!
cd "${cur_dir}"

exit $exit_status

