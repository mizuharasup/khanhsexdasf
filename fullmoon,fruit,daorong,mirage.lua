
local http = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Webhook URLs cho từng loại gameElement hoặc fruit
local WEBHOOK_URLS = {
    fruits = "https://discord.com/api/webhooks/1224005746513936474/QyU3HG4paHnPA2eRo8gzdobxmImpLSiAxltP8gNunnlO7t90PLJjy729ZwC2MUg_O31o",  
    mysticIsland = "https://discord.com/api/webhooks/1345618938255380560/LHSLqtYLKd_G4zC4hBKNpy1N3sxC1PYloHrV1hGMy4jb3YT5ppX7ooCWHmeHdG2vyvW-",  
    prehistoricIsland = "https://discord.com/api/webhooks/1224005596265578617/YJYWRCYjWzEFezdjtbQ26GnpNIfCCKWgTKlqGoktXIC6zzhvwu-wyhTI3qcrZkpAV7LR",  
    fullMoonStatus = "https://discord.com/api/webhooks/1224740677590454418/FWQW7dvrKDaxFrD23E_zOeZFx8AsIuS749ybYHjCgGPKy5u954acqPQVwerb8GfML1_u"  
}

-- Phương thức gửi dữ liệu lên API
local function sendDataToAPI(dataType, data)
    local url = WEBHOOK_URLS[dataType]
    if not url then 
        return
    end

    -- Tạo Embed
    local embed = {
        {
            title = "Game Event Detected",
            description = dataType,
            color = tonumber("1cff1a", 16),
            fields = {
                {
                    name = dataType,
                    value = data.value or "Detected",
                    inline = true
                },
                {
                    name = "Players in Server",
                    value = "```" .. tostring(Players.NumPlayers) .. "```",  -- Số người chơi
                    inline = true
                },
                {
                    name = "Job ID",
                    value = "```" .. game.JobId .. "```",  -- Mã Job ID
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
        content = "Game Event: " .. dataType .. " detected",
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

    -- Kiểm tra và ghi log phản hồi từ Discord
    if success then
        if response.StatusCode == 200 then
            return
        elseif response.StatusCode == 204 then
            return
        else
            return
        end
    else
        return
    end
end

-- Kiểm tra các điều kiện trong game
local function checkGameConditions()
    -- Kiểm tra sự tồn tại của map và enemies
    if not Workspace:FindFirstChild("Map") or not Workspace:FindFirstChild("Enemies") then
        return
    end

    local jobID = game.JobId  -- Lấy Job ID của phiên làm việc hiện tại

    -- Kiểm tra các điều kiện khác
    local gameElements = {
        { key = "Moon Status", condition = Lighting:FindFirstChild("Sky") and Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" },  -- Kiểm tra Full Moon
        { key = "fruits", condition = false },
        { key = "prehistoricIsland", condition = Workspace.Map:FindFirstChild("PrehistoricIsland") },
        { key = "mysticIsland", condition = Workspace.Map:FindFirstChild("MysticIsland") }
    }

    -- Gửi dữ liệu khi phát hiện điều kiện
    for _, element in pairs(gameElements) do
        if element.condition then
            sendDataToAPI(element.key, { jobID = jobID, value = element.key })
        end
    end
end

-- Gọi hàm kiểm tra khi script chạy
checkGameConditions()
