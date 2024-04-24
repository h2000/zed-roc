use zed_extension_api::{self as zed, Result};

struct RocExtension;

impl zed::Extension for RocExtension {
    fn new() -> Self {
        Self
    }

    fn language_server_command(
        &mut self,
        _config: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        let path = worktree
            .which("roc_lang_server")
            .ok_or_else(|| "roc_lang_server not found".to_string())?;

        Ok(zed::Command {
            command: path,
            args: vec![],
            env: Default::default(),
        })
    }
}

zed::register_extension!(RocExtension);
