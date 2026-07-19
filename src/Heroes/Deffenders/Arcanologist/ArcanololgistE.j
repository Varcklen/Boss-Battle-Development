scope ArcanologistE initializer init

    globals
        private constant integer ID_ABILITY = 'A1HG'
        
        private constant real DAMAGE_REDUCE_FIRST_LEVEL = 0.05
        private constant real DAMAGE_REDUCE_LEVEL_BONUS = 0.05
        
        private constant real DAMAGE_REDUCE_MANA_THRES = 0.30
        private constant real DAMAGE_REDUCE_MANA_REDIR = 0.40
        
    endglobals
    
    private function damageCondition takes nothing returns boolean
        return IsUnitHasAbility( udg_DamageEventTarget, ID_ABILITY)
    endfunction
    
    private function damageAction takes nothing returns nothing
    	local unit u = udg_DamageEventTarget
    	local integer lvl = GetUnitAbilityLevel(u, ID_ABILITY)
    	local real reduce = DAMAGE_REDUCE_FIRST_LEVEL + DAMAGE_REDUCE_LEVEL_BONUS * lvl
    	local real mp = GetUnitState( u, UNIT_STATE_MANA) / RMaxBJ(1,GetUnitState( u, UNIT_STATE_MAX_MANA))
    	
    	if mp >= DAMAGE_REDUCE_MANA_THRES then
        	call SetUnitState( u, UNIT_STATE_MANA, GetUnitState( u, UNIT_STATE_MANA) - udg_DamageEventAmount * DAMAGE_REDUCE_MANA_REDIR )
    		set reduce = reduce + DAMAGE_REDUCE_MANA_REDIR
    	endif
    	
        set udg_DamageEventAmount = udg_DamageEventAmount * (1 - reduce)
        set u = null
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        call CreateEventTrigger( "Event_OnDamageChange_Real", function damageAction, function damageCondition )
    endfunction

endscope

