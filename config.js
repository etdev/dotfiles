module.exports = {
  brew1: [
    // http://conqueringthecommandline.com/book/ack_ag
    'ack',
    'ag',
    'vim --with-override-system-vi',
    // Install GNU core utilities (those that come with macOS are outdated)
    // Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
    'coreutils',
    'dos2unix',
    // Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
    'findutils',
    'fortune',
    'readline', // ensure gawk gets good readline
    'gawk',
    'gnupg',
    // Install GNU `sed`, overwriting the built-in `sed`
    // so we can do "sed -i 's/foo/bar/' file" instead of "sed -i '' 's/foo/bar/' file"
    'gnu-sed --with-default-names',
    // better, more recent grep
    'homebrew/dupes/grep',
    // https://github.com/jkbrzt/httpie
    'httpie',
    // jq is a sort of JSON grep
    'jq',
    // Mac App Store CLI: https://github.com/mas-cli/mas
    'mas',
    // Install some other useful utilities like `sponge`
    'moreutils',
    'nmap',
    'openconnect',
    'reattach-to-user-namespace',
    'homebrew/dupes/screen',
    'tmux',
    'tree',
    'ttyrec',
    'watch',
    'atk',
    'augeas',
    'autoconf',
    'automake',
    'awscli',
    'binutils',
    'cairo',
    'certbot',
    'chromedriver',
    'cmake',
    'colordiff',
    'composer',
    'ctags',
    'dialog',
    'diffutils',
    'dtrx',
    'eb',
    'ed',
    'emacs-mac',
    'envchain',
    'exercism',
    'ffmpeg',
    'freetype',
    'fribidi',
    'fzf',
    'gcc',
    'gd',
    'gdbm',
    'gdk-pixbuf',
    'geoip',
    'gettext',
    'giflossy',
    'glib',
    'gmp',
    'gnu-indent',
    'gnu-tar',
    'gnu-which',
    'gnutls',
    'go',
    'gobject-introspection',
    'graphicsmagick',
    'graphite2',
    'graphviz',
    'gtk+',
    'gzip',
    'harfbuzz',
    'heroku',
    'heroku-node',
    'hicolor-icon-theme',
    'icu4c',
    'iftop',
    'imagemagick',
    'isl',
    'jemalloc',
    'jpeg',
    'lame',
    'leptonica',
    'libass',
    'libevent',
    'libffi',
    'libgcrypt',
    'libgpg-error',
    'libmaa',
    'libmpc',
    'libpng',
    'libsodium',
    'libssh',
    'libtasn1',
    'libtermkey',
    'libtiff',
    'libtool',
    'libunistring',
    'libuv',
    'libvterm',
    'libxml2',
    'libxmlsec1',
    'libxslt',
    'libyaml',
  ],
  brew2: [
    'libzip',
    'links',
    'llvm',
    'luajit',
    'lzip',
    'mcrypt',
    'memcached',
    'mercurial',
    'mhash',
    'mitmproxy',
    'mongodb@3.2',
    'mpfr',
    'msgpack',
    'mysql',
    'n',
    'nasm',
    'neovim',
    'nettle',
    'nginx',
    'node',
    'oniguruma',
    'openssl',
    'openssl@1.1',
    'p11-kit',
    'p7zip',
    'pango',
    'pcre',
    'perl',
    'php',
    'php70',
    'php70-mcrypt',
    'php72',
    'pixman',
    'pkg-config',
    'plantuml',
    'pngcrush',
    'postgresql',
    'postgresql@9.6',
    'protobuf',
    'pyenv',
    'pyenv-virtualenv',
    'python',
    'python3',
    'qt',
    'qt@5.5',
    'r',
    'rbenv',
    'rcm',
    'redis',
    'rename',
    'ripgrep',
    'rtags',
    'ruby',
    'ruby-build',
    'sdl2',
    'selenium-server-standalone',
    'speedtest-cli',
    'sqlite',
    'tesseract',
  ],
  brew3: [
    'texi2html',
    'texinfo',
    'the_silver_searcher',
    'tidy-html5',
    'tldr',
    'tmate',
    'unibilium',
    'unixodbc',
    'unrar',
    'vimpager',
    'watch',
    'wdiff',
    'webp',
    'wget --enable-iri',
    'x264',
    'xvid',
    'xz',
    'yarn',
    'yasm'
  ],
  cask1: [
    //'box-sync',
    //'adium',
    //'amazon-cloud-drive',
    //'comicbooklover',
    //'diffmerge',
    //'evernote',
    //'ireadfast',
    //'macvim',
    //'sketchup',
    //'torbrowser',
    'alfred2',
    'anki',
    'atom',
    'bettertouchtool',
    'caffeine',
    'calibre',
    'charles',
    'dash2',
    'dbschema',
    'docker',
    'dropbox',
    'ebmac',
    'emacs',
    'firefox',
    'google-backup-and-sync',
    'google-chrome',
    'google-japanese-ime',
    'gpgtools',
    'iterm2',
    'karabiner-elements',
    'keycastr',
  ],
  cask2: [
    'licecap',
    'little-snitch',
    'micro-snitch',
    'ngrok',
    'private-internet-access',
    'racket',
    'scroll-reverser',
    'sequel-pro',
    'sip',
    'sizeup',
    'skitch',
    'skype',
    'slack',
    'spotify',
    'sublime-text',
    'telegram',
    'the-unarchiver',
    'transmission',
    'vagrant',
    'virtualbox',
    'visual-studio-code',
    'vlc',
    'xquartz',
  ],
  npm: [
    'antic',
    'buzzphrase',
    'csv2md',
    'eslint',
    'gulp',
    'instant-markdown-d',
    'npm-check',
    'prettyjson',
    'trash',
    'vtop',
    // 'generator-dockerize',
    // ,'yo'
  ]
};