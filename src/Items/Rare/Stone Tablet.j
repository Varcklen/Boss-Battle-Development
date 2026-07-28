scope StoneTablet initializer init

	globals
		private constant integer ITEM_ID = 'I07B'
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleEnd.GetDataUnit("caster")
		local integer index = BattleEnd.GetDataInteger("index")

        call SetHeroLevel( caster, GetHeroLevel(caster) + 1, false)
        call textst( "|c00ffffff +1 level", caster, 64, GetRandomReal( 0, 360 ), 10, 1.5 )
        set udg_Data[index + 12] = udg_Data[index + 12] + 1
	    
	    set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action, function condition, null )
	endfunction
	
endscope

