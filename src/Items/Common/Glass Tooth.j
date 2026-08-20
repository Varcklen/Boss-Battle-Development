scope GlassTooth initializer init

	globals
		private constant integer ITEM_ID = 'I0A4'
		private constant integer EFFECT_ID = 'A0XG'
		private constant integer BUFF_ID = 'B05K'
		
		private constant integer DURATION = 20
		private constant integer ITEMS_TO_CREATE = 2
		private constant integer SPAWN_RANGE = 250
		
		private constant string SPAWN_ANIMATION = "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl"
		private constant string ANIMATION ="Abilities\\Spells\\Items\\AIma\\AImaTarget.mdl"
	endglobals
	
	private function PotionSpawn takes unit caster returns nothing
		local integer i 
		local location itemSpawn
		local location unitLoc
		local item itemCreated
		local integer itemType

		set unitLoc = GetUnitLoc(caster)
		set i = 1
		loop
			exitwhen i > ITEMS_TO_CREATE
			set itemType = udg_Database_Item_Potion[GetRandomInt(1, udg_Database_NumberItems[9])]
			set itemSpawn = PolarProjectionBJ( unitLoc, SPAWN_RANGE, GetRandomDirectionDeg() )
			set itemCreated = CreateItemLoc(itemType, itemSpawn)
			call DestroyEffect( AddSpecialEffectLoc( SPAWN_ANIMATION, itemSpawn ) )
			
			call RemoveLocation(itemSpawn)
			set i = i + 1
		endloop
		
		call RemoveLocation(unitLoc)
		set unitLoc = null
		set itemSpawn = null
		set itemCreated = null
	endfunction

    private function End takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "glass_tooth" ) )
	    
	    if IsUnitAlive(caster) and GetUnitAbilityLevel( caster, EFFECT_ID) > 0 then
	        call DestroyEffect( AddSpecialEffectTarget(ANIMATION, caster, "origin" ) )
	        call healst( caster, null, GetUnitState( caster, UNIT_STATE_MAX_LIFE) )
	        call manast( caster, null, GetUnitState( caster, UNIT_STATE_MAX_MANA) )
	        call PotionSpawn(caster)
	    endif 
	    call UnitRemoveAbility( caster, EFFECT_ID )
	    call UnitRemoveAbility( caster, BUFF_ID )
	    call FlushChildHashtable( udg_hash, id )
    endfunction
    
    private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local integer id
		
		call UnitAddAbility( caster, EFFECT_ID )
		
		call InvokeTimerWithUnit( caster, "glass_tooth", DURATION, false, function End )
		
    	set caster = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, null, null)
	endfunction
endscope