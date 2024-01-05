require("lsp-progress").setup({
    debug = false,
    console_log = true,
    file_log = false,
    client_format = function(client_name, spinner, series_messages)
        return #series_messages > 0
            and (spinner .. " " .. table.concat(
                series_messages,
                ", "
            ))
            or nil
    end,
    format = function(client_messages)
        local active_clients = vim.lsp.get_active_clients()
        if #client_messages > 0 then
            return table.concat(client_messages, " ")
        end
        if #active_clients == 0 then
            return nil
        end

        local client_names = {}
        for _, client in ipairs(active_clients) do
            if client and client.name ~= "" then
                table.insert(client_names, client.name)
            end
        end
        return table.concat(client_names, "|")
    end,
})
