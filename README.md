# Zed Zena

[Zena](https://zena-lang.dev/) language extension for the [Zed](https://zed.dev/) editor.

It provides LSP support via `zena-cli`'s own [builtin language server](https://zena-lang.dev/reference/language-server/). Typescript grammar is used for syntax-highlighting until a tree-sitter grammar exists for Zena.

### Install

Right now the [quickstart instructions](https://zena-lang.dev/guide/overview/) have you alias the zena-cli, which Zed doesn't see. You'll need to symlink it, for this extension to work:

```bash
ln -s /path/to/zena/target/release/zena-cli ~/.local/bin/zena-cli
```

alternatively you can add the following to `~/.zshenv` or `~/.zprofile`:

```bash
export PATH="/path/to/zena/target/release:$PATH"
```

From there:

- `git clone https://github.com/QuantumSegfault/zed-zena.git`
- open it with `zed:install-dev-extension`
- wait a few minutes for it to build
- re-open zed on a `.zena` file 👍
