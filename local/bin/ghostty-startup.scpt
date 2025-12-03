tell application "Ghostty" to activate
delay 0.5

tell application "System Events"
    tell process "Ghostty"
        -- Tab 1
        set the clipboard to "cd ~/gdrive/notes_personal && tat"
        keystroke "v" using command down
        keystroke return
        
        -- Tab 2
        keystroke "t" using command down
        delay 0.3
        set the clipboard to "cd ~/code/dev-japan-api && tat"
        keystroke "v" using command down
        keystroke return
        
        -- Tab 3
        keystroke "t" using command down
        delay 0.3
        set the clipboard to "cd ~/code/dev-japan-api && tat ai"
        keystroke "v" using command down
        keystroke return
    end tell
end tell
