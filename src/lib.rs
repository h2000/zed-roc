use zed_extension_api::{self as zed, serde_json, Result};

struct RocExtension;

/// The options `roc experimental-lsp` is started with.
///
/// Since roc-lang/roc#12096 the server serves only formatting, folding and
/// selection ranges unless the client says the workspace is trusted: its
/// semantic features build the project, which downloads URL packages and
/// runs compile-time evaluation. Zed already asks that question. It starts
/// no language server in a worktree in Restricted Mode, and waits until the
/// user trusts it (Settings: worktree trust). So by the time this server
/// runs, the worktree is trusted, and the extension says so.
///
/// A user's `lsp.roc.initialization_options` in Zed's settings is merged
/// over these, so `"trustedWorkspace": false` turns semantic features off.
fn initialization_options() -> serde_json::Value {
    serde_json::json!({ "trustedWorkspace": true })
}

impl zed::Extension for RocExtension {
    fn new() -> Self {
        Self
    }

    fn language_server_command(
        &mut self,
        _config: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        let binary_name = "roc";
        let path = worktree
            .which(binary_name)
            .ok_or_else(|| format!("{binary_name} executable not found in $PATH"))?;

        Ok(zed::Command {
            command: path,
            args: vec!["experimental-lsp".to_string(), "--stdio".to_string()],
            env: Default::default(),
        })
    }

    fn language_server_initialization_options(
        &mut self,
        _config: &zed::LanguageServerId,
        _worktree: &zed::Worktree,
    ) -> Result<Option<serde_json::Value>> {
        Ok(Some(initialization_options()))
    }
}

zed::register_extension!(RocExtension);

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn says_the_workspace_is_trusted() {
        assert_eq!(initialization_options()["trustedWorkspace"], true);
    }
}
