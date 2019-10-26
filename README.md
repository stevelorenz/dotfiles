## Zuo's Dotfiles

This is a snapshot of my dotfiles which I am using every day.

Dotfiles are managed by the [GNU stow](https://www.gnu.org/software/stow/).
It can be installed easily via your package manager (stow requires Perl).

* `sudo pacman -S stow`
* `sudo apt install stow`

NOTE: dotfiles located in [./not_stowable/](./not_stowable/) currently can not be deployed by stow.

```bash
git clone https://github.com/stevelorenz/dotfiles ~/dotfiles
cd ~/dotfiles
stow -t $HOME nvim  # ... the same for other tools ^_^
```

Any problems or questions, feel free to post an issue or email me (xianglinks@gmail.com).
