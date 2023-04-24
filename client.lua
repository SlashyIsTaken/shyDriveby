Citizen.CreateThread(function()
    while true do
        local shooty = true
        local ped = PlayerPedId()
        local _, weapon = GetCurrentPedWeapon(ped)
        local unarmed = `WEAPON_UNARMED`
        sleep = 1000
        if IsPedInAnyVehicle(ped) and weapon ~= unarmed then
            sleep = 1
			local veh = GetVehiclePedIsIn(ped, false)
			if GetPedInVehicleSeat(veh, -1) == ped or (GetEntitySpeed(veh) * 3.6) > Shy.MaxSpeed then
				shooty = false
			else
                if Shy.OnlyForward then
                    if heading() then
                        shooty = true
                    else 
                        shooty = false
                    end
                else
				    shooty = true
                end
			end

            if Shy.FirstPerson then
                if IsPedDoingDriveby(ped) then
                    SetFollowVehicleCamViewMode(4)
                else
                    SetFollowVehicleCamViewMode(0)
                end
            end
        end

        SetPlayerCanDoDriveBy(PlayerId(), shooty)
        Citizen.Wait(sleep)
    end
end)

function heading()
    local heading = GetGameplayCamRelativeHeading()
    if heading >= -90 and heading <= 90 then
        return true
    else
        return false
    end
end