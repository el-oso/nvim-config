local util = require("lspconfig.util")

return {
  {
    "Vigemus/iron.nvim",
    lazy = true,
    config = function()
      local iron = require("iron.core")

      iron.setup({
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "zsh" },
            },
            julia = {
              command = function(meta)
                local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
                local project_dir = util.root_pattern("Project.toml")(filename) or util.find_git_ancestor(filename)

                if project_dir == nil then
                  project_dir = vim.fs.dirname(filename)
                end

                vim.wo.relativenumber = false
                vim.wo.number = false

                return {
                  "julia",
                  "--project=" .. project_dir,
                  "-e",
                  [[using Revise; enable_autocomplete_brackets(false)]],
                  "-i",
                }
              end,
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require("iron.view").split.vertical.botright(0.5),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = "<leader>sc",
          visual_send = "<leader>sc",
          send_file = "<leader>sf",
          send_line = "<leader>sl",
          send_until_cursor = "<leader>su",
          send_mark = "<leader>sm",
          mark_motion = "<leader>mc",
          mark_visual = "<leader>mc",
          remove_mark = "<leader>md",
          cr = "<leader>s<cr>",
          interrupt = "<leader>s<leader>",
          exit = "<leader>sq",
          clear = "<leader>rc",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      })
    end,
    keys = {
      { "<leader>rs", "<cmd>IronRepl<cr>", desc = "Start REPL" },
      { "<leader>rh", "<cmd>IronReplHere<cr>", desc = "Start REPL here" },
      { "<leader>rf", "<cmd>IronFocus<cr>", desc = "Focus REPL" },
      { "<leader>rr", "<cmd>IronRestart<cr>", desc = "Restart REPL" },
      { "<leader>rj", "<cmd>IronHide<cr>", desc = "Hide REPL" },
    },
  },
}
