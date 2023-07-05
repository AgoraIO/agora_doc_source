#!/bin/sh
# cd this file path
cd $(dirname $0)

platform=$1
language=$2

lowerlanguage=$(echo ${language} | tr '[:upper:]' '[:lower:]')
lowerPlatform=$(echo ${platform} | tr '[:upper:]' '[:lower:]')

prefix_path="../../en-US/dita/"
node_hide_attributes=("hide" 
                      "cn")

if [[ "$lowerlanguage" == "cn" ]]; then
    prefix_path="../../dita"
    node_hide_attributes=("hide")
fi

api_ditamap_file_path="../../dita/RTC-NG/RTC_NG_API_${platform}.ditamap"
keys_ditamap_file_path="${prefix_path}/RTC-NG/config/keys-rtc-ng-api-${lowerPlatform}.ditamap"
api_dita_folder_path="${prefix_path}/RTC-NG/API"
output_json_file_path="../Output/RTC_NG_API_${platform}.json"

python3 ../Implementation/Pipeline.py ${api_ditamap_file_path} ${keys_ditamap_file_path} ${api_dita_folder_path} ${lowerPlatform} ${output_json_file_path} ${node_hide_attributes[@]}
