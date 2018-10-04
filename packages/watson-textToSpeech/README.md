<!--
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
-->

# Using the Watson Text to Speech package

The `/whisk.system/watson-textToSpeech` package offers a convenient way to call Watson APIs to convert the text into speech.

The package includes the following actions.

| Entity | Type | Parameters | Description |
| --- | --- | --- | --- |
| `/whisk.system/watson-textToSpeech` | package | username, password | Package to convert text into speech |
| `/whisk.system/watson-textToSpeech/textToSpeech` | action | payload, voice, accept, encoding, username, password | Convert text into audio |

**Note**: The package `/whisk.system/watson` is deprecated including the action `/whisk.system/watson/textToSpeech`.

## Setting up the Watson Text to Speech package in Bluemix

If you're using OpenWhisk from Bluemix, OpenWhisk automatically creates package bindings for your Bluemix Watson service instances.

1. Create a Watson Text to Speech service instance in your Bluemix [dashboard](http://console.ng.Bluemix.net).

  Be sure to remember the name of the service instance and the Bluemix organization and space you're in.

2. Refresh the packages in your namespace. The refresh automatically creates a package binding for the Watson service instance that you created.

  ```
  wsk package refresh
  ```
  ```
  created bindings:
  Bluemix_Watson_TextToSpeech_Credentials-1
  ```
  ```
  wsk package list
  ```
  ```
  packages
  /myBluemixOrg_myBluemixSpace/Bluemix_Watson_TextToSpeec_Credentials-1 private
  ```


## Setting up a Watson Text to Speech package outside Bluemix

If you're not using OpenWhisk in Bluemix or if you want to set up your Watson Text to Speech outside of Bluemix, you must manually create a package binding for your Watson Text to Speech service. You need the Watson Text to Speech service user name, and password.

- Create a package binding that is configured for your Watson Speech to Text service.

  ```
  wsk package bind /whisk.system/watson-textToSpeech myWatsonTextToSpeech -p username MYUSERNAME -p password MYPASSWORD
  ```


## Converting some text to speech

The `/whisk.system/watson-textToSpeech/textToSpeech` action converts some text into an audio speech. The parameters are as follows:

- `username`: The Watson API user name.
- `password`: The Watson API password.
- `payload`: The text to convert into speech.
- `voice`: The voice of the speaker.
- `accept`: The format of the speech file.
- `encoding`: The encoding of the speech binary data.


- Invoke the `textToSpeech` action in your package binding to convert the text.

  ```
  wsk action invoke myWatsonTextToSpeech/textToSpeech --blocking --result --param payload 'Hey.' --param voice 'en-US_MichaelVoice' --param accept 'audio/wav' --param encoding 'base64'
  ```
  ```json
  {
    "payload": "<base64 encoding of a .wav file>"
  }
  ```
