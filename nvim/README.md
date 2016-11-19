## My Neovim Configuration

This is my relative effective configuration of Neovim for python and c development.

### Dependencies

 - curl: for automatically download vim-plug manager
 - [exuberant ctags](http://ctags.sourceforge.net/): generate tags for tagbar plugin
 - [neovim/python-client](https://github.com/neovim/python-client): allow neovim to load python plugins
 - [python-jedi](https://github.com/davidhalter/jedi): support jedi-vim python dev plugin
 - [the_silver_searcher](https://github.com/ggreer/the_silver_searcher): set as default search command for ctrlp plugin, increase the speed

### Features

##### Plugin Manager
[vim-plug](https://github.com/junegunn/vim-plug) is used as the default plugin manager.

It is auto detected and installed using **curl** if not exist(stored as ./autoload/plug.vim)

Some filetype related plugins are configured with on-demand loading for faster startup time. For example, the jedi-vim
autocomplete plugin will be loaded only for editing python files.

##### Configuration Files

Configuration files use '{}' as fold marker for sections,

    " vim: foldmarker={,} foldlevel=0 foldmethod=marker:
1. init.vim: general, display, shortcut, file type and theme settings
2. plugin.vim: plugin and related configurations
3. bundle/ : directory for all plugins, managed by vim-plug
4. colors/: some favorite color schemes
5. autoload/: automatically loaded files, where the vim-plug is stored
6. custom_snippets/: directory of custom snippets

##### Snippets Management
Using [SirVer/ultisnips](https://github.com/SirVer/ultisnips) and [honza/vim-snippets](https://github.com/honza/vim-snippets)
Custom added and modified snippets are saved in custom_snippets directory.
