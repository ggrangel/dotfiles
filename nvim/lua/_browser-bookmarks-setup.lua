require("telescope").load_extension("bookmarks")

-- require("telescope").setup({
-- 	extensions = {
-- 		bookmarks = {
-- 			-- Available: 'brave', 'chrome', 'edge', 'firefox', 'safari'
-- 			selected_browser = "brave",

-- 			-- Either provide a shell command to open the URL
-- 			url_open_command = "open",

-- 			-- Or provide the plugin name which is already installed
-- 			-- Available: 'vim_external', 'open_browser'
-- 			url_open_plugin = nil,

-- 			-- Show the full path to the bookmark instead of just the bookmark name
-- 			full_path = true,

-- 			-- Provide a custom profile name for Firefox
-- 			firefox_profile_name = nil,
-- 		},
-- 	},
-- })
-- require('telescope').extensions.bookmarks.bookmarks(
--   require('telescope.themes').get_dropdown {
--     layout_config = {
--       width = 0.8,
--       height = 0.8,
--     },
--     previewer = false,
--   }
-- )
