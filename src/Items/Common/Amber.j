scope Amber initializer init

	globals
		private constant integer ITEM_ID = 'I0AJ'
		
		private constant integer SHIELD_GAIN = 300
	endglobals
	
	private function action takes nothing returns nothing
		local integer i = 1
		local unit caster = BattleStart.GetDataUnit("caster")
		local unit hero
		
        loop
            exitwhen i > PLAYERS_LIMIT
            set hero = udg_hero[i]
            if unitst( caster, hero, "ally" ) then
                call shield( caster, hero, SHIELD_GAIN )
            endif
            set i = i + 1
        endloop
        set hero = null
        set caster = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, null, null)
	endfunction

endscope