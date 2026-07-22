scope RunestoneLous initializer init
	globals
	    private constant integer SHIELD_TO_GAIN = 400
		private constant integer REDUCTION = 25
		private constant integer ITEM = 'I0HP'
	endglobals
	
    private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local integer shieldGain = SHIELD_TO_GAIN * SetCount_GetPieces(caster, SET_RUNE)

        call shield( caster, null, shieldGain )

        set caster = null
	endfunction
    
	//===========================================================================
    private function ItemAdd takes nothing returns nothing
    	local unit u = GetManipulatingUnit()
        local integer i = GetUnitUserData( u )
        if not( udg_logic[i + 26] ) and GetItemTypeId(GetManipulatedItem()) == ITEM then
			call spdst( u, -REDUCTION )
        endif
        set u = null
    endfunction
    
    private function ItemRemove takes nothing returns nothing
    	local unit u = GetManipulatingUnit()
        local integer i = GetUnitUserData( u )
        if not( udg_logic[i + 26] ) and GetItemTypeId(GetManipulatedItem()) == ITEM then
			call spdst( u, REDUCTION )
        endif
        set u = null
    endfunction
    
    private function Rune_Lous takes unit u, item it, boolean isBonusAdded returns nothing
        local integer number = inv(u, ITEM)
        local integer heroId = GetUnitUserData(u)
        local real count
        
        if isBonusAdded then
            set count = REDUCTION
        else
            set count = -REDUCTION
        endif
        
        if count < 0 and GetItemTypeId( it ) == ITEM then
            set number = number - 1
        endif
        
        if number > 0 then
            call spdst(u, count*number)
        endif
        
        set u = null
        set it = null
    endfunction
    
    private function ItemSetAdd takes nothing returns nothing
    	local unit caster = RuneSetGain.GetDataUnit("caster")
    	local item itemUsed = RuneSetGain.GetDataItem("item")
    	
        call Rune_Lous(caster, itemUsed, true)
        
        set caster = null
        set itemUsed = null
    endfunction
    
    private function ItemSetRemove takes nothing returns nothing
        local unit caster = RuneSetLose.GetDataUnit("caster")
    	local item itemUsed = RuneSetLose.GetDataItem("item")
    	
        call Rune_Lous(caster, itemUsed, false)
        
        set caster = null
        set itemUsed = null
    endfunction

    private function init takes nothing returns nothing
    	call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function ItemAdd, null )
    	call CreateNativeEvent( EVENT_PLAYER_UNIT_DROP_ITEM, function ItemRemove, null )
        call RuneSetGain.AddListener(function ItemSetAdd, null)
        call RuneSetLose.AddListener(function ItemSetRemove, null)
        call RegisterDuplicatableItemTypeCustom( ITEM, BattleStart, function action, null, null)
    endfunction
endscope