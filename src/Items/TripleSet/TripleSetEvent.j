library TripleSetEvent initializer init requires TripleSet

	private function condition takes nothing returns boolean
		return TagSystem_CheckTagItem(GetManipulatedItem(), TAG_TRIPLE_SET_PIECE)
	endfunction
	
	public function CheckCondition takes unit hero, integer itemType returns boolean
		local TripleSet tripleSet = TripleSet.Get(itemType)
	    local integer conditionAmount = 0
	    local integer itemTypeCheck
	    local integer i
	    
	    //call BJDebugMsg("CheckAdding")
	    set i = 0
	    loop
	    	exitwhen i >= TripleSet_PIECE_AMOUNT
	    	set itemTypeCheck = tripleSet.Piece[i]
	    	if itemTypeCheck == itemType or inv(hero, itemTypeCheck) > 0 then
	    		set conditionAmount = conditionAmount + 1
	    	endif
	    	set i = i + 1
    	endloop
    	//call BJDebugMsg("conditionAmount: " + I2S(conditionAmount))
    	return conditionAmount >= TripleSet_PIECE_AMOUNT
	endfunction
	
	public function EndMerging takes unit hero, integer itemType returns nothing
		local TripleSet tripleSet = TripleSet.Get(itemType)
		local integer index = CorrectPlayer(hero)
	    local player owner = Player(index - 1)
		local integer i
		local item newItem
		local integer itemTypeCheck
		
		set i = 0
	    loop
	    	exitwhen i >= TripleSet_PIECE_AMOUNT
	    	set itemTypeCheck = tripleSet.Piece[i]
	    	 call RemoveItem( GetItemOfTypeFromUnitBJ(hero, itemTypeCheck) )
	    	set i = i + 1
    	endloop
	    
	    set newItem = CreateItem( tripleSet.Reward, GetUnitX(hero), GetUnitY(hero))
	    call UnitAddItem(hero, newItem)
	    
	    call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl", hero, "origin" ) )
	    call DisplayTimedTextToForce( GetPlayersAll(), 10, udg_Player_Color[index] + GetPlayerName(owner) + "|r assembled the " + GetItemName(newItem) + "!" )
	    
	    set owner = null
	    set newItem = null
	endfunction
	
	private function action takes nothing returns nothing
		local integer itemType = GetItemTypeId(GetManipulatedItem())

		if CheckCondition(GetManipulatingUnit(), itemType) == false then
    		return
    	endif
	    call EndMerging(GetManipulatingUnit(), itemType)
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endlibrary