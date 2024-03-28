scope OgreClub

	public function Enable takes nothing returns nothing
		call BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A05I' )
    endfunction
    
    public function Disable takes nothing returns nothing
		call BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A05I' )
    endfunction

endscope