scope WeaponGain initializer init

	globals
	    real Event_UnitAddWeapon_Real
	    unit Event_UnitAddWeapon_Hero
	    item Event_UnitAddWeapon_Item
	    
	    real Event_UnitLoseWeapon_Real
	    unit Event_UnitLoseWeapon_Hero
	    item Event_UnitLoseWeapon_Item
	endglobals
	
	globals
	    real Event_UnitAddUltimateWeapon_Real
	    unit Event_UnitAddUltimateWeapon_Hero
	    item Event_UnitAddUltimateWeapon_Item
	    
	    real Event_UnitLoseUltimateWeapon_Real
	    unit Event_UnitLoseUltimateWeapon_Hero
	    item Event_UnitLoseUltimateWeapon_Item
	endglobals
	
	private function condition takes nothing returns boolean
	    if udg_logic[36] then
	        return false
	    endif
	    if not( Weapon_Logic(GetManipulatedItem()) ) then
	        return false
	    endif
	    return true
	endfunction
	
	private function WeaponWord takes string s returns string
		local integer cyclA = 0
		local integer cyclAEnd = StringLength(s)
		local integer i = 0
	
		loop
			exitwhen cyclA > cyclAEnd
			if SubString(s, cyclA, cyclA+8) == "Weapon|r" then
				set i = cyclA + 10
				set cyclA = cyclAEnd
			endif
			set cyclA = cyclA + 1
		endloop
	
		return SubString(s, i, StringLength(s))
	endfunction
	
	private function GetItemText takes item it returns string
		return "|n> "+ WeaponWord( BlzGetItemExtendedTooltip(it) )
	endfunction
	
	private function AddWeapon takes unit hero, item itemUsed returns nothing
		local string textGain = GetItemText( itemUsed )
		local integer index = CorrectPlayer(hero)
		local string itemName = GetItemName( itemUsed )
		local integer itemType = GetItemTypeId( itemUsed )
		local item ultWeapon
		local UltimateWeapon weaponData
		local boolean isAdded
	
		set ultWeapon = GetItemOfTypeFromUnitBJ( hero, WeaponPieceSystem_ULTIMATE_WEAPON_ID)
		set weaponData = UltimateWeapon.GetStruct(ultWeapon)
        set isAdded = weaponData.Add(itemType)
	
		if isAdded then
	        call RemoveItem( itemUsed )
	
	    	set udg_Set_Weapon_Number[index] = udg_Set_Weapon_Number[index] + 1
	    
	        call DisplayTimedTextToPlayer( GetOwningPlayer( hero ), 0, 0, 10, "Artifact |cffffcc00'" + itemName + "'|r added to |cff2d9995Ultimate Weapon|r." )
	        
	        call BlzSetItemExtendedTooltip( ultWeapon, BlzGetItemExtendedTooltip(ultWeapon) + textGain )

	        set Event_UnitAddWeapon_Hero = hero
	        set Event_UnitAddWeapon_Item = ultWeapon
	        
	        set Event_UnitAddWeapon_Real = 0.00
	        set Event_UnitAddWeapon_Real = 1.00
	        set Event_UnitAddWeapon_Real = 0.00
        endif
            
        set ultWeapon = null
	endfunction
	
	private function CreateUltimateWeapon takes unit hero returns nothing
		local integer i
		local integer iMax
		local item itemSlot
		local string textGain = ""
		local item newItem
		local UltimateWeapon weaponData
		local integer itemType
		local integer index = CorrectPlayer(hero)
		local boolean isAdded
		local integer id

		set newItem = CreateItem( WeaponPieceSystem_ULTIMATE_WEAPON_ID, GetUnitX( hero ), GetUnitY( hero ) )
        set weaponData = UltimateWeapon.create(newItem, hero)

        set i = 0
        set iMax = UnitInventorySize(hero)
        loop
            exitwhen i >= iMax
            set itemSlot = UnitItemInSlot( hero, i )
            set itemType = GetItemTypeId( itemSlot )
            if Weapon_Logic(itemSlot) then
            
            	set isAdded = weaponData.Add(itemType)
                if isAdded then
                	set textGain = textGain + GetItemText( itemSlot )
            	endif
            	
                call UnitRemoveItemFromSlot( hero, i )
                call RemoveItem(itemSlot)
            endif
            set i = i + 1
        endloop

        set Event_UnitLoseUltimateWeapon_Hero = hero
        set Event_UnitLoseUltimateWeapon_Item = null
        
        set Event_UnitLoseUltimateWeapon_Real = 0.00
        set Event_UnitLoseUltimateWeapon_Real = 1.00
        set Event_UnitLoseUltimateWeapon_Real = 0.00
        
        call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5.00, udg_Player_Color[index] + GetPlayerName(GetOwningPlayer(hero)) + "|r assembled set |cff2d9995Weapon|r!" )
	    call DestroyEffect( AddSpecialEffect( "Objects\\Spawnmodels\\Human\\HCancelDeath\\HCancelDeath.mdl", GetUnitX( hero ), GetUnitY( hero ) ) )
	    call iconon( index,  "Оружие", "war3mapImported\\PASAchievement_Arena_3v3_7_result.blp" )
	    
	    call BlzSetItemExtendedTooltip( newItem, BlzGetItemExtendedTooltip(newItem) + textGain )
	    
	    call UnitAddItem( hero, newItem )
	    
	    set Event_UnitAddUltimateWeapon_Hero = hero
	    set Event_UnitAddUltimateWeapon_Item = newItem
	    
	    set Event_UnitAddUltimateWeapon_Real = 0.00
	    set Event_UnitAddUltimateWeapon_Real = 1.00
	    set Event_UnitAddUltimateWeapon_Real = 0.00
        
        set newItem = null
	endfunction
	
	private function CreateUltimateWeapon_End takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
    	local unit hero = LoadUnitHandle( udg_hash, id, StringHash( "ult_wep_delay" ) )
    	
    	call CreateUltimateWeapon(hero)
    	call FlushChildHashtable( udg_hash, id )
    	
    	set hero = null
	endfunction
	
	private function CreateUltimateWeapon_Delay takes unit hero returns nothing
		call InvokeTimerWithUnit( hero, "ult_wep_delay", 0.01, false, function CreateUltimateWeapon_End )
	endfunction

	private function action takes nothing returns nothing
	    local unit u = GetManipulatingUnit()//udg_hero[GetPlayerId(GetOwningPlayer(GetManipulatingUnit())) + 1]
	    local integer i = CorrectPlayer(u)//GetPlayerId(GetOwningPlayer(n)) + 1
	    local item it = GetManipulatedItem()

	    if not( udg_logic[i + 54] ) then
	        set udg_Set_Weapon_Number[i] = udg_Set_Weapon_Number[i] + 1
	        
	        set Event_UnitAddWeapon_Hero = u
	        set Event_UnitAddWeapon_Item = it
	        
	        set Event_UnitAddWeapon_Real = 0.00
	        set Event_UnitAddWeapon_Real = 1.00
	        set Event_UnitAddWeapon_Real = 0.00
	        
	        if not( udg_logic[i + 54] ) and udg_Set_Weapon_Number[i] >= 3 and Multiboard_Condition(i) then
	            set udg_logic[i + 54] = true
	
	            call CreateUltimateWeapon_Delay(u)
        	endif
    	elseif GetInventoryIndexOfItemTypeBJ( u, WeaponPieceSystem_ULTIMATE_WEAPON_ID) > 0 then
        	call AddWeapon(u, it)
	    endif
	    
	    //call AllSetRing( u, 7, it )
	    
	    set it = null
	    set u = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope