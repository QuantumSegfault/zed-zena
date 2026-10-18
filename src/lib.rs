use zed_extension_api as zed;

struct ZenaExtension {}

impl zed::Extension for ZenaExtension {
    fn new() -> Self {
        ZenaExtension {}
    }

    fn language_server_command(
        &mut self,
        language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> zed::Result<zed::Command> {
        if language_server_id.as_ref() == "zena-cli" {
            Ok(zed::Command {
                command: worktree
                    .which("zena-cli")
                    .ok_or_else(|| "Could not find `zena-cli` on PATH.".to_string())?,
                args: vec!["lsp".into()],
                env: vec![],
            })
        } else {
            Err(format!(
                "Unknown language server for Zena: {language_server_id}"
            ))
        }
    }
}

zed::register_extension!(ZenaExtension);
