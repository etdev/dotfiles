# Post-Install
### Install
BetterSnapTool
```
mas install 417375580
```

Coin Tick
```
mas install 1141688067
```

LINE
```
mas install 539883307
```

### Set various configurations

* Set BetterSnapTool config
```
mkdir -p $HOME/Library/Preferences/
cp $HOME/dotfiles/plists/com.hegenberg.BetterSnapTool.plist $HOME/Library/Preferences/
cp $HOME/dotfiles/plists/com.hegenberg.BetterSnapTool.plist $HOME/Library/Preferences/
```

* Generate [new Github ssh key](https://help.github.com/articles/connecting-to-github-with-ssh/)
* Set to dark theme
* Replace icons
* Import Alfred license
* Import Alfred settings (dropbox)
* Import Sip license
* Import BetterSnapTool and BetterTouchTool licenses
* Set computer name to `mbp`
* PIA
* Set display resolution
```
sudo scutil --set ComputerName mbp
dscacheutil -flushcache
<restart>
```
* Enable chrome dark devtools theme
* Fix right-click behavior in *Right Click Opens Link in New Tab* chrome extension (like [this](http://i.imgur.com/uP959Mx.png))
