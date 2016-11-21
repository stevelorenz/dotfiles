## My Neovim Configuration

This is my relative effective configuration of Neovim, which is mainly for python development.

### Dependencies

 - [curl](https://curl.haxx.se/): for automatically download vim-plug manager
 - [exuberant ctags](http://ctags.sourceforge.net/): generate tags for tagbar plugin
 - [neovim/python-client](https://github.com/neovim/python-client): allow neovim to load python plugins
 - [python-jedi](https://github.com/davidhalter/jedi): support jedi-vim python dev plugin
 - [the_silver_searcher](https://github.com/ggreer/the_silver_searcher): set as default search command for ctrlp plugin, increase the speed

### Installation

  1. Install neovim and other dependencies, check the neovim [installation wiki](https://github.com/neovim/neovim/wiki/Installing-Neovim)

  2. Copy or link configuration directory

    The default location of neovim config dir is `~/.config/nvim`

  3. Open neovim and install plugins

    Use `nvim` command to open neovim(The vim-plug will be downloaded if not exist), then run `PlugUpdate` to install
    all plugins.

  4. Enjoy it.

##### Plugin Manager

[vim-plug](https://github.com/junegunn/vim-plug) is used here,  which is auto detected and installed using **curl** if
not exist(stored as ./autoload/plug.vim). So if you have **curl** installed, you can use `PlugUpdata` command to install
all plugins at the first time. More details can be found on its Github homepage.

Some file type related plugins are configured with on-demand loading for faster startup time. For example, the
**jedi-vim** plugin will be loaded only for editing python files.

##### Configuration Files

Configuration files use '{}' as fold marker for sections,

    " vim: foldmarker={,} foldlevel=0 foldmethod=marker:

1. init.vim: general, display, shortcut, file type and theme settings
2. plugin.vim: plugin and related configurations
3. bundle/ : directory for all plugins, managed by vim-plug
4. colors/: some my favorite color schemes
5. autoload/: automatically loaded files, where the vim-plug is stored
6. ftplugin/: custom file type related plugins, like python.vim will be loaded by editing python type files.
7. custom_snippets/: directory of custom snippets

##### Snippets Management

Using [SirVer/ultisnips](https://github.com/SirVer/ultisnips) and
[honza/vim-snippets](https://github.com/honza/vim-snippets) Custom added and modified snippets are saved in
custom_snippets directory.
