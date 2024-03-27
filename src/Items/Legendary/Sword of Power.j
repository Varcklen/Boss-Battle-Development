scope SwordOfPower

	public function Enable takes nothing returns nothing
		call BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0BF' )
		call BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A02B' )
    endfunction
    
    public function Disable takes nothing returns nothing
		call BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0BF' )
		call BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A02B' )
    endfunction

endscope