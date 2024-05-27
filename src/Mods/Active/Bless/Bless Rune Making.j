scope BlessRuneMaking initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction
	
	private function action takes nothing returns nothing
		local integer i = 1
        loop
            exitwhen i > 6
            set bj_lastCreatedItem = CreateItem( udg_ArenaRunes[GetRandomInt(1, udg_Database_NumberItems[27])], GetRandomReal(GetRectMinX(udg_Boss_Rect), GetRectMaxX(udg_Boss_Rect)), GetRandomReal(GetRectMinY(udg_Boss_Rect), GetRectMaxY(udg_Boss_Rect)) )
            call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", GetItemX( bj_lastCreatedItem ), GetItemY( bj_lastCreatedItem ) ) )
            set i = i + 1
        endloop
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		if udg_fightmod[0] then
			call action()
		endif
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_FightStartGlobal_Real", function action, function condition )
		call DisableTrigger( Trigger )
	endfunction

endscope