scope BlackEgg initializer init

	globals
		private constant integer ID_ITEM = 'I0HT'
		private constant integer ID_RADI = 'I043'
		
	endglobals

	private function condition takes nothing returns boolean
    	return GetItemTypeId(GetManipulatedItem()) == ID_ITEM
	endfunction
	
	private function action takes nothing returns nothing
	    local integer cyclA
	    local item myItem
	    local unit caster = GetManipulatingUnit()
	
	    set cyclA = 0
	    loop
	        exitwhen cyclA > 5
	        set myItem = UnitItemInSlot( caster, cyclA )
	        call BlzSetItemExtendedTooltip( myItem, wordscurrent( caster, BlzGetItemExtendedTooltip(myItem), "|cffC71585Cursed|r", "|cFF1CE6B9Cleansed!|r" ) )
	        //endif
	        set cyclA = cyclA + 1
	    endloop
	    call stazisst( caster, GetItemOfTypeFromUnitBJ( caster, ID_ITEM ))
	    call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl" , caster, "origin" ) )
	    
	    set caster = null
	    set myItem = null
	endfunction
	
    private function EndOfLostBattle_Conditions takes nothing returns boolean
        return /*inv(Event_EndOfLostBattle_Hero, ID_ITEM)>0 and*/ udg_fightmod[3] == false
    endfunction
    
    private function EndOfLostBattle takes nothing returns nothing
        local unit hero = Event_EndOfLostBattle_Hero
        local integer amount = inv(hero, ID_ITEM)
	    local integer cyclA = 1
        
        loop
	        exitwhen cyclA > amount
            call RemoveItem( GetItemOfTypeFromUnitBJ( hero, ID_ITEM ) )
            call UnitAddItemById(hero, ID_RADI)
	    	call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl" , hero, "origin" ) )
	        set cyclA = cyclA + 1
	    endloop
        
        set hero = null
    endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
        call CreateEventTrigger( "Event_EndOfLostBattle_Real", function EndOfLostBattle, function EndOfLostBattle_Conditions )
        
		call CreateNativeEvent( EVENT_PLAYER_UNIT_USE_ITEM, function action, function condition )
	endfunction

endscope