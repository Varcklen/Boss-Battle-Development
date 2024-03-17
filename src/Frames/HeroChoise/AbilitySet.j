library AbilitySet initializer init requires Trigger

	public function LearnAbilities takes unit hero returns nothing
		local integer i = 1
		local integer index = GetUnitUserData(hero)
        local integer heroindex = udg_HeroNum[index]
		local integer abilityId
		
		loop
			exitwhen i > 4
			set abilityId = Database_Hero_Abilities[i][heroindex]
			//call BJDebugMsg("ability:" + I2S(abilityId))
			call SelectHeroSkill( hero, abilityId )
			set i = i + 1
		endloop
	endfunction

	private function OnHeroChoose takes nothing returns nothing
		local unit hero = Event_HeroChoose_Hero
		
        call ModifyHeroSkillPoints( hero, bj_MODIFYMETHOD_ADD, 3 )
        //call BJDebugMsg("heroindex:" + I2S(heroindex))
		call LearnAbilities(hero)
		
		if udg_Boss_LvL == 1 then
			call ModifyHeroSkillPoints( hero, bj_MODIFYMETHOD_SET, 0 )
		endif
		
		set hero = null
	endfunction
	
	private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_HeroChoose_Real", function OnHeroChoose, null )
	endfunction

endlibrary