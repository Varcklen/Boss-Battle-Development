library MagicVaultDeath initializer init //no requires!
	
	globals
		private constant string ANIMATION = "Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl"
	endglobals
	
	private function condition takes nothing returns boolean
		return GetUnitTypeId(GetDyingUnit()) == 'h01W'
	endfunction
	
	private function ReturnToHero takes VaultItem vaultItem returns nothing
		local unit hero = vaultItem.hero
		local item itemStolen = vaultItem.itemStolen
		local integer playerId = GetPlayerId(GetOwningPlayer(hero))
		
		/*call BJDebugMsg("hero: " + GetUnitName(hero))
		call BJDebugMsg("itemStolen: " + GetItemName(itemStolen))*/
		
		call SetItemVisible( itemStolen, true )
		call SetItemPosition( itemStolen, GetUnitX(hero), GetUnitY(hero) )
		if UnitInventoryCount(hero) >= UnitInventorySize(hero) or IsUnitDeadBJ(hero) then
			call SetItemPositionLoc( itemStolen, udg_point[22 + playerId] )
    	else
    		call UnitAddItem(hero, itemStolen)
    	endif
		call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX(hero), GetUnitY(hero) ) )
		
		set hero = null
		set itemStolen = null
	endfunction
	
	private function ReturnItems takes unit caster returns nothing
		local ListInt vaultItems = LoadInteger(udg_hash, GetHandleId(caster), StringHash("boss_mage_vault") )
		local integer i
		local integer iMax
		if vaultItems == null then
			return
		endif
		
		//call BJDebugMsg("size: " + I2S(vaultItems.Size) )
		set i = 0
		set iMax = vaultItems.Size
		loop
			exitwhen i >= iMax
			call ReturnToHero(vaultItems.GetIntegerByIndex(i))
			set i = i + 1
		endloop
		
		call SaveInteger(udg_hash, GetHandleId(caster), StringHash("boss_mage_vault"), 0 )
	endfunction
	
	private function action takes nothing returns nothing
		call ReturnItems(GetDyingUnit())
	endfunction
	
	private function OnRemoveUnit takes unit u returns nothing
    	if GetUnitTypeId(u) == 'h01W' then
    		call ReturnItems(u)
		endif
    endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DEATH )
	    call TriggerAddAction( trig, function action )
	    
	    set trig = null
	endfunction
	
	hook RemoveUnit OnRemoveUnit
	
endlibrary