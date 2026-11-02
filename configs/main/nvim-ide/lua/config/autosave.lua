local M = {}

function M.setup()
  local timer = nil
  local delay = 2500

  local function autosave()
    local mode = vim.fn.mode()

    local in_visual = mode == "v" or mode == "V" or mode == "\22"

    if vim.bo.modified and vim.bo.buftype == "" and not mode:match("^i") and not in_visual then
      vim.cmd("silent! write")
    end
  end

  local function schedule()
    if timer then
      timer:stop()
      timer = nil
    end

    timer = vim.defer_fn(autosave, delay)
  end

  vim.api.nvim_create_autocmd({
    "InsertLeave",
    "TextChanged",
    "BufLeave",
  }, {
    callback = schedule,
  })
end

return M
