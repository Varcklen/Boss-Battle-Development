scope RunestonePan initializer init

	globals
		private constant integer ITEM_ID = 'I07B'
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleEnd.GetDataUnit("caster")
		local integer index = BattleEnd.GetDataInteger("index")
	    local integer rand = GetRandomInt(1, 4)

        if rand == 1 then
            call SetHeroLevel( caster, GetHeroLevel(caster) + 1, false)
            call textst( "|c00ffffff +1 level", caster, 64, GetRandomReal( 0, 360 ), 10, 1.5 )
            set udg_Data[index + 12] = udg_Data[index + 12] + 1
        elseif rand == 2 then
            call statst( caster, 2, 2, 2, 0, true )
            call textst( "|c00ffffff +2 stats", caster, 64, GetRandomReal( 0, 360 ), 10, 1.5 )
            set udg_Data[index + 16] = udg_Data[index + 16] + 2
        elseif rand == 3 then
            call moneyst( caster, 100 )
            call textst( "|c00ffffff +100 gold", caster, 64, GetRandomReal( 0, 360 ), 10, 1.5 )
            set udg_Data[index + 20] = udg_Data[index + 20] + 100
        elseif rand == 4 then
            call UnitAddAbility( caster, 'A08Q' )
            call textst( "|c00ffffff Extra attack power!", caster, 64, GetRandomReal( 0, 360 ), 10, 1.5 )
        endif
	    
	    set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action, function condition, null )
	endfunction
	
endscope

