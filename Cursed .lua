local http = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CURSED_CAPTAIN_WEBHOOK_URL = "https://discord.com/api/webhooks/1224717998787657759/m1uBR-kudACuyPYZnaGQ9cfrklpy15SpfZI5duJWxVA_hSoMkBQ_YJ7EDQ36VHiJxwWd"

local function sendCursedCaptainData()
    local url = CURSED_CAPTAIN_WEBHOOK_URL
    if not url then 
        return
    end

    -- Tạo Embed dữ liệu cho Cursed Captain
    local embed = {
        {
            title = "Cuttay hub",
            description = "Cursed Captain",
            color = tonumber("1cff1a", 16),
            fields = {
                {
                    name = "Raid-boss-spam",
                    value = "Cursed Captain",
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
        content = "Game Event: Cursed Captain ",
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

-- Kiểm tra sự tồn tại của "Cursed Captain" trong ReplicatedStorage
local function checkCursedCaptain()
    local cursedCaptain = ReplicatedStorage:FindFirstChild("Cursed Captain")
    if cursedCaptain then
        sendCursedCaptainData()
    end
end

-- Gọi hàm kiểm tra và gửi dữ liệu cho Cursed Captain
checkCursedCaptain()
