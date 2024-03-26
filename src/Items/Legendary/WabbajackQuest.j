scope WabbajackQuest initializer init

	globals
		private constant integer QUEST_ID = 'I096'
		private constant integer REWARD_ID = 'I03E'
	endglobals

	private function condition takes nothing returns boolean
    	return /*inv( GetSpellAbilityUnit(), 'I096' ) > 0 and*/ combat( GetSpellAbilityUnit(), false, 0 ) and not( udg_fightmod[3] )
	endfunction
	
	private function action takes nothing returns nothing
	    local integer i = GetPlayerId(GetOwningPlayer(GetSpellAbilityUnit())) + 1
	    local integer id = GetHandleId( udg_hero[i] )
	    local integer s = LoadInteger( udg_hash, id, StringHash( udg_QuestItemCode[9] ) ) + 1
	    
	    call SaveInteger( udg_hash, id, StringHash( udg_QuestItemCode[9] ), s )
	
	    if s >= udg_QuestNum[9] then
	        call SetWidgetLife( GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), QUEST_ID), 0. )
	        set bj_lastCreatedItem = CreateItem( REWARD_ID, GetUnitX(GetSpellAbilityUnit()), GetUnitY(GetSpellAbilityUnit()))
	        call UnitAddItem(GetSpellAbilityUnit(), bj_lastCreatedItem)
	        call textst( "|c00ffffff Skill Show done!", GetSpellAbilityUnit(), 64, GetRandomReal( 45, 135 ), 12, 1.5 )
	        call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\ReviveHuman\\ReviveHuman.mdl", GetUnitX(GetSpellAbilityUnit()), GetUnitY(GetSpellAbilityUnit()) ) )
	        set udg_QuestDone[i] = true
	    else
	        call QuestDiscription( GetSpellAbilityUnit(), QUEST_ID, s, udg_QuestNum[9] )
	    endif
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    /*set gg_trg_WBJG = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( gg_trg_WBJG, EVENT_PLAYER_UNIT_SPELL_EFFECT )
	    call TriggerAddCondition( gg_trg_WBJG, Condition( function Trig_WBJG_Conditions ) )
	    call TriggerAddAction( gg_trg_WBJG, function Trig_WBJG_Actions )*/
	    
	    call RegisterDuplicatableItemType(QUEST_ID, EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	endfunction

endscope