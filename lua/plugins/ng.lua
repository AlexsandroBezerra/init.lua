return {
    "joeveiga/ng.nvim",
    keys = {
        { 
            "<leader>at", 
            function() require("ng").goto_template_for_component() end, 
            desc = "Angular | Go to template"
        },
        { 
            "<leader>ac", 
            function() require("ng").goto_component_with_template_file() end, 
            desc = "Angular | Go to component"
        },
        { 
            "<leader>aT", 
            function() require("ng").get_template_tcb() end, 
            desc = "Angular | Go to template tbc"
        },
    }
}
