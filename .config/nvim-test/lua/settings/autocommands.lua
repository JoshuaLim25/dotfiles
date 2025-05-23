local M = {}

-- [[ HIGHLIGHT ON YANK ]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- [[ JUMP TO LAST CURSOR POSITION ON FILE OPEN ]]
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lnum = mark[1]
		local col = mark[2]
		if lnum > 1 and lnum <= vim.api.nvim_buf_line_count(0) then
			if not vim.fn.expand("%:p"):find("/%.git/") then
				vim.schedule(function()
					pcall(vim.api.nvim_win_set_cursor, 0, { lnum, col })
				end)
			end
		end
	end,
})

-- [[ PREVENT ACCIDENTAL WRITES TO BUFFERS THAT SHOULDN'T BE EDITED ]]
vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.orig", "*.pacnew" },
	command = "set readonly",
})

-- [[ LEAVE PASTE MODE WHEN LEAVING INSERT MODE ]]
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- [[ FILETYPE DETECTION (as needed, just example of how) ]]
--vim.api.nvim_create_autocmd('BufRead', { pattern = '*.txt', command = 'set filetype=someft' })
-- }}

-- [[ SET SPELL FOR TEXT FILETYPES ]]
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("setspell", { clear = true }),
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		-- command = 'setlocal spell tw=72 colorcolumn=73',
		vim.opt_local.spell = true
	end,
})

-- [[ OPEN DOCS IN FULLSCREEN ]]
-- Usage: <leader>fh -> <leader>; to toggle -> <leader>bd to quit
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.cmd("wincmd T")
	end,
})

-- [[ SET WORKDIR TO FILE YOU'RE EDITING ]]
-- Use case: open random ass file, realize you wanna be in that dir,
-- so you <leader>cd and open a new pane to do stuff
M.change_to_buf_dir = function()
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath == "" then
		vim.notify("[cd] No file path detected.", vim.log.levels.WARN)
		return
	end
	local dir = vim.fn.fnamemodify(filepath, ":p:h")
	if vim.fn.isdirectory(dir) == 1 then
		vim.cmd("lcd " .. vim.fn.fnameescape(dir))
		vim.notify("cwd → " .. dir, vim.log.levels.INFO)
	else
		vim.notify("Invalid directory: " .. dir, vim.log.levels.ERROR)
	end
end

-- [[ SAVE SCRATCHPAD BUFFER FROM /TMP AFTER 5 WRITES ]]
local scratchpad = "/tmp/*.md"
local destination = vim.fn.expand("~/spaghetti/projects/notes/")
local writes = {}
local max_writes = 5
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = scratchpad,
	callback = function(args)
		local bufnr = args.buf
		writes[bufnr] = (writes[bufnr] or 0) + 1 -- incr on write
		if writes[bufnr] > max_writes then
			local suffix = os.date("%Y-%m-%d-")
			local basename = vim.fn.fnamemodify(args.file, ":t") -- "tail" of absolute path for current buf (blah.md)
			local dest = destination .. suffix .. basename
			if vim.fn.filereadable(dest) == 1 then
				-- vim.notify('Destination file already exists, write it yourself:', vim.log.levels.ERROR)
				-- ask for input starting from
				vim.ui.input({
					prompt = string.format("Destination file already exists:"),
					default = dest,
				}, function(input)
					if input and #input > 0 then
						os.rename(args.file, input)
						vim.api.nvim_buf_set_name(0, input)
						vim.notify(
							string.format("Moved scratchpad from %s -> %s", args.file, input),
							vim.log.levels.INFO
						)
					end
				end)
				return
			end
			os.rename(args.file, dest)
			vim.api.nvim_buf_set_name(0, dest) -- set the scratchpad buf to point to this new one
			vim.notify(string.format("Moved scratchpad from %s -> %s", args.file, dest), vim.log.levels.INFO)
		end
	end,
})

return M
