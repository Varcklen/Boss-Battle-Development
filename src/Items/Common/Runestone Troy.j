scope RunestoneTroy initializer init

	globals
		private constant integer ITEM_ID = 'I0AC'
		
		private constant integer RUNES_TO_CREATE = 5
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleEnd.GetDataUnit("caster")
		local integer index = BattleEnd.GetDataInteger("index")
		local integer i

        set i = 1
        loop
            exitwhen i > RUNES_TO_CREATE
            call CreateItem( 'I03J' + GetRandomInt( 1, 6 ), GetLocationX( udg_point[21 + index] ) + GetRandomReal( -100, 100 ), GetLocationY( udg_point[21 + index] ) + GetRandomReal( -100, 100 ) )
            set i = i + 1
        endloop
	    
	    set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action, function condition, null )
	endfunction
	
endscope

