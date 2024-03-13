scope RandomBonus initializer init

	globals
		private constant integer BONUSES_LIMIT = 8
		
		private constant integer STRING_HASH = StringHash( "random_bonus" )
	endglobals

	public function IsWithRandomBonus takes item itemUsed returns boolean
		return BlzGetItemAbility( itemUsed, 'A0NN' ) != null or LoadBoolean( udg_hash, GetHandleId(itemUsed), STRING_HASH )
	endfunction
	
	public function Add takes item itemUsed returns nothing
		local integer cyclA = 1
	    local integer cyclAEnd
	    local integer cyclB
		local integer cyclBEnd
	    local integer id = GetHandleId(itemUsed)
	    local integer k
	    local integer rand = 0
	    local string str
	    
        set cyclA = 1
        set cyclAEnd = BONUSES_LIMIT
        loop
            exitwhen cyclA > cyclAEnd
            if LoadInteger( udg_hash, id, StringHash( "extra"+I2S(cyclA) ) ) == 0 then
                set k = cyclA
                set cyclA = cyclAEnd
            endif
            set cyclA = cyclA + 1
        endloop
        
        set cyclA = 1
        loop
            exitwhen cyclA > 1
            set rand = GetRandomInt(1, udg_Database_NumberItems[25])
            if k > 1 then
                set cyclB = 1
                set cyclBEnd = k-1
                loop
                    exitwhen cyclB > cyclBEnd
                    if rand == LoadInteger( udg_hash, id, StringHash( "extra"+I2S(cyclB) ) ) then
                        set cyclA = cyclA - 1
                        set cyclB = cyclBEnd
                    endif
                    set cyclB = cyclB + 1
                endloop
            endif
            set cyclA = cyclA + 1
        endloop
        
        if rand != 0 then
            call BlzItemAddAbilityBJ( itemUsed, udg_RandomBonus[rand] )
            call BlzSetItemExtendedTooltip( itemUsed, BlzGetItemExtendedTooltip(itemUsed) + "|n|cff81f260" + udg_RandomString[rand] + "|r" ) // sadtwig
        endif 
	endfunction
	
	//===========================================================================
	function Trig_RandomBonus_Conditions takes nothing returns boolean
	    return BlzGetItemAbility( GetManipulatedItem(), 'A0NN' ) != null
	endfunction
	
	private function RandomWords takes string s returns string
		local integer cyclA = 0
		local integer cyclAEnd = StringLength(s)
		local integer i = cyclAEnd
	    local boolean l = false
	    local string str = s
	
		loop
			exitwhen cyclA > cyclAEnd
			if SubString(s, cyclAEnd-cyclA, cyclAEnd-cyclA+1) == "[" then
				set i = cyclAEnd-cyclA
	            set l = true
				set cyclA = cyclAEnd
			endif
			set cyclA = cyclA + 1
		endloop
	    if l then
	        set str = SubString(s, 0, i-10)
	    endif
		return str
	endfunction
	
	function Trig_RandomBonus_Actions takes nothing returns nothing
		local integer cyclA = 1
		local integer cyclB
		local integer cyclBEnd
		local integer array i
		local boolean array l
		local string str = BlzGetItemExtendedTooltip(GetManipulatedItem())
	    local integer id = GetHandleId(GetManipulatedItem())
	    local integer limit = BONUSES_LIMIT
	    local integer current = 1
	
	    call BlzItemRemoveAbilityBJ( GetManipulatedItem(), 'A0NN' )
	    if BlzGetItemAbility( GetManipulatedItem(), 'A0NW' ) != null then
	        call BlzItemRemoveAbilityBJ( GetManipulatedItem(), 'A0NW' )
	        set current = current + 1
	    endif
	    if BlzGetItemAbility( GetManipulatedItem(), 'A0OX' ) != null then
	        call BlzItemRemoveAbilityBJ( GetManipulatedItem(), 'A0OX' )
	        set current = current + 1
	    endif
	    
	    if current > limit then
	        set limit = current
	        if limit > udg_Database_NumberItems[25] then
	            set limit = udg_Database_NumberItems[25]
	        endif
	    endif
	
	    set cyclA = 1
	    loop
	        exitwhen cyclA > limit
	        set i[cyclA] = 0
	        set l[cyclA] = false
	        set cyclA = cyclA + 1
	    endloop
	
	    set cyclA = 1
	    set i[1] = GetRandomInt(1, udg_Database_NumberItems[25])
	    loop
	        exitwhen cyclA > limit
	        set i[cyclA] = GetRandomInt(1, udg_Database_NumberItems[25])
	        set cyclB = 1
	        set cyclBEnd = cyclA - 1
	        loop
	            exitwhen cyclB > cyclBEnd
	            if i[cyclA] == i[cyclB] then
	                set cyclA = cyclA - 1
	                set cyclB = cyclBEnd
	            endif
	            set cyclB = cyclB + 1
	        endloop
	        set cyclA = cyclA + 1
	    endloop
	
	    set cyclA = 1
	    loop
	        exitwhen cyclA > limit
	        if current >= cyclA then
	            call BlzItemAddAbilityBJ( GetManipulatedItem(), udg_RandomBonus[i[cyclA]] )
	            set str = RandomWords(str)
	            //call BlzSetItemIconPath( GetManipulatedItem(), str )
	            call SaveInteger( udg_hash, id, StringHash( "extra" + I2S(cyclA) ), i[cyclA] )
	            set l[cyclA] = true
	        else
	            set cyclA = limit
	        endif
	        set cyclA = cyclA + 1
	    endloop
	
	    set cyclA = 1
	    loop
	       exitwhen cyclA > limit
	        if l[cyclA] then
	            set str = str + "|cff81f260" + udg_RandomString[i[cyclA]] + "|r"
	            if cyclA != current then
	                set str = str + "|n"
	            endif
	        else
	            set cyclA = limit
	        endif
	        set cyclA = cyclA + 1
	    endloop
	    call BlzSetItemExtendedTooltip( GetManipulatedItem(), str )  // sadtwig
	    call SaveBoolean( udg_hash, id, STRING_HASH, true )
	    //call BlzSetItemIconPath( GetManipulatedItem(), str ) 
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	    call TriggerAddCondition( trig, Condition( function Trig_RandomBonus_Conditions ) )
	    call TriggerAddAction( trig, function Trig_RandomBonus_Actions )
	endfunction

endscope