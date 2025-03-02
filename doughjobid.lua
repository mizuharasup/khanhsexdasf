local http = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DOUGH_KING_WEBHOOK_URL = "https://discord.com/api/webhooks/1345619479639494686/ztplcy8eJZim_Mn5MRs8vfRbPkSvJ21hQ9m_HrCha0NpxrOcMFeRY52P30EatzvxhiEA"

local function sendDoughKingData()
    local url = DOUGH_KING_WEBHOOK_URL
    if not url then 
        return
    end

    -- Tạo Embed dữ liệu cho Dough King
    local embed = {
        {
            title = "Cuttay hub",
            description = "Dough King",
            color = tonumber("1cff1a", 16),
            fields = {
                {
                    name = "Raid-boss-spam",
                    value = "Dough King",
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
        content = "Game Event: Dough King ",
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

-- Kiểm tra sự tồn tại của "Dough King" trong ReplicatedStorage
local function checkDoughKing()
    local doughKing = ReplicatedStorage:FindFirstChild("Dough King")
    if doughKing then
        sendDoughKingData()
    end
end

-- Gọi hàm kiểm tra và gửi dữ liệu cho Dough King
checkDoughKing()
