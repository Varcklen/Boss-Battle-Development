scope IdolOfGreed initializer init

    globals
        private constant integer ITEM_ID = 'I09Q'
        private constant real HEAL_PERCENT = 0.8
    endglobals

    private function AfterDamageEvent takes nothing returns nothing
        local unit caster = AfterAttack.GetDataUnit("caster")
		local real heal = AfterAttack.GetDataReal("damage") * HEAL_PERCENT
		local group heroes = DeathSystem_GetAliveHeroGroupCopy()
		local unit u
		
		loop
			set u = FirstOfGroup(heroes)
			exitwhen u == null
			call healst(caster, u, heal )
			call GroupRemoveUnit(heroes, u)
        endloop
        
        call DestroyGroup(heroes)
        set heroes = null
        set u = null
        set caster = null
    endfunction
    
    //===========================================================================
    private function OnBeforeAttack_Conditions takes nothing returns boolean
    	return IsBoss(BeforeAttack.TargetUnit)
    endfunction
    
    private function OnBeforeAttack takes nothing returns nothing
        set udg_DamageEventType = udg_DamageTypeIgnore
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function AfterDamageEvent, null, "caster" )
        call RegisterDuplicatableItemTypeCustom( ITEM_ID, BeforeAttack, function OnBeforeAttack, function OnBeforeAttack_Conditions, "caster" )
    endfunction

endscope
