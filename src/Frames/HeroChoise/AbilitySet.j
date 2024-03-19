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
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit hero = LoadUnitHandle( udg_hash, id, StringHash( "ability_set_delay" ) )
		
        call ModifyHeroSkillPoints( hero, bj_MODIFYMETHOD_ADD, 3 )
        //call BJDebugMsg("heroindex:" + I2S(heroindex))
		call LearnAbilities(hero)
		
		if udg_Boss_LvL == 1 then
			call ModifyHeroSkillPoints( hero, bj_MODIFYMETHOD_SET, 0 )
		endif
		call FlushChildHashtable( udg_hash, id )
		
		set hero = null
	endfunction
	
	private function OnHeroChoose_Delay takes nothing returns nothing
		call InvokeTimerWithUnit( Event_HeroChoose_Hero, "ability_set_delay", 0.1, false, function OnHeroChoose )
	endfunction
	
	private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_HeroChoose_Real", function OnHeroChoose_Delay, null )
	endfunction

endlibrary