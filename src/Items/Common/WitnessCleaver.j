scope WitnessCleaver initializer init

    globals
        private constant integer ITEM_ID = 'I0HS'
        
        private constant integer EXTRA_SP = 2
        private constant integer COOLDOWN = 15
    endglobals

    private function condition takes nothing returns boolean 
        return GetItemTypeId(GetManipulatedItem()) == ITEM_ID 
    endfunction 

    private function WitnessTick takes nothing returns nothing 
        local integer id = GetHandleId( GetExpiredTimer( ) )
        local unit hero = LoadUnitHandle( udg_hash, id, StringHash( "witcih" ) )
        local item it = LoadItemHandle( udg_hash, id, StringHash( "witci" ) )
        local integer heroId =  GetHandleId( hero )
        local integer bonusSP = LoadInteger(udg_hash, heroId, StringHash( "witcsp" ) )
        
        if not(UnitHasItem(hero,it)) then
            call DestroyTimer( GetExpiredTimer() )
        elseif IsUnitAlive(hero) and combat(hero, false, 0) then
            call spdst(hero, EXTRA_SP)
            call SaveInteger(udg_hash, heroId, StringHash( "witcsp" ), bonusSP + EXTRA_SP )
        endif
        
        set hero = null
        set it = null
    endfunction

	private function Launch takes unit caster, item it returns nothing
		local integer id
		
		set id = InvokeTimerWithItem(it, "witci", COOLDOWN, true, function WitnessTick )
        call SaveUnitHandle( udg_hash, id, StringHash( "witcih" ), caster )
	endfunction

    private function action takes nothing returns nothing
        local unit caster = GetManipulatingUnit()
        local item it = GetManipulatedItem()

        call Launch(caster, it)

        set caster = null
        set it = null
    endfunction
    
    private function FightEnd_Conditions takes nothing returns boolean
        return LoadInteger(udg_hash, GetHandleId( udg_FightEnd_Unit ), StringHash( "witcsp" ) ) > 0
    endfunction
    
    private function FightEnd takes nothing returns nothing
        local unit hero = udg_FightEnd_Unit
        local integer heroId =  GetHandleId( hero )
        local integer bonusSP = LoadInteger(udg_hash, heroId, StringHash( "witcsp" ) )

        call spdst(hero, -bonusSP)
        call SaveInteger(udg_hash, heroId, StringHash( "witcsp" ), 0 )
        
        set hero = null
    endfunction
    
    public function Enable takes nothing returns nothing
		call Launch(WeaponPieceSystem_WeaponData.TriggerUnit, WeaponPieceSystem_WeaponData.TriggerItem)
    	call BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A1HL' )
    endfunction
    
    public function Disable takes nothing returns nothing
		call BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A1HL' )
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
        
        call CreateEventTrigger( "udg_FightEnd_Real", function FightEnd, function FightEnd_Conditions )
    endfunction

endscope
