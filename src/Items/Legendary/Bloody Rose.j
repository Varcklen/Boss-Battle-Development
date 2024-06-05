scope BloodyRose initializer init

    globals
        private constant integer ITEM_ID = 'I012'
        private constant real SHIELD_GAIN = 0.08
    endglobals

    private function AfterDamageEvent_Conditions takes nothing returns boolean
        return udg_IsDamageSpell == false and GetUnitState( AfterAttack.TriggerUnit, UNIT_STATE_MAX_LIFE ) == GetUnitState( AfterAttack.TriggerUnit, UNIT_STATE_LIFE )
    endfunction

    private function AfterDamageEvent takes nothing returns nothing
        local unit caster = AfterAttack.GetDataUnit("caster")
		local real damage = AfterAttack.GetDataReal("damage") * SHIELD_GAIN
        
        call shield(caster, caster, damage )
        
        set caster = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function AfterDamageEvent, function AfterDamageEvent_Conditions, "caster" )
    endfunction

endscope
