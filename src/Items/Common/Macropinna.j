scope Macropinna initializer init

	globals
		private constant integer ITEM_ID = 'I07F'
		private constant integer STAT_GAIN = 1
		private constant integer MANA_SPENT_REQUIRE = 500
		private constant string ANIMATION = "Abilities\\Spells\\Human\\Invisibility\\InvisibilityTarget.mdl"
		private constant integer HASH_KEY = StringHash("macropinna")
	endglobals

	private function condition takes nothing returns boolean
		/*call BJDebugMsg("TriggerUnit: " + GetUnitName(ManaSpent.GetDataUnit("unit")) )
		if combat( ManaSpent.GetDataUnit("unit"), false, 0 ) then
			call BJDebugMsg("combat( ..., false, 0 ) ")
		endif
		if ExtraArenaGeneral_IsPvPActive() == false then 
			call BJDebugMsg("IsPvPActive: false")
		endif*/
	
	    return UnitHasItemOfTypeBJ(ManaSpent.GetDataUnit("unit"), ITEM_ID) and combat( ManaSpent.GetDataUnit("unit"), false, 0 ) and ExtraArenaGeneral_IsPvPActive() == false 
	endfunction
	
	private function Gain takes unit caster returns nothing
		call statst( caster, STAT_GAIN, STAT_GAIN, STAT_GAIN, 272, true )
	    call textst( "|c00808080 +" + I2S(STAT_GAIN) + " stats|r", caster, 64, GetRandomReal( 45, 135 ), 8, 1.5 )
        call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX( caster ), GetUnitY( caster ) ) )
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster = ManaSpent.GetDataUnit("unit")
	    local item itemUsed = Trigger_GetItemUsed()
	    local integer id = GetHandleId(itemUsed)
	    local integer counter = LoadInteger(udg_hash, id, HASH_KEY)
	    local integer manaSpent = ManaSpent.GetDataInteger("amount") + counter
	
		//call BJDebugMsg("manaSpent: " + I2S(manaSpent))
		if counter == manaSpent then
			set itemUsed = null
	    	set caster = null
			return
		endif
		
	    if manaSpent >= MANA_SPENT_REQUIRE then
	    	set manaSpent = manaSpent - MANA_SPENT_REQUIRE
	    	call Gain(caster)
	    endif
	    call SaveInteger(udg_hash, id, HASH_KEY, manaSpent)
	    
	    set itemUsed = null
	    set caster = null
	endfunction
	
	//===========================================================================
	private function OnBattleStart takes nothing returns nothing
		local item itemUsed = Trigger_GetItemUsed()
	    local integer id = GetHandleId(itemUsed)
	    
	    call SaveInteger(udg_hash, id, HASH_KEY, 0)
		
    	set itemUsed = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    //call RegisterDuplicatableItemTypeCustom( ITEM_ID, ManaSpent, function action, function condition, null )
	    call ManaSpent.AddListener(function action, function condition)
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function OnBattleStart, null, null)
	endfunction

endscope