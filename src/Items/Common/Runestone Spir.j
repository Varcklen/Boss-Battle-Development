scope RunestoneSpir initializer init
	
	globals
		private constant integer ITEM_ID = 'I086'
	endglobals

	private function condition takes nothing returns boolean
		return inv( BattleEnd.GetDataUnit("caster"), ITEM_ID ) > 0
	endfunction
	
	private function action takes nothing returns nothing
		local unit hero = BattleEnd.GetDataUnit("caster")
		local integer array st
		local integer i
	
		set st[0] = 0
        set st[1] = 0
        set i = 2
        loop
            exitwhen i > 4
            set st[i] = DB_SetItems[5][GetRandomInt( 1, udg_DB_SetItems_Num[5] )]
            if (st[i] == st[i-1] or st[i] == st[i-2]) then
                set i = i - 1
            endif
            set i = i + 1
        endloop
        call forge( hero, GetItemOfTypeFromUnitBJ( hero, ITEM_ID), st[4], st[2], st[3], true )
        
        set hero = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
    	call BattleEnd.AddListener(function action, function condition)
	endfunction
	
endscope