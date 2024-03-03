# brew

## VSCode settings

VSCode's setting files are linked by `/install/bootstrap.sh`.  
If you want more details, Please look at `/install/README.md`.

## extensions install

First, check `install.sh` and select what you need.  
Then, run

```(bash)
bash "${DOTFILES}/vscode/install.sh"
```

If you want to install partial brew files, you can run

```(shell)
brew bundle --file "${DOTFILES}/vscode/extensions/[specific_name].Brewfile"
```

inspired from

- <https://github.com/posquit0/brewfile>
- <https://qiita.com/miiina016/items/018331b36ecf57ed8973>
