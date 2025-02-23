-- Hàm kiểm tra nếu giá trị nil
function isnil(value)
    return value == nil
end

-- Hàm làm tròn số
local function roundNumber(value)
    return math.floor(tonumber(value) + 0.5)
end

-- Biến bật/tắt ESP Mirage Island
local MirageIslandESP = true

-- Hàm cập nhật khoảng cách và hiển thị GUI cho Mirage Island
function UpdateIslandMirageEsp()
    for _, island in pairs(game:GetService("Workspace")['_WorldOrigin'].Locations:GetChildren()) do
        pcall(function()
            if MirageIslandESP and island.Name == "Mirage Island" then
                -- Nếu chưa có BillboardGui, tạo mới
                if not island:FindFirstChild("NameEsp") then
                    local billboardGui = Instance.new("BillboardGui", island)
                    billboardGui.Name = "NameEsp"
                    billboardGui.ExtentsOffset = Vector3.new(0, 2, 0) -- Đẩy chữ lên cao để dễ nhìn
                    billboardGui.Size = UDim2.new(0, 200, 0, 50)
                    billboardGui.Adornee = island
                    billboardGui.AlwaysOnTop = true

                    local textLabel = Instance.new("TextLabel", billboardGui)
                    textLabel.Font = Enum.Font.Code
                    textLabel.TextSize = 16
                    textLabel.TextWrapped = true
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.TextYAlignment = Enum.TextYAlignment.Top
                    textLabel.BackgroundTransparency = 1
                    textLabel.TextStrokeTransparency = 0.5
                    textLabel.TextColor3 = Color3.fromRGB(95, 240, 92) -- Màu xanh lá cho dễ nhìn
                    textLabel.Text = "Mirage Island"
                end

                -- Cập nhật khoảng cách từ người chơi đến Mirage Island
                local player = game.Players.LocalPlayer
                if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local playerPosition = player.Character.HumanoidRootPart.Position
                    local islandPosition = island.Position
                    local distanceInStuds = (islandPosition - playerPosition).Magnitude
                    local distanceInMeters = roundNumber(distanceInStuds / 3) -- Chuyển đổi Studs thành Mét

                    -- Cập nhật khoảng cách hiển thị
                    if island:FindFirstChild("NameEsp") then
                        island.NameEsp.TextLabel.Text = "🏝 Mirage Island\n📏 Khoảng cách: " .. distanceInMeters .. " m"
                    end
                end
            elseif island:FindFirstChild("NameEsp") then
                island:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end

-- Chỉ chạy khi game bắt đầu và cập nhật mỗi 0.5s để tránh lag
while wait(0.5) do
    UpdateIslandMirageEsp()
end
