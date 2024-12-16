return {
  'linrongbin16/lsp-progress.nvim',
  opts = {
    client_format = function(client_name, spinner, series_messages)
      if #series_messages == 0 then
        return nil
      end
      return {
        name = client_name,
        body = spinner .. " " .. series_messages[1],
      }
    end,
    format = function(messages)
      return #messages > 0 and messages[1].body or ""
    end,
  }
}