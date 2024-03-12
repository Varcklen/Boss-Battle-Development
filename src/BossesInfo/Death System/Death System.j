library DeathSystem initializer init requires Trigger

	globals
		private group AliveHeroes = CreateGroup()
		private group DeadHeroes = CreateGroup()
		
		private trigger DeathEvent
		
		private group temp_Group
	endglobals

	//Functions
	public function GetAmountOfDiedHeroes takes nothing returns integer
		return CountUnitsInGroup(DeadHeroes)
	endfunction
	
	public function GetAmountOfAliveHeroes takes nothing returns integer
		return CountUnitsInGroup(AliveHeroes)
	endfunction
	
	public function AddHeroIntoAliveGroup takes unit hero returns nothing
		if IsUnitInGroup( hero, DeadHeroes ) == false then
			return
		endif
	
		call GroupRemoveUnit( DeadHeroes, hero )
        call GroupAddUnit( AliveHeroes, hero )
	endfunction
	
	public function GetRandomAliveHero takes nothing returns unit
		return GroupPickRandomUnit(AliveHeroes)
	endfunction
	
	public function GetRandomDeadHero takes nothing returns unit
		return GroupPickRandomUnit(DeadHeroes)
	endfunction
	
	public function GetAliveHeroGroupCopy takes nothing returns group
		set temp_Group = CreateGroup()
		
		call GroupAddGroup( AliveHeroes, temp_Group )
		return temp_Group
	endfunction
	
	public function GetDeadHeroGroupCopy takes nothing returns group
		set temp_Group = CreateGroup()
		
		call GroupAddGroup( AliveHeroes, temp_Group )
		return temp_Group
	endfunction
	//===========================================================================
	
	//Is unit can be target of battle ressurect
    private function TargetCheck takes unit target returns boolean
    	//Is ressurection points left? 
    	if udg_Heroes_Ressurect_Battle > 0 then
    		return false
		//Is target alive hero
    	elseif IsUnitInGroup( target, AliveHeroes ) == false then
    		return false
    	//Is under ressurection?
    	elseif GetUnitAbilityLevel(target, 'A05X') > 0 then
    		return false
		//Is under ressurection?
    	elseif IsUnitInGroup(target, udg_Return) then
    		return false
    	endif
        return true
    endfunction
	
	private function condition takes nothing returns boolean
		return TargetCheck(GetDyingUnit())
	endfunction
	
	private function Check takes unit diedHero returns boolean
		if IsTriggerEnabled(DeathEvent) == false then
			call BJDebugMsg("Error! DeathSystem - Check: You're trying to check if all heroes died while trigger is disabled!")
			return false
		endif
	
		if diedHero != null then
			set udg_logic[35] = true
			call GroupAddUnit( DeadHeroes, diedHero)
	        call GroupRemoveUnit( AliveHeroes, diedHero)
        endif
        
        if IsUnitGroupEmptyBJ(AliveHeroes) then
        	call AllHeroesDied.Invoke()
        	return true
        endif
        return false
	endfunction
	
	private function action takes nothing returns nothing
		local boolean isAllHeroesDead
		
		set isAllHeroesDead = Check(GetDyingUnit())
		
		if isAllHeroesDead then
			call DisableTrigger( GetTriggeringTrigger() )
		endif
	endfunction
	
	public function RemoveFromGroups takes unit hero returns nothing
		call GroupRemoveUnit( DeadHeroes, hero )
        call GroupRemoveUnit( AliveHeroes, hero )
	endfunction
	
	//Revive
	//===========================================================================
	private function action_revive takes nothing returns nothing
        call AddHeroIntoAliveGroup(GetRevivingUnit())
	endfunction
	
	//Player Leave
	//===========================================================================
	private function OnPlayerLeave takes nothing returns nothing
		local unit hero = Event_PlayerLeave_Hero

        call Check(hero)
        call RemoveFromGroups(hero)
        
        set hero = null
	endfunction
	
	//OnHeroRepick
	//===========================================================================
	private function OnRepick takes nothing returns nothing
		call RemoveFromGroups(Event_HeroRepick_Hero)
	endfunction
	
	//OnHeroChoise
	//===========================================================================
	private function OnHeroChoise takes nothing returns nothing
		call GroupAddUnit( AliveHeroes, Event_HeroChoose_Hero)
	endfunction
	
	//SetRandomHeroes
	//===========================================================================
	private function OnRandomHeroesSet takes nothing returns nothing
		call GroupClear(DeadHeroes)
		call GroupClear(AliveHeroes)
	endfunction
	
	//OnBattleStart
	//===========================================================================
	private function OnBattleStart takes nothing returns nothing
		call EnableTrigger( DeathEvent )
	endfunction
	
	//OnBattleEnd
	//===========================================================================
	private function OnBattleEnd takes nothing returns nothing
		call DisableTrigger( DeathEvent )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		set DeathEvent = CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, function condition )
		call DisableTrigger( DeathEvent )
		
		call CreateEventTrigger( "udg_FightStartGlobal_Real", function OnBattleStart, null )
		call CreateEventTrigger( "udg_FightEndGlobal_Real", function OnBattleEnd, null )
		
		call CreateNativeEvent( EVENT_PLAYER_HERO_REVIVE_FINISH, function action_revive, null )
		call CreateEventTrigger( "Event_PlayerLeave_Real", function OnPlayerLeave, null )
		call CreateEventTrigger( "Event_HeroRepick_Real", function OnRepick, null )
		call CreateEventTrigger( "Event_HeroChoose_Real", function OnHeroChoise, null )
		call SetRandomHeroes.AddListener(function OnRandomHeroesSet, null)
	endfunction

endlibrary