scope ExperimentStart initializer init

	private function OnHeroChoose takes nothing returns nothing
		local unit hero = Event_HeroChoose_Hero
		local integer i = 1
		local integer index = GetPlayerId(GetOwningPlayer(hero)) + 1
        local integer heroindex = udg_HeroNum[index]
        local integer abilityId
        
        call ModifyHeroSkillPoints( hero, bj_MODIFYMETHOD_SET, 4 )
        //call BJDebugMsg("heroindex:" + I2S(heroindex))
		loop
			exitwhen i > 4
			set abilityId = Database_Hero_Abilities[i][heroindex]
			//call BJDebugMsg("ability:" + I2S(abilityId))
			if abilityId != 'A12S' then
				call SelectHeroSkill( hero, abilityId )
			endif
			set i = i + 1
		endloop
		
		call ModifyHeroSkillPoints( hero, bj_MODIFYMETHOD_SET, 0 )
		
		set hero = null
	endfunction
	
	private function Delay takes nothing returns nothing
		set udg_BossHP = udg_BossHP + 0.4
    	set udg_BossAT = udg_BossAT + 0.4
    	call SpellPower_AddBossSpellPower( 0.4 )
    	
    	call IconFrame( "Experimental", "ReplaceableTextures\\CommandButtons\\BTNReveal.blp", "|cffffcc00Experimental Version|r", "- SD graphic only.|n- Increases enemy power by 40%.|n- All heroes start with the first level of abilities.|n- Ability levels cannot be reset." )
    	
    	call CreateEventTrigger( "Event_HeroChoose_Real", function OnHeroChoose, null )
	endfunction
	
	private function init takes nothing returns nothing
		call TimerStart( CreateTimer(), 0.5, false, function Delay )
	endfunction

endscope