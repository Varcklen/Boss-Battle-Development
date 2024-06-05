library RandomBonusDatabase initializer init

	globals
		private RandomBonus array RandomBonuses
		public integer RandomBonuses_Max = 0 
	endglobals
	
	public function GetRandomBonus takes integer index returns RandomBonus
		return RandomBonuses[index]
	endfunction
	
	struct RandomBonus
		readonly integer Ability
		readonly string Description
		
		static method create takes integer abilityId, string description returns thistype
			local thistype p = thistype.allocate()
			
			set p.Ability = abilityId
			set p.Description = description
			
			set RandomBonuses_Max = RandomBonuses_Max + 1
			set RandomBonuses[RandomBonuses_Max] = p
			
            return p
        endmethod
	endstruct

	private function init takes nothing returns nothing
		call RandomBonus.create('A0NO', "Attack power +12")
		call RandomBonus.create('A0NU', "Armor +3")
		call RandomBonus.create('A0NV', "Stats +2")
		call RandomBonus.create('A00O', "Health +200")
		call RandomBonus.create('A00Z', "Agility +6")
		call RandomBonus.create('A01B', "Strength +6")
		call RandomBonus.create('A01K', "Intelligence +6")
		call RandomBonus.create('A02A', "Agility and Strength +3")
		call RandomBonus.create('A030', "Strength and Intelligence +3")
		call RandomBonus.create('A06X', "Intelligence and Agility +3")
		call RandomBonus.create('A070', "Mana +75")
		call RandomBonus.create('A074', "Health regeneration +2")
		call RandomBonus.create('A095', "Mana regeneration +75%")
		call RandomBonus.create('A0A7', "Attack speed +12%")
		call RandomBonus.create('A0B2', "Movement speed +15%")
		call RandomBonus.create('A0Y4', "Spell power +8%")
		call RandomBonus.create('A106', "Luck +8")
		call RandomBonus.create('A108', "Damage received -4%")
		call RandomBonus.create('A0G2', "Splits free")
		call RandomBonus.create('A0G3', "Buff duration +20%")
	endfunction
	
endlibrary