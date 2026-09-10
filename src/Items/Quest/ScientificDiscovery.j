scope ScientificDiscovery initializer init

	globals
		private constant integer QUEST_ID = 'I0BX'
		private constant integer QUEST_REWARD_ID = 'I0BY'
		private constant integer USES_REQUIRED = 10
		
		private constant integer HASH_KEY = StringHash( "scientific_discovery" )
	endglobals

	private function condition takes nothing returns boolean
		return inv( ItemUsed.TriggerUnit, QUEST_ID ) > 0 and combat( ItemUsed.TriggerUnit, false, 0 ) and ExtraArenaGeneral_IsPvPActive() == false
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = ItemUsed.GetDataUnit("caster")
		local integer id = GetHandleId( caster )
		local integer counter = LoadInteger( udg_hash, id, HASH_KEY ) + 1
		local string text
		local item questItem

        call SaveInteger( udg_hash, id, HASH_KEY, counter )

		set questItem = GetItemOfTypeFromUnitBJ( caster, QUEST_ID)
		set text = words( caster, BlzGetItemDescription(questItem), "|cffffffff", "|r", I2S(USES_REQUIRED - counter) )
		call BlzSetItemExtendedTooltip( questItem, text )
		call Quest_QuestCondition( caster, QUEST_ID, QUEST_REWARD_ID, counter, USES_REQUIRED )
		
		set questItem = null
		set caster = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call ItemUsed.AddListener(function action, function condition)
	endfunction

endscope