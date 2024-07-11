return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc="Find files" },
	 	{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc="Find git files" },
	 	{ "<leader>lg", "<cmd>Telescope live_grep<cr>", desc="Grep files" },
	 	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc="Find buffers" }
	}
}
