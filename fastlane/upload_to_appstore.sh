#!/bin/bash

if [ ! -f "${IPA_OUTPUT_FILE}" ] || [ ! -d "${XCARCHIVE_OUTPUT}" ]; then
 echo IPA_OUTPUT_FILE=${IPA_OUTPUT_FILE} and XCARCHIVE_OUTPUT=${XCARCHIVE_OUTPUT} abort
 exit 1
fi

if [[ ! -f ~/.appstore/token ]]; then
  echo there are no token file
  exit 1
fi

if [[ ! -f ~/.appstore/tags ]]; then
  echo there are no tags file
  exit 1
fi

export BCN_TOKEN=$(<~/.appstore/token)
export BCN_TAGS=$(<~/.appstore/tags)

if [[ -z $BCN_TOKEN ]] || [[ -z $BCN_TAGS ]]; then
  echo token=$BCN_TOKEN and tags=$BCN_TAGS abort
  exit 1
fi

STATUSCODE=$(curl --fail -X POST -H 'Cache-Control: no-cache' -H 'Content-Type: multipart/form-data' -F App=@"${IPA_OUTPUT_FILE}" \
"https://appstore.epam.com/api/package?token=${BCN_TOKEN}&name=BCN-LSTR%${BCN_BUILD_NUMBER}&tags=${BCN_TAGS}&platform=ios&isvisible=true&IsRemovable=true")

echo $STATUSCODE

exit 0
