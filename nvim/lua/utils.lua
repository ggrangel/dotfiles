local keymap = vim.keymap.set

function OpenGitHubRepo()
  local function open_uri(uri)
    if type(uri) ~= "nil" then
      uri = string.gsub(uri, "#", "\\#") -- double escapes any # signs
      uri = '"' .. uri .. '"'
      vim.cmd("!xdg-open " .. uri .. " > /dev/null")
      vim.cmd "mode"
      return true
    else
      return false
    end
  end

  local word_under_cursor = vim.fn.expand "<cWORD>"

  -- consider anything that looks like string/string a github link
  local regex_plugin_url = "[%a%d%-%.%_]*%/[%a%d%-%.%_]*"

  if open_uri("https://github.com/" .. string.match(word_under_cursor, regex_plugin_url)) then
    return
  end
end

vim.api.nvim_create_user_command("OpenGitHubRepo", OpenGitHubRepo, {})
keymap("n", "<leader>gh", OpenGitHubRepo)

-- Disable builtin unused plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
