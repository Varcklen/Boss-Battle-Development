library WrathBarEffect initializer init requires WrathBarVisual, SpellPower

    public struct Penalty
        readonly real value
        readonly integer mode
        
        public static method create takes integer mode, real value returns Penalty
            local Penalty this = Penalty.allocate()
            set .value = value
            set .mode = mode
            return this
        endmethod
    endstruct

    globals
        private constant integer KEY_VALUE = StringHash("wrath_bar_value")
        private constant integer KEY_DAMAGE_BUFFER = StringHash("wrath_bar_damage_buffer")
        private constant integer KEY_PENALTY = StringHash("wrath_bar_penalty")
        private constant integer KEY_SLOW_CHECK_AMOUNT = StringHash("wrath_bar_slow_check_amount")
        private constant integer KEY_SLOW_CHECK_COOLDOWN = StringHash("wrath_bar_slow_check_cooldown")
        
        public Penalty NORMAL_PENALTY
        public Penalty SLOW_PENALTY
        public Penalty STUN_PENALTY
        
        private constant integer ABILITY_ID = 'A1GR'
    endglobals
    
    private function init takes nothing returns nothing
        set NORMAL_PENALTY = Penalty.create(0, 1)
        set SLOW_PENALTY = Penalty.create(1, 0.25)
        set STUN_PENALTY = Penalty.create(2, 0)
    endfunction

    //Penalty
    public function GetPenalty takes unit hero returns Penalty
        local integer keyValue = GetHandleId( hero )
        if HaveSavedInteger(udg_hash, keyValue, KEY_PENALTY) == false then
            return NORMAL_PENALTY
        endif
        return LoadInteger(udg_hash, keyValue, KEY_PENALTY )
    endfunction
    
    public function SetPenalty takes unit hero, Penalty newPenalty returns nothing
        call SaveInteger(udg_hash, GetHandleId( hero ), KEY_PENALTY, newPenalty )
    endfunction

    //Value
    private function ValueCheck takes real newValue returns real
        if newValue < 0 then
            set newValue = 0
        elseif newValue > 100 then
            set newValue = 100
        endif
        return newValue
    endfunction

    public function GetValue takes unit hero returns real
        return LoadReal(udg_hash, GetHandleId( hero ), KEY_VALUE )
    endfunction
    
    globals
    	private constant integer KEY_IS_ABOVE_REQUIRE = StringHash("wrath_bar_is_above_fifty")
    	private constant integer CHARGE_REQUIRE = 50
    	private constant integer ABILITY_TO_CHECK = 'A1GT'
    endglobals
    
    private function ChangeValue takes unit hero, boolean isEnable returns nothing
    	local integer id = GetHandleId( hero )
    	local integer i
    	local real areaRange
    	local ability abilityToUse
    	
        if GetUnitAbilityLevel( hero, ABILITY_TO_CHECK ) == 0 then
        	return
        endif
    
    	call SaveBoolean(udg_hash, id, KEY_IS_ABOVE_REQUIRE, isEnable)
		set abilityToUse = BlzGetUnitAbility(hero, ABILITY_TO_CHECK)
		//set areaRange = BlzGetAbilityRealLevelField( abilityToUse, ABILITY_RLF_AREA_OF_EFFECT, 0 )
		if isEnable then
			set areaRange = 600
		else
			set areaRange = 300
		endif
		set i = 0
		loop
			exitwhen i > 4
			call BlzSetAbilityRealLevelFieldBJ( abilityToUse, ABILITY_RLF_AREA_OF_EFFECT, i, areaRange )
			set i = i + 1
		endloop
		
		set abilityToUse = null
    endfunction
    
    private function CheckValue takes unit hero, real newValue returns nothing
    	local boolean isCheckActive = LoadBoolean(udg_hash, GetHandleId( hero ), KEY_IS_ABOVE_REQUIRE)

    	if newValue >= CHARGE_REQUIRE and isCheckActive == false then
    		call ChangeValue(hero, true)
    	elseif newValue < CHARGE_REQUIRE and isCheckActive then
    		call ChangeValue(hero, false)
    	endif
    endfunction
    
    globals
    	private constant integer KEY_SLOW_CHOPPED_AMOUNT = StringHash("wrath_bar_chopped_amount")
    endglobals
    
    private function GetAttackValue takes unit hero, real increment returns integer
    	local integer id = GetHandleId( hero )
    	local real incrementAttack
        local integer incrementInt
        local real choppedAttack
        
    	set choppedAttack = LoadReal(udg_hash, id, KEY_SLOW_CHOPPED_AMOUNT )
        set incrementAttack = increment + choppedAttack
        set incrementInt = R2I(incrementAttack)
        set choppedAttack = incrementAttack - incrementInt
        
        call SaveReal(udg_hash, id, KEY_SLOW_CHOPPED_AMOUNT, choppedAttack)
        
    	return incrementInt
    endfunction

    public function AddValue takes unit hero, real percToAdd returns nothing
        local real newValue
        local real oldValue
        local real increment
        local integer incrementInt
        local integer id = GetHandleId( hero )
        local player owner = LoadPlayerHandle(udg_hash, id, StringHash("main_owner") )
        
        if GetUnitAbilityLevel( hero, ABILITY_ID ) == 0 then
        	set owner = null
        	return
        endif
        
        set oldValue = GetValue(hero)
        set newValue = ValueCheck( oldValue + percToAdd )
        set increment =  newValue - oldValue
        
        set incrementInt = GetAttackValue(hero, increment)
        
        call spdst( hero, increment )
        call BlzSetUnitBaseDamage( hero, BlzGetUnitBaseDamage(hero, 0) + incrementInt, 0 )
        
        call SaveReal(udg_hash, id, KEY_VALUE, newValue )
        call WrathBarVisual_SetValue(owner, R2I( newValue ) )
        
        call CheckValue(hero, newValue)
        
        set owner = null
    endfunction
    
    //Damage Buffer
    public function GetDamageBuffer takes unit hero returns real
        return LoadReal(udg_hash, GetHandleId( hero ), KEY_DAMAGE_BUFFER )
    endfunction

    public function SetDamageBuffer takes unit hero, real newValue returns nothing
        call SaveReal(udg_hash, GetHandleId( hero ), KEY_DAMAGE_BUFFER, newValue )
    endfunction
    
    //Slow Check Amount
    public function GetSlowCheckAmount takes unit hero returns real
        return LoadReal(udg_hash, GetHandleId( hero ), KEY_SLOW_CHECK_AMOUNT )
    endfunction

    public function SetSlowCheckAmount takes unit hero, real newValue returns nothing
        call SaveReal(udg_hash, GetHandleId( hero ), KEY_SLOW_CHECK_AMOUNT, newValue )
    endfunction
    
    //Slow Check Cooldown
    public function GetSlowCheckCooldown takes unit hero returns boolean
        return LoadBoolean(udg_hash, GetHandleId( hero ), KEY_SLOW_CHECK_COOLDOWN )
    endfunction

    public function SetSlowCheckCooldown takes unit hero, boolean newValue returns nothing
        call SaveBoolean(udg_hash, GetHandleId( hero ), KEY_SLOW_CHECK_COOLDOWN, newValue )
    endfunction
endlibrary