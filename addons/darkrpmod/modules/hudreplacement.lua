local hideHUDElements = {
	["DarkRP_HUD"] = true,
	["DarkRP_EntityDisplay"] = false,
	["DarkRP_ZombieInfo"] = false,
	["DarkRP_LocalPlayerHUD"] = false,
	["DarkRP_Hungermod"] = false,
	["DarkRP_Agenda"] = false
}

hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
	if hideHUDElements[name] then return false end
end)


local function formatNumber(n)

	if not n then return "" end
	if n >= 1e14 then return tostring(n) end
	n = tostring(n)
	local sep = sep or ","
	local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)
	end
	return n
	
end

local function hudBase()

	-- Background
	draw.RoundedBoxEx( 10, 1, ScrH( ) - 151, 300, 150, Color( 0, 0, 0, 255 ), true, false, false, true )
	draw.RoundedBoxEx( 10, 3, ScrH( ) - 149, 296, 146, Color( 55, 55, 55, 255 ), true, false, false, true )

end

local function hudHealth()

	local Health = LocalPlayer( ):Health( ) or 0
	if Health < 0 then Health = 0 elseif Health > 100 then Health = 100 end
	local DrawHealth = math.Min( Health / GAMEMODE.Config.startinghealth, 1 )
	local x = 10+278
	
	draw.RoundedBoxEx( 10, 10, ScrH( ) - 51, 278, 20, Color( 0, 0, 0, 255 ), true, false, false, true )
	if Health == 0 then
		draw.DrawText( "Dead", "AmericanCaptain_1", x/2, ScrH( ) - 52, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	elseif Health != 0 then
		draw.RoundedBoxEx( 10, 12, ScrH( ) - 49, 274*DrawHealth, 16, Color( 255, 0, 0, 255 ), true, false, false, true )
		draw.DrawText( Health.."%", "AmericanCaptain_1", x/2, ScrH( ) - 52, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	
end

local function hudArmor()

	local Armor = LocalPlayer():Armor() or 0
	if Armor < 0 then Armor = 0 elseif Armor > 100 then Armor = 100 end
	local x = 10+278
	
	draw.RoundedBoxEx( 10, 10, ScrH( ) - 32, 278, 20, Color( 0, 0, 0, 255 ), true, false, false, true )
	if Armor == 0 then
		draw.DrawText( "None", "AmericanCaptain_1", x/2, ScrH( ) - 33, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	elseif Armor != 0 then
		draw.RoundedBoxEx( 10, 12, ScrH( ) - 30, 274*Armor/100, 16, Color( 0, 0, 255, 255 ), true, false, false, true )
		draw.DrawText( Armor.."%", "AmericanCaptain_1", x/2, ScrH( ) - 33, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	
end
	
local function hudName()

	local Name = LocalPlayer():Nick() or nil
	
	draw.DrawText( Name, "AmericanCaptain_1", 11, ScrH( ) - 145, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
	
end

local function hudMoney()

	local Money = formatNumber(LocalPlayer():getDarkRPVar("money") or 0)
	
	draw.DrawText( "Money: $"..Money, "AmericanCaptain_1", 11, ScrH( ) - 100, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
	
end

local function hudSalary()
	
	local Salary = formatNumber(LocalPlayer():getDarkRPVar("salary") or 0)
	
	draw.DrawText( "Salary: $"..Salary, "AmericanCaptain_1", 175, ScrH( ) - 100, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
	
end

local function hudJob()

	local Job = LocalPlayer():getDarkRPVar("job") or ""
	
	draw.DrawText( Job, "AmericanCaptain_1", 150, ScrH( ) - 145, team.GetColor( LocalPlayer( ):Team( ) ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
	
end

local iconLicense	= "icon16/page_red.png"
local iconWanted	= "icon16/exclamation.png"

local function hudIcons()

	if LocalPlayer():getDarkRPVar("HasGunlicense") then
		surface.SetDrawColor(255,255,255,255)
	else
		surface.SetDrawColor(25,25,25,255)
	end
	surface.SetMaterial(Material(iconLicense))
	
	if LocalPlayer():getDarkRPVar("wanted") then
		surface.SetDrawColor( 255, 255, 255, 255 )
	else
		surface.SetDrawColor( 25, 25, 25, 255 )
	end
	surface.SetMaterial( Material( iconWanted ) )
	
end

local function hudPaint()

	hudBase()
	hudHealth()
	hudArmor()
	hudName()
	hudMoney()
	hudSalary()
	hudJob()
	hudIcons()
	
end
hook.Add("HUDPaint", "DarkRP_Mod_HUDPaint", hudPaint)
