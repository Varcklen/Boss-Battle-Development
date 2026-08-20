scope WitchLove initializer init

	globals
		private constant integer ITEM_ID = 'I0E7'
		
		private constant integer UNIT_SPAWN = 'h021'
		
		private constant integer SPAWN_COOLDOWN = 12
		private constant integer SPAWN_RANGE = 250
		private constant string SPAWN_ANIMATION = "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl"
		
		private constant integer STRING_HASH = StringHash( "witch_love" )
		private constant string ANIMATION = "Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl"
	endglobals
	
	private function Spawn takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
		local unit cauldron = LoadUnitHandle( udg_hash, id, StringHash("witch_couldron") )
		local location itemSpawn
		local location unitLoc
		local item itemCreated
		local integer itemType
		
		if cauldron == null or IsUnitDead(cauldron) then
			call FlushChildHashtable( udg_hash, id )
			call DestroyTimer( GetExpiredTimer() )
			return
		endif
		
		set unitLoc = GetUnitLoc(cauldron)
		set itemType = udg_Database_Item_Potion[GetRandomInt(1, udg_Database_NumberItems[9])]
		set itemSpawn = PolarProjectionBJ( unitLoc, SPAWN_RANGE, GetRandomDirectionDeg() )
		set itemCreated = CreateItemLoc(itemType, itemSpawn)
		call DestroyEffect( AddSpecialEffectLoc( SPAWN_ANIMATION, itemSpawn ) )
		
		call RemoveLocation(itemSpawn)
		call RemoveLocation(unitLoc)
		set unitLoc = null
		set itemSpawn = null
		set itemCreated = null
		set cauldron = null
	endfunction
	
	private function WitchLoveEnd takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    local real x = GetRandomReal(GetRectMinX(udg_Boss_Rect), GetRectMaxX(udg_Boss_Rect))
	    local real y = GetRandomReal(GetRectMinY(udg_Boss_Rect), GetRectMaxY(udg_Boss_Rect))
	    local unit cauldron
	    
		set cauldron = CreateUnit( GetOwningPlayer( caster ), UNIT_SPAWN, x, y, 270 )
	    call DestroyEffect( AddSpecialEffect( ANIMATION, x, y ) )
	    call FlushChildHashtable( udg_hash, id )
	    
	    call InvokeTimerWithUnit( cauldron, "witch_couldron", SPAWN_COOLDOWN, true, function Spawn )
	    
	    set caster = null
	    set cauldron = null
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local integer id
		local timer timerUsed
		
		set timerUsed = CreateTimer()
		set id = GetHandleId(timerUsed )

        call SaveUnitHandle( udg_hash, id, STRING_HASH, caster )
        call TimerStart( timerUsed, 0.5, false, function WitchLoveEnd )

    	set caster = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, null, null)
	endfunction

endscope