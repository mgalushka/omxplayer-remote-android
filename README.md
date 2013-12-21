omxplayer-remote-android
========================

Remote control for Raspberry PI omxplayer written for Android phones.

PHP service which is controlling omxplayer is implemented as separated project here:
https://github.com/mgalushka/omxplayer-web-controls-php

TODO
- Implement history and current playing remembering. 
- Implement mute functions screen (not clear how to support with current omxplayer).
- Resume playing after long break/switch off raspberry device.

Version 2.0
- Implemented browsing filesystem - through apache/php HTTP API.
- Implemented choose file/directory and play function.
- Implemented pause function screen.
- Implemented sound controls
- Resume controls after restart of android application.
- Search forward/backward controls.

Version 1.0
- Draft for GUI screens

![Plan](https://github.com/mgalushka/omxplayer-remote-android/raw/master/doc/plan.png)
