vim.api.nvim_create_user_command("AshenLoad", require("ashen").load, {})
print("ashen is running")
