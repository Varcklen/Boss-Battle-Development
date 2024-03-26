scope WeaponDelete

	private function Delete takes item it returns nothing
		local UltimateWeapon weaponData = UltimateWeapon.GetStruct(it)
	
        call weaponData.destroy()
	endfunction

	private function OnRemoveItem takes item it returns nothing
        if GetItemTypeId( it ) != WeaponPieceSystem_ULTIMATE_WEAPON_ID then
        	return
        endif
        call Delete(it)
    endfunction
    
    hook RemoveItem OnRemoveItem

endscope