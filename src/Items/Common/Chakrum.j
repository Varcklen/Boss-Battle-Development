scope Chakrum

	public function Enable takes nothing returns nothing
		call BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0P3' )
		call BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0P4' )
    endfunction
    
    public function Disable takes nothing returns nothing
		call BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0P3' )
		call BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0P4' )
    endfunction

endscope