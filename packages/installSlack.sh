#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# use the command line interface to install Slack package.
#
: ${WHISK_SYSTEM_AUTH:?"WHISK_SYSTEM_AUTH must be set and non-empty"}
AUTH_KEY=$WHISK_SYSTEM_AUTH

SCRIPTDIR="$(cd $(dirname "$0")/ && pwd)"
PACKAGE_HOME=$SCRIPTDIR
source "$PACKAGE_HOME/util.sh"

echo Installing Slack package.

createPackage slack \
    -a description "This package interacts with the Slack messaging service" \
    -a parameters '[ {"name":"username", "required":true, "bindTime":true, "description": "Your Slack username"}, {"name":"url", "required":true, "bindTime":true, "description": "Your webhook URL", "doclink": "https://api.slack.com/incoming-webhooks"},{"name":"channel", "required":true, "bindTime":true, "description": "The name of a Slack channel"}, {"name": "token", "description": "Your Slack oauth token", "doclink": "https://api.slack.com/docs/oauth"} ]'

waitForAll

install "$PACKAGE_HOME/slack/post.js" \
    slack/post \
    -a description 'Post a message to Slack' \
    -a parameters '[ {"name":"text", "required":true, "description": "The message you wish to post"} ]' \
    -a sampleInput '{"username":"openwhisk", "text":"Hello OpenWhisk!", "channel":"myChannel", "url": "https://hooks.slack.com/services/XYZ/ABCDEFG/12345678"}'

waitForAll

echo Slack package ERRORS = $ERRORS
exit $ERRORS
