# Devcontainer Setup

開発コンテナ用の環境設定スクリプト。

## ファイル構成

```
devcontainer/
├── Brewfile        # Homebrew パッケージ
├── install.sh      # セットアップスクリプト（自動実行）
├── setup.sh        # ポストセットアップスクリプト（手動実行）
├── .zshrc          # zsh 設定
├── zim/
│   └── .zimrc      # zimfw モジュール設定
└── README.md
```

## 使用方法

### 1. VS Code の dotfiles 設定（必須）

VS Code の `settings.json` に以下の設定を追加する:

```json
{
  "dotfiles.repository": "your-username/dotfiles",
  "dotfiles.targetPath": "~/dotfiles",
  "dotfiles.installCommand": "devcontainer/install.sh"
}
```

この設定により、devcontainer 作成時に自動で:
1. dotfiles リポジトリが `~/dotfiles` にクローンされる
2. `devcontainer/install.sh` が実行される

### 2. 手動実行（デバッグ用）

```bash
~/dotfiles/devcontainer/install.sh
```

## インストールされるもの

### Homebrew パッケージ

| パッケージ | 説明 |
|-----------|------|
| zsh | シェル |
| starship | プロンプト |
| neovim | エディタ |
| eza | ls の代替 |
| tree | ディレクトリツリー表示 |
| fzf | ファジーファインダー |
| bat | cat の代替 |
| less | ページャー |
| jq | JSON 処理 |
| gomi | 安全な rm |

### Zim モジュール

| モジュール | 説明 |
|-----------|------|
| environment | 基本的な環境設定 |
| input | キーバインド |
| utility | ユーティリティエイリアス |
| exa | eza/exa サポート |
| zsh-completions | 追加の補完定義 |
| completion | タブ補完 |
| zsh-syntax-highlighting | シンタックスハイライト |
| zsh-history-substring-search | 履歴サブストリング検索 |
| zsh-autosuggestions | 自動サジェスト |

## 設定されるシンボリックリンク

| リンク元 | リンク先 |
|---------|---------|
| `~/.zshrc` | `devcontainer/.zshrc` |
| `~/.zimrc` | `devcontainer/zim/.zimrc` |
| `~/.config/starship.toml` | `starship/starship.toml` |
| `~/.config/nvim/init.vim` | `nvim/init.vim` |
| `~/.config/git/config` | `git/config/config` |
| `~/.config/git/ignore` | `git/config/ignore` |

## セットアップ後の追加設定

devcontainer 立ち上げ後、以下のコマンドを実行してポストセットアップを完了する:

```bash
~/dotfiles/devcontainer/setup.sh
```

このスクリプトは以下を実行する:

### Git の設定 (`git/settings.sh`)

- Git config ファイルのシンボリックリンク設定
- core.editor の設定（nvim -> vim -> vi フォールバック）
- Git ユーザー名・メールアドレス（対話形式で入力）
- git-secrets のインストールと設定（AWS 認証情報の漏洩防止）

## 注意事項

- devcontainer 環境（`REMOTE_CONTAINERS`, `CODESPACES`, `/.dockerenv`）でのみシェル設定が適用される
- ローカル環境で実行した場合、シェル設定はスキップされる
- 強制的に適用する場合は `REMOTE_CONTAINERS=1` を設定して実行
