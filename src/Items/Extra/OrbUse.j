scope OrbMerge initializer init
	
	/*private function Orb_Logic takes item t returns boolean
	    local integer i = 1
	    local integer iEnd = udg_Database_NumberItems[8]
		local integer itemType = GetItemTypeId(t)
	    
	    loop
	        exitwhen i > iEnd
	        if itemType == udg_DB_Orb[i] then
	            return true
	        endif
	        set i = i + 1
	    endloop
	    return false
	endfunction*/
	
	private function condition takes nothing returns boolean
	    if udg_logic[36] then
	        return false
	    endif
	    if TagSystem_CheckTagItem(GetManipulatedItem(), TAG_UNMERGED_ORB) /*Orb_Logic(GetManipulatedItem())*/ == false then
	        return false
	    endif
	    return true
	endfunction
	
	private function CheckAmount takes unit n, integer itemType, integer itemTypeCheck returns integer
		local integer amount = inv(n, itemType)
		if itemType == itemTypeCheck then
			set amount = amount + 1
		endif
		return amount
	endfunction
	
	public function Merge takes unit n, integer itemType returns nothing
	    local integer add = 0
	    
	    local integer arcane = CheckAmount(n,'I08Y', itemType)
	    local integer fire = CheckAmount(n,'I08Z', itemType)
	    local integer frost = CheckAmount(n,'I090', itemType)
	    local integer earth = CheckAmount(n,'I0EP', itemType)
	    local integer nature = CheckAmount(n,'I0F0', itemType)
	    local integer light = CheckAmount(n,'I0FJ', itemType)
	    local integer shadow = CheckAmount(n,'I0FU', itemType)
	    
	    if arcane > 1 then//arcane
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Y'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Y'))
	        set add = 'I0DK'
	    elseif fire > 1 then//fire
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Z'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Z'))
	        set add = 'I091'
	    elseif frost > 1 then//frost
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I090'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I090'))
	        set add = 'I0DF'
	    elseif earth > 1 then//earth
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0EP'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0EP'))
	        set add = 'I0EQ'
	    elseif nature > 1 then//nature
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0F0'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0F0'))
	        set add = 'I0F1'
	    elseif light > 1 then//light
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FJ'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FJ'))
	        set add = 'I0FK'
	    elseif shadow > 1 then//shadow
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FU'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FU'))
	        set add = 'I0FV'
	    elseif arcane > 0 and fire > 0 then//arcane+fire
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Y'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Z'))
	        set add = 'I0AN'
	    elseif arcane > 0 and frost > 0 then//arcane+frost
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Y'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I090'))
	        set add = 'I0DJ'
	    elseif frost > 0 and fire > 0 then//frost+fire
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Z'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I090'))
	        set add = 'I0AH'
	    elseif earth > 0 and fire > 0 then//earth+fire
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0EP'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Z'))
	        set add = 'I0ER'
	    elseif earth > 0 and frost > 0 then//earth+frost
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0EP'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I090'))
	        set add = 'I0ES'
	    elseif earth > 0 and inv(n,'I08Y') > 0 then//earth+arcane
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0EP'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Y'))
	        set add = 'I0ET'
	    elseif nature > 0 and fire > 0 then//nature+fire
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0F0'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Z'))
	        set add = 'I0F4'
	    elseif nature > 0 and earth > 0 then//earth+nature
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0F0'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0EP'))
	        set add = 'I0F2'
	    elseif nature > 0 and frost > 0 then//nature+frost
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0F0'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I090'))
	        set add = 'I0F5'
	    elseif nature > 0 and inv(n,'I08Y') > 0 then//nature+arcane
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0F0'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Y'))
	        set add = 'I0F3'
	    elseif light > 0 and frost > 0 then//light+frost
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FJ'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I090'))
	        set add = 'I0FO'
	    elseif light > 0 and arcane > 0 then//light+arcane
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FJ'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Y'))
	        set add = 'I0FM'
	    elseif light > 0 and fire > 0 then//light+fire
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FJ'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Z'))
	        set add = 'I0FN'
	    elseif light > 0 and earth > 0 then//earth+light
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FJ'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0EP'))
	        set add = 'I0FL'
	    elseif nature > 0 and light > 0 then//nature+light
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0F0'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FJ'))
	        set add = 'I0FP'
	    elseif nature > 0 and shadow > 0 then//nature+dark
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0F0'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FU'))
	        set add = 'I0FZ'
	    elseif shadow > 0 and frost > 0 then//dark+frost
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FU'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I090'))
	        set add = 'I0FY'
	    elseif shadow > 0 and arcane > 0 then//dark+arcane
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FU'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Y'))
	        set add = 'I0FX'
	    elseif shadow > 0 and fire > 0 then//dark+fire
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FU'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I08Z'))
	        set add = 'I0FW'
	    elseif shadow > 0 and earth > 0 then//earth+dark
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FU'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0EP'))
	        set add = 'I0G1'
	    elseif shadow > 0 and light > 0 then//dark+light
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FU'))
	        call RemoveItem(GetItemOfTypeFromUnitBJ(n, 'I0FJ'))
	        set add = 'I0G0'
	    endif
	    if add != 0 then
	        call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", GetUnitX( n ), GetUnitY( n ) ) )
	        call UnitAddItem(n, CreateItem( add, GetUnitX( n ), GetUnitY(n)) )
	    endif
	    
	    set n = null
	endfunction
	
	private function delay takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer() )
		local unit caster = LoadUnitHandle(udg_hash, id, StringHash( "merge_orb" ) )
		
	    call Merge( caster, 0)
	    call FlushChildHashtable( udg_hash, id )
	    
	    set caster = null
	endfunction
	
	private function action takes nothing returns nothing
	    call InvokeTimerWithUnit( GetManipulatingUnit(), "merge_orb", 0.01, false, function delay )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction
	
endscope