scope BanditArmorCrit initializer init

	globals
		private constant integer ITEM_ID = 'I06K'
		
		private constant integer CHANCE = 25
		private constant real DAMAGE_INCREASE = 0.75
	endglobals

	private function condition takes nothing returns boolean 
		//call BJDebugMsg("BanditArmorCrit")
		return udg_IsDamageSpell == false and LuckChance( BeforeAttack.TriggerUnit, CHANCE )
	endfunction 

	private function action takes nothing returns nothing
		local real extraDamage = BeforeAttack.GetDataReal("static_damage") * DAMAGE_INCREASE
		local real damage = BeforeAttack.GetDataReal("damage") 
	    
	    set udg_DamageEventType = udg_DamageTypeCriticalStrike
	    call BeforeAttack.SetDataReal("damage", damage + extraDamage )
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BeforeAttack, function action, function condition, "caster" )
	endfunction
	
endscope