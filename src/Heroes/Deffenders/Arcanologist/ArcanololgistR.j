scope ArcanologistR initializer init

    globals
        private constant integer ID_ABILITY = 'A1HH'
        
        private constant integer DURATION = 19
        //private constant integer DURATION_FIRST_LEVEL = 19
        //private constant integer DURATION_LEVEL_BONUS = 0
        
        private constant integer STAT_FLAT_FIRST_LEVEL = 2
        private constant integer STAT_FLAT_LEVEL_BONUS = 1
        
        private constant integer TICK = 1
        
        private constant real STAT_MULT_FIRST_LEVEL = 0.10
        private constant real STAT_MULT_LEVEL_BONUS = 0.05
        
        private constant integer EFFECT = 'A1HJ'
        private constant integer BUFF = 'B0AU'
    
        //private constant string ANIMATION = "AncientExplode1.mdx"
        
		trigger ArcanologistR = null
    endglobals

    private function condition takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY
    endfunction

    private function tick takes nothing returns nothing
    	local integer id = GetHandleId( GetExpiredTimer() )
    	local unit u = LoadUnitHandle( udg_hash, id, StringHash( "arcnr" ) )
	    local integer idx = GetHandleId( u )
    	local integer i = 0
    	local integer eff
    	local real hp = GetUnitState( u, UNIT_STATE_LIFE) / RMaxBJ(0,GetUnitState( u, UNIT_STATE_MAX_LIFE))
    	local real mp = GetUnitState( u, UNIT_STATE_MANA) / RMaxBJ(0,GetUnitState( u, UNIT_STATE_MAX_MANA))
    
    	if GetUnitState( u, UNIT_STATE_LIFE) > 0.405 then
    		loop
	        	set eff = LoadInteger( udg_hash, idx, StringHash( "arcnr"+I2S(i) ) )
	        	call SetHeroStat(u, i, GetHeroStatBJ(i, u, false) - eff)
	        	call RemoveSavedInteger( udg_hash, idx, StringHash( "arcnr"+I2S(i) ) )
	        	call RemoveSavedInteger( udg_hash, idx, StringHash( "arcnrf"+I2S(i) ) )
	        	set i = i + 1
	        	exitwhen i>2
	        endloop
        	call UnitRemoveAbility( u, EFFECT )
        	call UnitRemoveAbility( u, BUFF )
	    endif
        call SetUnitState( u, UNIT_STATE_LIFE, GetUnitState( u, UNIT_STATE_MAX_LIFE) * hp)
        call SetUnitState( u, UNIT_STATE_MANA, GetUnitState( u, UNIT_STATE_MAX_MANA) * mp)
	    call FlushChildHashtable( udg_hash, id )
	    
	    set u = null
    endfunction

    private function action takes nothing returns nothing
        local integer lvl
        local unit caster
        local unit u
        local real duration
        local real mult
        local integer add
        local integer change
        local integer base
        local integer effsum
        local integer i = 0
        local group g
        local integer id
        local integer idx
        local integer array eff
        
        if CastLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
            set duration = udg_Time
        elseif RandomLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
            set duration = DURATION//_FIRST_LEVEL + ( lvl * DURATION_LEVEL_BONUS)
        else
            set caster = GetSpellAbilityUnit()
            set lvl = GetUnitAbilityLevel(caster, ID_ABILITY)
            set duration = DURATION//_FIRST_LEVEL + ( lvl * DURATION_LEVEL_BONUS)
        endif
        set add = STAT_FLAT_FIRST_LEVEL + lvl * STAT_FLAT_LEVEL_BONUS
        set mult = STAT_MULT_FIRST_LEVEL + lvl * STAT_MULT_LEVEL_BONUS
    	set duration = timebonus(caster, duration)
        
        loop
        	set eff[i] = 0
        	set i = i + 1
        	exitwhen i>2
        endloop
        
    	set g = DeathSystem_GetAliveHeroGroupCopy()
        set u = GroupPickRandomUnit(g)
        if u == null then
        else
	        loop
	        	set u = FirstOfGroup(g)
	        	exitwhen u==null
	        	set i = 0
	        	loop
	        		set eff[i]=IMaxBJ(eff[i], GetHeroStatBJ(i, u, true))
	        		set i = i + 1
	        		exitwhen i>2
	        	endloop
	    		call GroupRemoveUnit( g, u )		
	        endloop
	        //-----
	        set g = DeathSystem_GetAliveHeroGroupCopy()
	        set i = 0
	        loop
	        	set u = GroupPickRandomUnit(g)
	        	set idx = GetHandleId( u )
	        	//call bufallst(caster, u, EFFECT, 0, 0, 0, 0, BUFF, ("arcnrb"+I2S(i)), duration)
	        	set base = LoadInteger( udg_hash, idx, StringHash( "arcnrf"+I2S(i) ) ) + add
	        	set effsum = LoadInteger( udg_hash, idx, StringHash( "arcnr"+I2S(i) ) )
	        	
	        	set change = R2I(eff[i] * mult)
	        	call SetHeroStat(u, i, GetHeroStatBJ(i, u, false) + change - effsum + base)
	        	call UnitAddAbility( u, EFFECT )
	        	
	        	set effsum = base + change
	        	call SaveInteger( udg_hash, idx, StringHash( "arcnr"+I2S(i) ), effsum )
	        	call SaveInteger( udg_hash, idx, StringHash( "arcnrf"+I2S(i) ), base ) 
	        
	        	set id = InvokeTimerWithUnit(caster, ("arcnr"), duration, false, function tick )
	        	call SaveUnitHandle( udg_hash, id, StringHash("arcnr"), caster ) 
	        	
	        	set i = i + 1
	        	exitwhen i>2
	        endloop
	    endif
        //-----
        set caster = null
    	call GroupClear( g )
    	call DestroyGroup( g )
    	set g = null
    	set u = null
    endfunction
    
    
    private function DeleteBuff_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT) > 0
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        local unit u = Event_DeleteBuff_Unit
	    local integer idx = GetHandleId( u )
    	local integer i = 0
    	local integer eff
    	local real hp = GetUnitState( u, UNIT_STATE_LIFE) / RMaxBJ(0,GetUnitState( u, UNIT_STATE_MAX_LIFE))
    	local real mp = GetUnitState( u, UNIT_STATE_MANA) / RMaxBJ(0,GetUnitState( u, UNIT_STATE_MAX_MANA))
    
    	//if GetUnitState( u, UNIT_STATE_LIFE) > 0.405 then
    	loop
	        set eff = LoadInteger( udg_hash, idx, StringHash( "arcnr"+I2S(i) ) )
	        call SetHeroStat(u, i, GetHeroStatBJ(i, u, false) - eff)
	        call RemoveSavedInteger( udg_hash, idx, StringHash( "arcnr"+I2S(i) ) )
	        call RemoveSavedInteger( udg_hash, idx, StringHash( "arcnrf"+I2S(i) ) )
	        set i = i + 1
	        exitwhen i>2
		endloop
        call SetUnitState( u, UNIT_STATE_LIFE, GetUnitState( u, UNIT_STATE_MAX_LIFE) * hp)
        call SetUnitState( u, UNIT_STATE_MANA, GetUnitState( u, UNIT_STATE_MAX_MANA) * mp)
	   //endif

        call UnitRemoveAbility( u, EFFECT )
        call UnitRemoveAbility( u, BUFF )
        
        set u = null
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
		set ArcanologistR = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
        call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
    endfunction

endscope

