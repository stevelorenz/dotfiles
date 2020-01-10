## Zuo's Dotfiles

This is a snapshot/backup of the dotfiles I use in my daily development work.

Dotfiles are managed by the [GNU stow](https://www.gnu.org/software/stow/).
It can be installed easily via your package manager (stow requires Perl).

* On Arch: `sudo pacman -S stow`
* On GNU/Debian: `sudo apt install stow`

NOTE: dotfiles located in [./not_stowable/](./not_stowable/) currently can not be deployed by stow.

```bash
git clone https://github.com/stevelorenz/dotfiles ~/dotfiles
cd ~/dotfiles
stow -t $HOME nvim  # ... the same for other tools ^_^
```

Any problems or questions, feel free to post an issue or email me (xianglinks@gmail.com).
