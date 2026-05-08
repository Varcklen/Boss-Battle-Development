scope HeartySoup initializer init

	globals
		private constant integer ITEM_TYPE = 'IV18'
		private constant integer GOLD_BONUS = 20
		private constant integer DAMAGE_BONUS = 20
		
		private constant integer HASH_KEY = StringHash( "soup_bonus" )
		private string ICON_FRAME = "war3mapImported\\BTNStartingBonus_15.blp"
		private constant string DESCRIPTION = "These players are stronger in additional arenas, where they receive 20% more gold and deal 20% more damage: "
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local player usedPlayer = GetOwningPlayer(GetManipulatingUnit())
		local integer index = GetPlayerId(usedPlayer) + 1
		local integer id = GetHandleId(usedPlayer)
		local string characters = LoadStr(udg_hash, id, HASH_KEY)
		
		if characters != null then
			set characters = characters + ", "
		endif
		set characters = characters + udg_Player_Color[index] + GetPlayerName(usedPlayer) + "|r"
		call SaveStr(udg_hash, id, HASH_KEY, characters)

		call SaveBoolean(udg_hash, id, HASH_KEY, true)
		call IconFrame( "HeartySoup", ICON_FRAME, GetItemName(GetManipulatedItem()), DESCRIPTION + characters )
		
		set usedPlayer = null
	endfunction

	//===========================================================================
	private function OnStart_Condition takes nothing returns boolean
		return ExtraArenaGeneral_IsArenaActive() and LoadBoolean(udg_hash, GetHandleId( GetOwningPlayer(BattleEnd.GetDataUnit("caster")) ), HASH_KEY)
	endfunction

	private function OnStart takes nothing returns nothing
		local unit hero = BattleEnd.GetDataUnit("caster")
		
		call StatSystem_Add(hero, STAT_DAMAGE_DEALT, DAMAGE_BONUS)
		call StatSystem_Add(hero, STAT_GOLD_GAIN, GOLD_BONUS)

		set hero = null
	endfunction
	
	//===========================================================================
	private function OnEnd_Condition takes nothing returns boolean
		return ExtraArenaGeneral_IsArenaActive() and LoadBoolean(udg_hash, GetHandleId( GetOwningPlayer(BattleEnd.GetDataUnit("caster")) ), HASH_KEY)
	endfunction

	private function OnEnd takes nothing returns nothing
		local unit hero = BattleEnd.GetDataUnit("caster")
		
		call StatSystem_Add(hero, STAT_DAMAGE_DEALT, -DAMAGE_BONUS)
		call StatSystem_Add(hero, STAT_GOLD_GAIN, -GOLD_BONUS)

		set hero = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	    
	    call BattleStart.AddListener(function OnStart, function OnStart_Condition)
	    call BattleEnd.AddListener(function OnEnd, function OnEnd_Condition)
	endfunction

endscope