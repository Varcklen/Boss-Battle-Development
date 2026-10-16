scope GreyGuardQuest initializer init

	globals
		private constant integer COUNTER = 15
		private constant integer ITEM_ID = 'I098'
		private constant integer REWARD = 'I03G'
		private constant integer HASH_KEY = StringHash( "grey_guard_quest" )
	endglobals

	private function condition takes nothing returns boolean
	    return IsBoss(GetDyingUnit()) and GetOwningPlayer(GetDyingUnit()) == Player(10) and GetUnitAbilityLevel( GetDyingUnit(), 'A1ID' ) == 0
	endfunction
	
	private function Quest takes unit hero, integer index returns nothing
		local integer id = GetHandleId( hero )
		local integer s = LoadInteger( udg_hash, id, HASH_KEY ) + 1
		local item it = GetItemOfTypeFromUnitBJ(hero, ITEM_ID)
        local string text

        call SaveInteger( udg_hash, id, HASH_KEY, s )
        
        call Quest_QuestCondition( hero, ITEM_ID, REWARD, s, COUNTER )
        set text = words( hero, BlzGetItemDescription(it), "|cFF959697(", ")|r", I2S(s) + "/" + I2S(COUNTER) )
        call BlzSetItemExtendedTooltip( it, text )
        
        set it = null
	endfunction
	
	private function action takes nothing returns nothing
		local integer i 
		local unit hero
	
	    set i = 1
	    loop
	        exitwhen i > 4
	        set hero = udg_hero[i]
	        if inv(hero, ITEM_ID) > 0 and IsUnitAlive( hero ) then
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