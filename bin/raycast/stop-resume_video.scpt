#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title stop-resume_video
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author sN1212
# @raycast.authorURL https://raycast.com/sN1212

tell application "Google Chrome"
	activate window 1.38331591E+9
    delay 0.2
    tell application "System Events"
		key code 49
	end tell
end tell

delay 0.2

tell application "Notion"
	activate
end tell
