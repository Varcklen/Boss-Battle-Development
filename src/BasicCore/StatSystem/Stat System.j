library StatSystem initializer init

	globals
		//enums
		constant integer STAT_BUFF_DURATION = 0
		constant integer STAT_COOLDOWN = 1
		constant integer STAT_DAMAGE_DEALT = 2
		constant integer STAT_DAMAGE_DEALT_BOSSES = 3
		constant integer STAT_DAMAGE_DEALT_MINIONS = 4
		constant integer STAT_DAMAGE_DEALT_MINIONS_PHY = 5
		constant integer STAT_DAMAGE_DEALT_MAG = 6
		constant integer STAT_DAMAGE_DEALT_PHY = 7
		constant integer STAT_DAMAGE_TAKEN = 8
		constant integer STAT_DAMAGE_TAKEN_PHY = 9
		constant integer STAT_DODGE = 10
		constant integer STAT_GOLD_GAIN = 11
		constant integer STAT_HEAL_BONUS = 12
		constant integer STAT_HEAL_TAKEN = 13
		constant integer STAT_MANA_HEAL_BONUS = 14
		constant integer STAT_MOON_SET_DAMAGE_DEALT = 15
		constant integer STAT_VAMPIRISM = 16
		constant integer STAT_VAMPIRISM_MAG = 17
		constant integer STAT_VAMPIRISM_PHY = 18
		constant integer STAT_SHOP_DISCOUNT = 19
		//
		constant integer STAT_AMOUNT = 20
		
		constant real BASE_VALUE = 0
	endglobals

	//===========================================================================
	private struct Stat
		real value = BASE_VALUE
	endstruct
	
	private struct HeroStats
		Stat array stat[STAT_AMOUNT]
		
		static method create takes nothing returns thistype
			local thistype p = thistype.allocate()
			local integer i = 0
			
			loop
				exitwhen i >= STAT_AMOUNT
				set p.stat[i] = Stat.create()
				set i = i + 1
			endloop
			
            return p
        endmethod
	endstruct
	//===========================================================================
	
	globals
		private HeroStats array heroStats[PLAYERS_LIMIT]
	endglobals
	
	public function IsHero takes unit hero returns boolean
		return IsUnitType( hero, UNIT_TYPE_HERO )
	endfunction
	
	public function Add takes unit hero, integer statEnum, real value returns nothing
		local integer index
		local HeroStats heroStat
		local Stat statStruct
		
		if hero == null or IsHero( hero ) == false then
			return
		endif
		
		set index = GetUnitUserData(hero) - 1
		set heroStat = heroStats[index]
		set statStruct = heroStat.stat[statEnum]
		
		set statStruct.value = statStruct.value + ( value / 100.0 )
	endfunction
	
	public function Get takes unit hero, integer statEnum returns real
		local integer index
		local HeroStats heroStat
		local Stat statStruct
		
		if hero == null or GetPlayerController(GetOwningPlayer(hero)) != MAP_CONTROL_USER/*IsUnitType( hero, UNIT_TYPE_HERO ) == false*/ then
			call BJDebugMsg("Error! StatSystem - Get: Used unit is null or the owner is not a user! Unit: " + GetUnitName(hero))
			return BASE_VALUE
		endif
		
		set index = GetUnitUserData(hero) - 1
		set heroStat = heroStats[index]
		set statStruct = heroStat.stat[statEnum]
		
		return statStruct.value
	endfunction
	
	private function init takes nothing returns nothing
		local integer i = 0
		local player playerUsed
		
		loop
			exitwhen i >= PLAYERS_LIMIT
			set playerUsed = Player(i)
			if GetPlayerSlotState(playerUsed) == PLAYER_SLOT_STATE_PLAYING then
				set heroStats[i] = HeroStats.create()
			endif
			set i = i + 1
		endloop
		
		set playerUsed = null
	endfunction

endlibrary