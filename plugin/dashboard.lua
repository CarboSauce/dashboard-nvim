local api = vim.api
local db = require('dashboard')

local dashboard_start = api.nvim_create_augroup('dashboard_start', { clear = true })
api.nvim_create_autocmd('Vimenter', {
  group = dashboard_start,
  nested = true,
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.line2byte('$') == -1 then
      db.instance(true)
    end
  end,
})

api.nvim_create_user_command('Dashboard', function()
  require('dashboard').instance(false)
end, {})

api.nvim_create_user_command('DashboardNewFile', function()
  require('dashboard').new_file()
end, {})

api.nvim_create_user_command('SessionSave', function()
  require('dashboard.session').session_save()
end, {
  nargs = '?',
  complete = require('dashboard.session').session_list,
})

api.nvim_create_user_command('SessionLoad', function()
  require('dashboard.session').session_load()
end, {
  nargs = '?',
  complete = require('dashboard.session').session_list,
})
