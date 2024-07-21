P = function(v)
  print(vim.inspect(v))
  return v
end

function OpenGitHubRepo()
  local function open_uri(uri)
    if type(uri) ~= "nil" then
      uri = string.gsub(uri, "#", "\\#") -- double escapes any # signs
      uri = '"' .. uri .. '"'
      vim.cmd("!$BROWSER " .. uri .. " > /dev/null")
      vim.cmd("mode")
      return true
    else
      return false
    end
  end

  local word_under_cursor = vim.fn.expand("<cWORD>")

  -- consider anything that looks like string/string a github link
  local regex_plugin_url = "[%a%d%-%.%_]*%/[%a%d%-%.%_]*"

  if open_uri("https://github.com/" .. string.match(word_under_cursor, regex_plugin_url)) then
    return
  end
end

vim.api.nvim_create_user_command("OpenGitHubRepo", OpenGitHubRepo, {})
vim.keymap.set("n", "<leader>gh", OpenGitHubRepo)
