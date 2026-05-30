scope BloodyCoin initializer init

	globals
		private constant integer ITEM_ID = 'I074'
		private constant integer ABILITY_ID = 'A1IA'
		
		private constant integer HEAL = 500
		private constant integer GOLD_USE = 35
		
		private constant integer HASH_KEY = StringHash("bloody_coin")
	endglobals

	private function OnKill_Condition takes nothing returns boolean
		return udg_fightmod[3] == false and combat( UnitDied.TriggerUnit, false, 0 ) and IsUnitEnemy(UnitDied.TargetUnit, GetOwningPlayer(UnitDied.TriggerUnit))  
	endfunction

	private function OnKill takes nothing returns nothing
		local unit caster = UnitDied.GetDataUnit("killer")
		local integer id = GetHandleId(caster)
		local integer stash = LoadInteger(udg_hash, id, HASH_KEY)
		local item itemUsed

		if stash != 0 then
	        call moneyst( caster, stash )
	        call SaveInteger(udg_hash, id, HASH_KEY, 0 )
	        set itemUsed = GetItemOfTypeFromUnitBJ( caster, ITEM_ID )
	        call BlzSetItemExtendedTooltip( itemUsed, words( caster, BlzGetItemDescription(itemUsed), "|cFF959697(", ")|r", I2S(0) ) )
        endif
        
        set itemUsed = null
        set caster = null
	endfunction
	
	//===========================================================================
	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID
	endfunction
	
	private function Use takes unit caster, unit target returns nothing
		local integer id = GetHandleId(caster)
		local integer stash = LoadInteger(udg_hash, id, HASH_KEY)
		local player owner = LoadPlayerHandle(udg_hash, id, StringHash("main_owner") )
		local integer moneyToBurn
		local item itemUsed
		
		call healst(caster, target, HEAL)
		
		if udg_fightmod[3] == false and combat( caster, false, 0 ) then
			set moneyToBurn = IMinBJ(GOLD_USE, GetPlayerState( owner, PLAYER_STATE_RESOURCE_GOLD ) )
	        call SetPlayerState( owner, PLAYER_STATE_RESOURCE_GOLD, IMaxBJ( 0, GetPlayerState( owner, PLAYER_STATE_RESOURCE_GOLD ) - moneyToBurn ) )
	        set stash = stash + moneyToBurn
	        call SaveInteger(udg_hash, id, HASH_KEY, stash )
	        set itemUsed = GetItemOfTypeFromUnitBJ( caster, ITEM_ID )
	        call BlzSetItemExtendedTooltip( itemUsed, words( caster, BlzGetItemDescription(itemUsed), "|cFF959697(", ")|r", I2S(stash) ) )
	   	endif

	   	set itemUsed = null
	    set owner = null
	endfunction

	private function action takes nothing returns nothing
	    local integer cyclA = 1
	    local integer cyclAEnd 
	    local unit caster
	    local unit target
	    
	    if CastLogic() then
	        set caster = udg_Caster
	        set target = udg_Target
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        set target = randomtarget( caster, 900, "ally", 0, 0, 0 )
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	        if target == null then
	            set caster = null
	            return
	        endif
	    else
	        set caster = GetSpellAbilityUnit()
	        set target = GetSpellTargetUnit()
	    endif 
	    
	    call DestroyEffect( AddSpecialEffectTarget( "Blood Explosion.mdx", target, "origin" ) )
	    set cyclAEnd = eyest( caster )
	    loop
	        exitwhen cyclA > cyclAEnd
	        call Use(caster, target)
	        set cyclA = cyclA + 1
	    endloop
	    
	    set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, UnitDied, function OnKill, function OnKill_Condition, "killer" )
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	endfunction

endscope