scope RoyalOnyx initializer init

	globals
		private constant integer ITEM_ID = 'I040'
	endglobals
	
	private function condition takes nothing returns boolean
        return GetItemTypeId(GetManipulatedItem()) ==  ITEM_ID and combat( GetManipulatingUnit(), true, 0 ) and udg_fightmod[3] == null
    endfunction
    
    private function action takes nothing returns nothing
        local unit caster = GetManipulatingUnit()
        local integer cyclA
		local integer array it
	
		call eyest( caster )
		set it[0] = 0
		set it[1] = 0
		set cyclA = 2
		loop
			exitwhen cyclA > 4
	        set it[cyclA] = udg_DB_Item_Activate[ GetRandomInt( 1, udg_Database_NumberItems[31] ) ]
			if (it[cyclA] == it[cyclA-1] or it[cyclA] == it[cyclA-2]) then
				set cyclA = cyclA - 1
			endif
			set cyclA = cyclA + 1
		endloop
        
		call forge( caster, GetManipulatedItem(), it[4], it[2], it[3], false )
        
        set caster = null
    endfunction
    
    private function init takes nothing returns nothing
        call CreateNativeEvent( EVENT_PLAYER_UNIT_USE_ITEM, function action, function condition )
    endfunction

	
endscope