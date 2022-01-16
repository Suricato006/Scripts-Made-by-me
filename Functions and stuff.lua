if not _G.Functions then
    Player = game:GetService("Players").LocalPlayer

    function PlayerCheck()
        local a = Player.Character:FindFirstChild("HumanoidRootPart")
        if a then
            return a
        else
            return nil
        end
    end

    function Notify(Titolo, Testo, Durata, Richiamo, Bottone1, Bottone2)
        if Richiamo then
            local bindable = Instance.new("BindableFunction")

            function bindable.OnInvoke(response)
                Richiamo(response)
            end

            game:GetService("StarterGui"):SetCore("SendNotification", {
                Icon = "rbxassetid://8496586222";
                Title = Titolo;
                Text = Testo;
                Duration = Durata;
                Callback = bindable;
                Button1 = Bottone1;
                Button2 = Bottone2
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Icon = "rbxassetid://8496586222";
                Title = Titolo;
                Text = Testo or " ";
                Duration = Durata or 2
            })
        end
    end

    function FastWait()
        return game:GetService("RunService").Heartbeat:wait()
    end

    function PrintTable(Table)
        for i, v in pairs(Table) do
            print(i,v)
        end
    end

    function LerpCFrame(CFrame)
        if PlayerCheck() then
            local StartingCFrame = Player.Character.HumanoidRootPart.CFrame
            local Accuracy = 0.01
            for i=0,1 + Accuracy,Accuracy do FastWait()
                if PlayerCheck() then
                    Player.Character.HumanoidRootPart.CFrame = StartingCFrame:Lerp(CFrame, i)
                end
            end
        end
    end

    function TweenCFrame(CFrame, Speed, part)
        local ActualPart = part or Player.Character.HumanoidRootPart
        local DefaultSpeed = 10
        local Magnitudo = (ActualPart.CFrame.Position - CFrame.Position).magnitude / (Speed or DefaultSpeed)
        local tween = game:GetService("TweenService"):Create(ActualPart, TweenInfo.new(Magnitudo), {CFrame = CFrame})
        tween:Play()
        tween.Completed:wait()
    end

    function NameFind(String, Typed)
        local TempString = String:lower()
        local Typed = Typed:lower()

        for i=1, #TempString do
            local StringPart = TempString:sub(1,i)
            if Typed == StringPart then
                return String
            end
        end
        return false
    end
end
_G.Functions = true