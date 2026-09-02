scope GreyGuardQuest initializer init

	globals
		private constant integer COUNTER = 15
	endglobals

	private function condition takes nothing returns boolean
	    return IsUnitInGroup(GetDyingUnit(), udg_Bosses)
	endfunction
	
	private function Quest takes unit hero, integer index returns nothing
		local integer id
		local integer s
	
		set id = GetHandleId( hero )
        set s = LoadInteger( udg_hash, id, StringHash( udg_QuestItemCode[3] ) ) + 1
        call SaveInteger( udg_hash, id, StringHash( udg_QuestItemCode[3] ), s )
        if s >= COUNTER then
            call SetWidgetLife( GetItemOfTypeFromUnitBJ(hero, 'I098'), 0 )
            set bj_lastCreatedItem = CreateItem( 'I03G', GetUnitX(hero), GetUnitY(hero))
            call UnitAddItem(hero, bj_lastCreatedItem)
            call textst( "|c00ffffff Fulfillment of will done!", hero, 64, GetRandomReal( 45, 135 ), 12, 1.5 )
            call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Human\\ReviveHuman\\ReviveHuman.mdl", hero, "origin" ) )
            set udg_QuestDone[index] = true
        else
            call QuestDiscription( hero, 'I098', s, COUNTER )
        endif
	endfunction
	
	private function action takes nothing returns nothing
		local integer i 
		local unit hero
	
	    set i = 1
	    loop
	        exitwhen i > 4
	        set hero = udg_hero[i]
	        if inv(hero, 'I098') > 0 and IsUnitAlive( hero ) then
	            call Quest(hero, i)
	        endif
	        set i = i + 1
	    endloop
	    
	    set hero = null
	endfunction

    //===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DEATH )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope