scope TarotThreeOfWands initializer init

	private function condition takes nothing returns boolean
	    return GetItemTypeId(GetManipulatedItem()) == 'I0BC'
	endfunction
	
	private function action takes nothing returns nothing
	    call JuleRef()
	    call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", GetManipulatingUnit(), "origin" ) )
	    call statst( GetManipulatingUnit(), 1, 1, 1, 0, true )
	    
	    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_USE_ITEM, function action, function condition )
	endfunction

endscope