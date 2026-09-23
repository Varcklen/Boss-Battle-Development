library AirTotemDeath initializer init //no requires!
	
	globals
		private constant string ANIMATION = "Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl"
	endglobals
	
	private function condition takes nothing returns boolean
		return GetUnitTypeId(GetDyingUnit()) == 'o003'
	endfunction
	
	private function ReturnToHero takes unit hero, item itemStolen returns nothing
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
		local integer id = GetHandleId(caster)
		local unit hero = LoadUnitHandle(udg_hash, id, StringHash("air_totem_target") )
		local item itemStolen

		if hero == null then
			return
		endif
		set itemStolen = LoadItemHandle(udg_hash, id, StringHash("air_totem_item") ) 
		call ReturnToHero(hero, itemStolen)
		
		call SaveUnitHandle(udg_hash, id, StringHash("air_totem_target"), null )
		call SaveItemHandle(udg_hash, id, StringHash("air_totem_item"), null )
		
		set itemStolen = null
		set hero = null
	endfunction
	
	private function action takes nothing returns nothing
		call ReturnItems(GetDyingUnit())
	endfunction
	
	private function OnRemoveUnit takes unit u returns nothing
    	if GetUnitTypeId(u) == 'o003' then
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