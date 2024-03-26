scope AncientOctopus initializer init

	globals
		private constant integer ITEM_ID = 'I0C9'
		
		private constant integer TENTACLES_PER_LEVEL = 2
		
		private constant integer STRING_HASH = StringHash( "ancient_octopus" )
		
		private constant integer SUMMON_ID = 'n03F'
		private constant string ANIMATION = "Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl"
	endglobals
	
	private function Summon takes unit owner returns nothing
		local real x = GetRandomReal(GetRectMinX(udg_Boss_Rect), GetRectMaxX(udg_Boss_Rect))
		local real y = GetRandomReal(GetRectMinY(udg_Boss_Rect), GetRectMaxY(udg_Boss_Rect))
		
		call CreateUnit( GetOwningPlayer( owner ), SUMMON_ID, x, y, 270 )
        call DestroyEffect(AddSpecialEffect( ANIMATION, x, y ) )
	endfunction
	
	private function OctopusEnd takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    local integer i = 1
	    local integer iEnd = LoadInteger( udg_hash, id, STRING_HASH )
	    
	    loop
	        exitwhen i > iEnd
	        call Summon(caster)
	        set i = i + 1
	    endloop
	    call FlushChildHashtable( udg_hash, id )
	    
	    set caster = null
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local integer heroLevel = GetHeroLevel(caster)
		local integer tentacles = heroLevel * TENTACLES_PER_LEVEL
		local integer id
		local timer timerUsed
		
		set timerUsed = CreateTimer()
        set id = GetHandleId( timerUsed ) 
        call SaveUnitHandle( udg_hash, id, STRING_HASH, caster )
        call SaveInteger( udg_hash, id, STRING_HASH, tentacles )
        call TimerStart( timerUsed, 0.5, false, function OctopusEnd )
    	
        set caster = null
        set timerUsed = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, null, null)
	endfunction

endscope