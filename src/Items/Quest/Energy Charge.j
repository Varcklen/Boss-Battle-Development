scope EnergyCharge initializer init

	globals
		private constant integer QUEST_ID = 'I0HH'
		private constant integer REWARD_ID = 'I0HI'
		private constant integer HASH_KEY = StringHash("quest_energy_charge")
		private constant integer COUNT_SCALE = 50
		private integer COUNT_NEEDED = 1200
	endglobals

	private function condition takes nothing returns boolean
    	return inv( GetSpellAbilityUnit(), QUEST_ID ) > 0 and combat( GetSpellAbilityUnit(), false, 0 ) and not( udg_fightmod[3] )
	endfunction
	
	private function action takes nothing returns nothing
		local unit hero = GetSpellAbilityUnit()
		local item questItem = GetItemOfTypeFromUnitBJ( hero, QUEST_ID)
		local integer id = GetHandleId(questItem)
		local integer currentValue = LoadInteger(udg_hash, id, HASH_KEY)
		local integer abilityCast = GetSpellAbilityId()
		local integer level = GetUnitAbilityLevel( hero , abilityCast ) - 1
    	local integer manaUsed = BlzGetAbilityManaCost( abilityCast, level )
    	local boolean isCompleted
		
		set currentValue = currentValue + manaUsed
		
		set Quest_IsKeepQuest = true
		set isCompleted = Quest_QuestCondition( hero, QUEST_ID, REWARD_ID, currentValue, COUNT_NEEDED)
		if isCompleted then
			set currentValue = 0
			set COUNT_NEEDED = COUNT_NEEDED + COUNT_SCALE
		endif
		call BlzSetItemExtendedTooltip( questItem, words( hero, BlzGetItemDescription(questItem), "|cFF959697(", ")|r", I2S(currentValue) + "/" + I2S(COUNT_NEEDED) ) )
		call SaveInteger(udg_hash, id, HASH_KEY, currentValue) 
		
		set questItem = null
		set hero = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	endfunction

endscope