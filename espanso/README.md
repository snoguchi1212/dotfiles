# Expander (Snippet) tool

## Setup

```(shell)
```

By Doing the following settings, you can expand passwords securely.
[espanso-password-expander.me](https://gist.github.com/lajlev/54b3f67db64c34a993500e263c381681#file-espanso-password-expander-me)

```(yml)
matches:
  - triggers: [":password:"]
    replace: "{{output}}"
    vars:
      - name: output
        type: shell
        params:
          cmd: "security find-generic-password -a 'password' -w"
```
