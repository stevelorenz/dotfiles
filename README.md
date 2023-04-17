## Zuo's Dotfiles

This is a snapshot/backup of the dotfiles I use in my daily development work
and on my personal GNU/Linux laptop.

I personally use symlinks to avoid manually copying/updating process when some
dotfiles in this repository are updated.
Instead of writing yet another bunch of customized scripts, I decided to use
[GNU stow](https://www.gnu.org/software/stow/) for symlink management.
GNU stow is a symlink farm manager that can be used to simplify the creation of
symlinks for dotfiles.
Directory structure in this repository is organized in the way that these dotfiles
can be easily deployed by the GNU stow.

WARN: dotfiles located in [./not_stowable/](./not_stowable/) currently **can
not** be deployed by GNU stow.
Don't use `stow` command for the directly `./not_stowable`.

On Linux or MacOS, GNU stow can be installed easily via your package manager (stow requires Perl).

* On Arch: `sudo pacman -S stow`
* On GNU/Debian: `sudo apt install stow`
* On MacOS: Use homebrew, `brew install stow`

Once GNU stow is installed, you can deploy dotfiles in this repository based on
the top directory name in this repository.
Taking [Neovim](https://neovim.io/) for example, you can deploy the fancy
Neovim configuration by running following command in your shell (with the
current working directory is the `dotfiles` that is cloned from this
repository, of course ^_^):

```bash
stow -t $HOME nvim
```

Then you can find a symlink of the `nvim` directory in your `~/.config` directory.

Other dotfiles can be deployed in the same way, including git, tmux, i3,
i3status-rust, alacritty, wezterm and so on.

Any problems or questions, feel free to post an issue directly on GitHub or
email me (xianglinks@gmail.com).



TODO: Add a cute description of my Neovim setup as a README file in
`./nvim/.config/nvim/README.md`
