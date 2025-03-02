local http = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RIP_INDRA_WEBHOOK_URL = "https://discord.com/api/webhooks/1232186689741651968/piyDhtZPKJlrNCZ5VmO-onVXfIcdj3a5nkhruC6eW82KPe7h_PZEIkb9slKrP8jHs7Np"

local function sendRipIndraData()
    local url = RIP_INDRA_WEBHOOK_URL
    if not url then 
        return
    end

    -- Tạo Embed dữ liệu cho rip_indra True Form
    local embed = {
        {
            title = "Cuttay hub",
            description = "rip_indra True Form ",
            color = tonumber("1cff1a", 16),
            fields = {
                {
                    name = "Raid-boss-spam",
                    value = "rip_indra True Form",
                    inline = true
                },
                {
                    name = "Players in Server",
                    value = "```" .. tostring(Players.NumPlayers) .. "```",
                    inline = true
                },
                {
                    name = "Job ID",
                    value = "```" .. game.JobId .. "```",
                    inline = true
                }
            },
            footer = {
                text = "Creator: mizuahara0.0"
            }
        }
    }

    -- Gửi dữ liệu qua webhook
    local payload = http:JSONEncode({
        content = "Game Event: rip_indra True Form ",
        embeds = embed
    })

    local headers = { ["Content-Type"] = "application/json" }

    local requestFunction = http_request or request or syn.request
    
    local success, response = pcall(function()
        return requestFunction({
            Url = url,
            Method = "POST",
            Headers = headers,
            Body = payload
        })
    end)

    if success and response.StatusCode == 200 then
        return
    end
end

-- Kiểm tra sự tồn tại của "rip_indra True Form" trong ReplicatedStorage
local function checkRipIndra()
    local ripIndra = ReplicatedStorage:FindFirstChild("rip_indra True Form")
    if ripIndra then
        sendRipIndraData()
    end
end

-- Gọi hàm kiểm tra và gửi dữ liệu cho rip_indra True Form
checkRipIndra()
