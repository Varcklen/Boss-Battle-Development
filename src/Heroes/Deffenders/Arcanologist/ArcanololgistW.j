scope ArcanologistW initializer init

    globals
        private constant integer ID_ABILITY = 'A1HF'
        
        private constant integer DURATION_FIRST_LEVEL = 15
        private constant integer DURATION_LEVEL_BONUS = 0
        private constant integer TICK = 1
        
        private constant integer MANA = 8
        private constant integer MANA_LEVEL = 2
        
        private constant integer DAMAGE = 13
        private constant integer DAMAGE_LEVEL = 2
        
        private constant integer EFFECT = 'A1HI'
        private constant integer BUFF = 'B0AT'
        
        private constant integer SIGNATURE_AMOUNT = 2 // +1
        
		private integer array ID_SIGNATURE_ITEMS[SIGNATURE_AMOUNT]
        private boolean ACQUIRED = false
        
        private constant integer LEVEL_REQIURED = 6
    
        private constant string RESEARCH_ANIMATION = "Abilities\\Spells\\Human\\DispelMagic\\DispelMagicTarget.mdl"
        
    	//private constant string ANIMATION = "Units\\NightElf\\Wisp\\WispExplode.mdl"
        
		trigger ArcanologistW = null
    endglobals

    private function condition takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY
    endfunction

    private function tick takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit caster = LoadUnitHandle(udg_hash, id, StringHash("arcnw") )
        local integer damage = LoadInteger(udg_hash, id, StringHash("arcnw_damage") )
        local integer mana = LoadInteger(udg_hash, id, StringHash("arcnw_mana") )

        if IsUnitAlive(caster) and IsUnitHasAbility(caster, EFFECT) then
            call manast(caster, null, mana )
            call GroupAoE( caster, 0, 0, damage, 300, "enemy", null, null )
        else
            call UnitRemoveAbility(caster, EFFECT)
            call UnitRemoveAbility(caster, BUFF)
            call FlushChildHashtable( udg_hash, id )
        endif
        
        set caster = null
    endfunction

    private function action takes nothing returns nothing
        local integer lvl
        local unit caster
        local real duration
        local integer id
        local integer damage
        local integer mana
        
        if CastLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
            set duration = udg_Time
        elseif RandomLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
            set duration = DURATION_FIRST_LEVEL + ( lvl * DURATION_LEVEL_BONUS)
        else
            set caster = GetSpellAbilityUnit()
            set lvl = GetUnitAbilityLevel(caster, ID_ABILITY)
            set duration = DURATION_FIRST_LEVEL + ( lvl * DURATION_LEVEL_BONUS)
        endif
    	set duration = timebonus(caster, duration)
    	set damage = DAMAGE + DAMAGE_LEVEL * lvl
    	set mana = MANA + MANA_LEVEL * lvl
        
        call bufallst(caster, caster, EFFECT, 0, 0, 0, 0, BUFF, "arcnwb", duration)
        
        set id = InvokeTimerWithUnit(caster, "arcnw", TICK, true, function tick )
        call SaveUnitHandle( udg_hash, id, StringHash("arcnw"), caster )
        call SaveInteger(udg_hash, id, StringHash("arcnw_damage"), damage )
        call SaveInteger(udg_hash, id, StringHash("arcnw_mana"), mana )
        
        set caster = null
    endfunction
    
    //---------------------------------------------------------------
    
    private function DeleteBuff_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT) > 0
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        local unit hero = Event_DeleteBuff_Unit

        call UnitRemoveAbility( hero, EFFECT )
        call UnitRemoveAbility( hero, BUFF )
        
        set hero = null
    endfunction
    
    //---------------------------------------------------------------
    
    private function learnCondition takes nothing returns boolean
    	return not(ACQUIRED) and GetHeroLevel(GetLevelingUnit()) >= LEVEL_REQIURED
	endfunction

	private function learnAction takes nothing returns nothing
		local unit u = GetLevelingUnit()
		local integer rng = GetRandomInt(0, SIGNATURE_AMOUNT)
    	local integer k = GetPlayerId( GetOwningPlayer( u ) ) + 1
			
		set ACQUIRED = true
		if UnitInventoryCount(u) < 6 then
            call UnitAddItemById(u, ID_SIGNATURE_ITEMS[rng])
	        call DestroyEffect( AddSpecialEffect( RESEARCH_ANIMATION, GetUnitX( u ), GetUnitY( u ) ) )
	    else
	        set bj_lastCreatedItem = CreateItem(ID_SIGNATURE_ITEMS[rng], GetLocationX(udg_point[21+k]), GetLocationY(udg_point[21+k]))
	        call DestroyEffect( AddSpecialEffect( RESEARCH_ANIMATION, GetItemX( bj_lastCreatedItem ), GetItemY( bj_lastCreatedItem ) ) )
	        call DisplayTimedTextToPlayer( GetOwningPlayer(u), 0, 0, 10, "The artifact was moved to the |cffffcc00preparation room|r." )
	    endif
			
	    set u = null
	endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
    	set ID_SIGNATURE_ITEMS[0] = 'I0HP'
    	set ID_SIGNATURE_ITEMS[1] = 'I0HQ'
    	set ID_SIGNATURE_ITEMS[2] = 'I0HS'
		call CreateNativeEvent( EVENT_PLAYER_HERO_LEVEL, function learnAction, function learnCondition )
		
		set ArcanologistW = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
        call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
    endfunction

endscope

