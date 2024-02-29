scope TremblingEnemies initializer init

	globals
		private constant integer ITEM_ID = 'I09B'
		private constant integer REWARD_ID = 'I092'
	endglobals

	private function condition takes nothing returns boolean
		return IsUnitAliveBJ(GetSpellAbilityUnit()) and inv( GetSpellAbilityUnit(), ITEM_ID ) > 0 and GetSpellAbilityId() == Database_Hero_Abilities[1][udg_HeroNum[GetUnitUserData(GetSpellAbilityUnit())]]  and combat( GetSpellAbilityUnit(), false, 0 ) and udg_fightmod[3] == false
	endfunction

	private function action takes nothing returns nothing
		local unit caster = GetSpellAbilityUnit()
		local integer i = GetPlayerId( GetOwningPlayer( caster ) ) + 1
		local integer s
		
		set s = LoadInteger( udg_hash, GetHandleId( caster ), StringHash( udg_QuestItemCode[6] ) ) + 1
        call SaveInteger( udg_hash, GetHandleId( caster ), StringHash( udg_QuestItemCode[6] ), s )

        if s >= udg_QuestNum[6] then
            call SetWidgetLife( GetItemOfTypeFromUnitBJ( caster, ITEM_ID), 0. )
            set bj_lastCreatedItem = CreateItem( REWARD_ID, GetUnitX(caster), GetUnitY(caster))
            call UnitAddItem(caster, bj_lastCreatedItem)
            call textst( "|c00ffffff Trembling Enemies done!", caster, 64, GetRandomReal( 45, 135 ), 12, 1.5 )
            call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\ReviveHuman\\ReviveHuman.mdl", GetUnitX(caster), GetUnitY(caster) ) )
            set udg_QuestDone[i] = true
        else
            call QuestDiscription( caster, ITEM_ID, s, udg_QuestNum[6] )
        endif
		
		set caster = null
	endfunction
	
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger()
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope