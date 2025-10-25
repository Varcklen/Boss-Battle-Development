scope RunestoneLous initializer init
	globals
	    private constant integer DAMAGE = 40
	    private constant integer RANGE = 600
		private constant integer REDUCTION = 35
		private constant integer ITEM = 'I0HP'
    	private constant string ANIMATION = "Units\\NightElf\\Wisp\\WispExplode.mdl"
	endglobals
	
    private function ShieldDestroyed_Conditions takes nothing returns boolean
        return true//GetUnitAbilityLevel( Event_ShieldDestroyed_Hero, 'A10G') > 0
    endfunction
    
    private function ShieldDestroyedProxy takes nothing returns nothing
    	local integer id = GetHandleId( GetExpiredTimer() )
    	local unit hero = LoadUnitHandle( udg_hash, id, StringHash( "rune_lous_amount" ) )
    	local integer amount = LoadInteger( udg_hash, id, StringHash( "rune_lous_amount" ) )
    	
        call GroupAoE( hero, 0, 0, DAMAGE * amount, RANGE, "enemy", ANIMATION, null )
            
        set hero = null
    endfunction
    private function ShieldDestroyed takes nothing returns nothing
        local unit hero = Event_ShieldDestroyed_Hero
    	local integer amount
    	local integer id
	    
	    set amount = inv( hero, ITEM )
	    if amount > 0 then
	        set id = InvokeTimerWithUnit( hero, "rune_lous_amount", 0.04, false, function ShieldDestroyedProxy )
	        call SaveInteger( udg_hash, id, StringHash( "rune_lous_amount" ), amount )
	    endif
            
        set hero = null
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
        call CreateEventTrigger( "Event_ShieldDestroyed_Real", function ShieldDestroyed, null )
    endfunction
endscope