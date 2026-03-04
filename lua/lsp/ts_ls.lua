return {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
    },
    settings = {
        typescript = {
            inlayHints = { -- コード上に型ヒントを薄く表示する
                includeInlayParameterNameHints = 'all',
                includeInlayVariableTypeHints = true,
            }
        }
    }
}
