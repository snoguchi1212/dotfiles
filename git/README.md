# Git

## setups

1. First, you should run

```(shell)
sh $DOTFILES/brew/install.sh
```

Because there are some dependencies. ([git](https://formulae.brew.sh/formula/git), [git-secrets](https://github.com/awslabs/git-secrets))

2. Then, run

```(shell)
sh $DOTFILES/git/install.sh
```

By doing these operation, you can configure git,

## Notes

- Do not push `config.local`

- Not recommend to push these configs. (These properties will be overwritten when running  `settings.sh`.)
  - core.excludesfile
  - include.path

- `$DOTFILES/git/install.sh` will install git-git-credential-manager via brew.
This package will make and write to `~/.gitconfig`. I don't want to do that, so I will download it when setting up git.
