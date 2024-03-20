scope HeavyBag initializer init

	globals
		private constant integer ITEM_ID = 'I0CT'
		
		private constant integer ITEM_TO_SPAWN = 'I02U'
		private constant integer COOLDOWN = 5
		
		private constant string ANIMATION = "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageDeathCaster.mdl"
	endglobals
	
	private function condition takes nothing returns boolean
	    return udg_fightmod[3] == false
	endfunction
	
	function Spawn takes nothing returns nothing 
		local integer id = GetHandleId( GetExpiredTimer() )
		local item itemSpawn
	    
	    if udg_fightmod[0] == false then
	    	call DestroyTimer(GetExpiredTimer())
	    	return
	    endif
	    
	    set itemSpawn = CreateItem( ITEM_TO_SPAWN, GetRandomReal(GetRectMinX(udg_Boss_Rect), GetRectMaxX(udg_Boss_Rect)), GetRandomReal(GetRectMinY(udg_Boss_Rect), GetRectMaxY(udg_Boss_Rect)) )
	    call DestroyEffect( AddSpecialEffect( ANIMATION, GetItemX( itemSpawn ), GetItemY( itemSpawn ) ) )
	    
	    set itemSpawn = null
	endfunction 
	
	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		
		call InvokeTimerWithUnit( caster, "heavy_bag", COOLDOWN, true, function Spawn )
		
		set caster = null
	endfunction

	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, function condition, null)
	endfunction

endscope