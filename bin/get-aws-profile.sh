#!/bin/bash
# set -x
#
# Fetch the AWS access key and/or secret for an AWS profile
# stored in the ~/.aws/credentials file ini format
#
# Aaron Roydhouse <aaron@roydhouse.com>, 2017
# https://github.com/whereisaaron/get-aws-profile-bash/
#

#
# cfg_parser - Parse and ini files into variables
# By Andres J. Diaz
# http://theoldschooldevops.com/2008/02/09/bash-ini-parser/
# Use pastebin link only and WordPress corrupts it
# http://pastebin.com/f61ef4979 (original)
# http://pastebin.com/m4fe6bdaf (supports spaces in values)
#

cfg_parser ()
{
  ini="$(<$1)"                # read the file
  ini="${ini//[/\[}"          # escape [
  ini="${ini//]/\]}"          # escape ]
  IFS=$'\n' && ini=( ${ini} ) # convert to line-array
  ini=( ${ini[*]//;*/} )      # remove comments with ;
  ini=( ${ini[*]/\    =/=} )  # remove tabs before =
  ini=( ${ini[*]/=\   /=} )   # remove tabs be =
  ini=( ${ini[*]/\ =\ /=} )   # remove anything with a space around =
  ini=( ${ini[*]/#\\[/\}$'\n'cfg.section.} ) # set section prefix
  ini=( ${ini[*]/%\\]/ \(} )    # convert text2function (1)
  ini=( ${ini[*]/=/=\( } )    # convert item to array
  ini=( ${ini[*]/%/ \)} )     # close array parenthesis
  ini=( ${ini[*]/%\\ \)/ \\} ) # the multiline trick
  ini=( ${ini[*]/%\( \)/\(\) \{} ) # convert text2function (2)
  ini=( ${ini[*]/%\} \)/\}} ) # remove extra parenthesis
  ini[0]="" # remove first element
  ini[${#ini[*]} + 1]='}'    # add the last brace
  eval "$(echo "${ini[*]}")" # eval the result
}

#
# Parse options
#

display_usage ()
{
  echo "Usage: $0 [--credentials=<path>] [--profile=<name>] [--key|--secret|--session-token]"
  echo "  Default --credentials is '~/.aws/credentials'"
  echo "  Default --profile is 'default'"
  echo "  By default environment variables are generate, e.g."
  echo "    source \$($0 --profile=myprofile)"
  echo "  You can specify one of --key, --secret, -or --session-token to get just that value, with no line break,"
  echo "    FOO_KEY=\$($0 --profile=myprofile --key)"
  echo "    FOO_SECRET=\$($0 --profile=myprofile --secret)"
  echo "    FOO_SESSION_TOKEN=\$($0 --profile=myprofile --session-token)"
}

for i in "$@"
do
case $i in
    --credentials=*)
    CREDENTIALS="${i#*=}"
    shift # past argument=value
    ;;
    --profile=*)
    PROFILE="${i#*=}"
    shift # past argument=value
    ;;
    --key)
    SHOW_KEY=true
    shift # past argument with no value
    ;;
    --secret)
    SHOW_SECRET=true
    shift # past argument with no value
    ;;
    --session-token)
    SHOW_SESSION_TOKEN=true
    shift # past argument with no value
    ;;
    --help)
    display_usage
    exit 0
    ;;
    *)
    # unknown option
    echo "Unknown option $1"
    display_usage
    exit 1
    ;;
esac
done

#
# Check options
#

CREDENTIALS=${CREDENTIALS:-~/.aws/credentials}
PROFILE=${PROFILE:-default}
SHOW_KEY=${SHOW_KEY:-false}
SHOW_SECRET=${SHOW_SECRET:-false}
SHOW_SESSION_TOKEN=${SHOW_SESSION_TOKEN:-false}

if [[ "${SHOW_KEY}" = true && "${SHOW_SECRET}" = true ]]; then
  echo "Can only specify one of --key or --secret"
  display_usage
  exit 2
fi

#
# Parse and display
#

if [[ ! -r "${CREDENTIALS}" ]]; then
  echo "File not found: '${CREDENTIALS}'"
  exit 3
fi

cfg_parser "${CREDENTIALS}"
if [[ $? -ne 0 ]]; then
  echo "Parsing credentials file '${CREDENTIALS}' failed"
  exit 4
fi

cfg.section.${PROFILE}
if [[ $? -ne 0 ]]; then
  echo "Profile '${PROFILE}' not found"
  exit 5
fi

if [[ "${SHOW_KEY}" = false && "${SHOW_SECRET}" = false && "${SHOW_SESSION_TOKEN}" = false ]]; then
  echo "export AWS_ACCESS_KEY_ID=${aws_access_key_id}"
  echo "export AWS_SECRET_ACCESS_KEY=${aws_secret_access_key}"
  echo "export AWS_SESSION_TOKEN=${aws_session_token}"
elif [[ "${SHOW_KEY}" = true ]]; then
  echo -n "${aws_access_key_id}"
elif [[ "${SHOW_SECRET}" = true ]]; then
  echo -n "${aws_secret_access_key}"
elif [[ "${SHOW_SESSION_TOKEN}" = true ]]; then
  echo -n "${aws_session_token}"
else
  echo "Unknown error"
  exit 9
fi

exit 0
