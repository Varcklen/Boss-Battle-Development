scope BlessTeamWork initializer init

	globals
		private trigger Trigger = null
		
		private constant integer EFFECT = 'A1DK'
        private constant integer BUFF = 'B0AD'
        private constant integer ID_ARMOR_BONUS = 'A1DL'
        
        private constant integer AREA = 300
        private constant real MAGIC_RESISTANCE_BONUS = -0.05
        
        private real array Magic_Resistance[PLAYERS_LIMIT_ARRAYS]
        private boolean isActive = false
	endglobals
    
    private function Use takes unit hero returns nothing
        local group g = CreateGroup()
        local unit u
        local integer i = 0
        
        call GroupEnumUnitsInRange( g, GetUnitX( hero ), GetUnitY( hero ), AREA, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( hero, u, "ally" ) and IsUnitType( u, UNIT_TYPE_HERO ) and hero != u then
                set i = i + 1
            endif
            call GroupRemoveUnit(g,u)
        endloop
        
        set i = IMinBJ(i, 3)
        if i > 0 then
            call UnitAddAbility(hero, EFFECT)
            call UnitAddAbility(hero, ID_ARMOR_BONUS)
            call SetUnitAbilityLevel( hero, ID_ARMOR_BONUS, i )
        else
            call UnitRemoveAbility(hero, EFFECT)
            call UnitRemoveAbility(hero, BUFF)
            call UnitRemoveAbility(hero, ID_ARMOR_BONUS)
        endif
        set Magic_Resistance[GetUnitUserData(hero)] = i*MAGIC_RESISTANCE_BONUS
        
        call DestroyGroup( g )
        set u = null
        set g = null
        set hero = null
    endfunction
    
    private function RivalryCheck takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer( ) )
        local unit hero = LoadUnitHandle( udg_hash, id, StringHash( "bless_teamwork" ) )        
        
        if isActive and hero == null then
            call DestroyTimer( GetExpiredTimer() )
        elseif IsUnitAlive(hero) then
            call Use(hero)
        endif
        
        set hero = null
    endfunction

    private function Mode_Awake takes nothing returns nothing
        local integer i = 1

        loop
            exitwhen i > PLAYERS_LIMIT
            if udg_hero[i] != null then
                call InvokeTimerWithUnit(udg_hero[i], "bless_teamwork", 2, true, function RivalryCheck )
            endif
            set i = i + 1
        endloop
    endfunction
    
    private function Mode_Disable takes nothing returns nothing
    	local integer i = 1

        loop
            exitwhen i > PLAYERS_LIMIT
            if udg_hero[i] != null then
                call UnitRemoveAbility(udg_hero[i], EFFECT)
	            call UnitRemoveAbility(udg_hero[i], BUFF)
	            call UnitRemoveAbility(udg_hero[i], ID_ARMOR_BONUS)
	        	set Magic_Resistance[i] = 0
            endif
            set i = i + 1
        endloop
    endfunction

	//===========================================================================
    private function OnDamageChange_Conditions takes nothing returns boolean
        return IsUnitHasAbility(udg_DamageEventTarget, EFFECT) and udg_IsDamageSpell == true
    endfunction

    private function OnDamageChange takes nothing returns nothing
        local unit hero = udg_DamageEventTarget

        set udg_DamageEventAmount = udg_DamageEventAmount + (Magic_Resistance[GetUnitUserData(hero)]*Event_OnDamageChange_StaticDamage)
        
        set hero = null
    endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		set isActive = true
		call Mode_Awake()
		call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
    	set isActive = false
    	call Mode_Disable()
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "Event_OnDamageChange_Real", function OnDamageChange, function OnDamageChange_Conditions )
		call DisableTrigger( Trigger )
	endfunction

endscope