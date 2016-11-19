##My-Vim

### Overview
  - This is a light version without any plugins, suitable for remote editing
  - If you want a powerful dev-editor with multiple plugins, please check my [neovim config](https://github.com/stevelorenz/my-neovim)

### File Description
  1. colors (dir): colorshemes
  2. vimrc.vim (file): config file, check its comments for details

### Install
1. clone repository to local path, recommend in home dir

        $ git clone https://github.com/stevelorenz/my-vim ~/.vim

2. install dependencies

        $ sudo apt-get install build-essential
        $ sudo apt-get install vim vim-gtk

3. make a link of .vimrc in home dir

        $ ln -s $HOME/.vim/vimrc.vim ~/.vimrc

4. edit the vimrc file for custom settings (when needed)

##My-Vim

###简介:
  - 无插件轻量级Vim配置，适合远程或轻量级编辑
  - 如果需要丰富插件支持的版本(适合作为主力开发文本编辑器)，请参考[neovim配置](https://github.com/stevelorenz/my-neovim)

###文件说明:

  1. colors (dir): 配色方案集
  2. vimrc.vim (file): 配置文件, 具体设置参看文件内注释

###安装步骤:

1.Clone到本地的 ~/.vim 文件夹

    $ git clone https://github.com/stevelorenz/my-vim ~/.vim

2.安装依赖包

    $ sudo apt-get install build-essential
    $ sudo apt-get install vim vim-gtk

3.链接至~/.vimrc文件

    $ ln -s $HOME/.vim/vimrc.vim  ~/.vimrc

4.根据需求修改~/.vim/vimrc.vim中的配置
