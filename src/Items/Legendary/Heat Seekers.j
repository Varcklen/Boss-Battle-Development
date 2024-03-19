scope HeatSeeker initializer init
	
	globals
		private constant integer ITEM_ID = 'I070'
		
		private constant integer DAMAGE = 125
		private constant integer PROJECTILE_MOVE_SPEED = 400
		
		private constant integer SEARCH_RANGE = 1200
		private constant real TICK = 0.2
		private constant integer ACTIVATION_RANGE = 50
		
		private constant integer COOLDOWN = 10
		private constant integer STRING_HASH = StringHash( "heat_seeker" )
		
		private constant string DEATH_ANIMATION = "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl"
	endglobals
	
	private function condition takes nothing returns boolean 
		return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction 
	
	private function RemoveProjectile takes unit projectile returns nothing
		call DestroyEffect( AddSpecialEffect( DEATH_ANIMATION, GetUnitX(projectile), GetUnitY(projectile)) )
        call RemoveUnit( projectile )
        call DestroyTimer( GetExpiredTimer() )
	endfunction
	
	private function Fly takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit projectile = LoadUnitHandle( udg_hash, id, StringHash( "heat_seeker" ) )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "heat_seeker_target" ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "heat_seeker_caster" ) )
	    local boolean isProjectileAlive = IsUnitAliveBJ(projectile)
	    local boolean isTargetAlive = IsUnitAliveBJ(target)
	    
	    if isTargetAlive and isProjectileAlive then
	        if DistanceBetweenUnits(target, projectile) < ACTIVATION_RANGE then
	            call UnitDamageTarget(caster, target, DAMAGE, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
	            call RemoveProjectile(projectile)
	        else
	            call IssuePointOrder( projectile, "move", GetUnitX( target ), GetUnitY( target ) )
	        endif
	    elseif isProjectileAlive and isTargetAlive == false then
	        set target = randomtarget( projectile, SEARCH_RANGE, "enemy", "", "", "", "" )
	        if target == null then
	        	call RemoveProjectile(projectile)
	        else
	            call IssuePointOrder( projectile, "move", GetUnitX( target ), GetUnitY( target ) )
	            call SaveUnitHandle( udg_hash, id, StringHash( "heat_seeker_target" ), target )
	        endif
	    elseif isProjectileAlive == false then
	        call RemoveProjectile(projectile)
	    endif
	    
	    set caster = null
	    set target = null
	    set projectile = null
	endfunction
	
	private function CreateProjectile takes unit hero returns boolean
		local integer id
	    local unit target
	    local unit projectile
	
		set target = randomtarget( hero, SEARCH_RANGE, "enemy", "", "", "", "" )
        if target == null then
        	return false
        endif
        
        set projectile = dummyspawn( hero, 0, 'A0Z7', 0, 0 )
        call SetUnitMoveSpeed( projectile, PROJECTILE_MOVE_SPEED )
        call IssuePointOrder( projectile, "move", GetUnitX( target ), GetUnitY( target ) )
        
        set id = InvokeTimerWithUnit( projectile, "heat_seeker", TICK, true, function Fly )
        call SaveUnitHandle( udg_hash, id, StringHash( "heat_seeker_target" ), target )
        call SaveUnitHandle( udg_hash, id, StringHash( "heat_seeker_caster" ), hero )
        
        set target = null
        set projectile = null
        return true
	endfunction
	
	private function Start takes unit hero returns nothing
		local integer mechAmount = SetCount_GetPieces(hero, SET_MECH)
	    local integer i
	    local boolean projectileCreated = true
	    //local integer i = GetUnitUserData(u)
		
        call BlzStartUnitAbilityCooldown( hero, 'A163', COOLDOWN )
        set i = 1
        loop
            exitwhen i > mechAmount or projectileCreated == false
            set projectileCreated = CreateProjectile(hero)
            set i = i + 1
        endloop
    endfunction
	
	private function Cast takes nothing returns nothing 
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit owner = LoadUnitHandle( udg_hash, id, StringHash( "heat_seeker_cd_owner" ) )
	    local item itemUsed = LoadItemHandle( udg_hash, id, StringHash( "heat_seeker_cd" ) )

	    if UnitHasItem( owner, itemUsed ) == false then
	        call DestroyTimer( GetExpiredTimer() )
	    elseif IsUnitAlive( owner ) and IsUnitLoaded( owner ) == false then
	    	call Start( owner )
	    endif
	    
	    set itemUsed = null
	    set owner = null
	endfunction 
	
	private function action takes nothing returns nothing 
		local integer id
		
		set id = InvokeTimerWithItem( GetManipulatedItem(), "heat_seeker_cd", COOLDOWN, true, function Cast )
		call SaveUnitHandle( udg_hash, id, StringHash( "heat_seeker_cd_owner" ), GetManipulatingUnit() ) 
	    /*if LoadTimerHandle( udg_hash, id, StringHash( "htskr" ) ) == null  then
	        call SaveTimerHandle( udg_hash, id, StringHash( "htskr" ), CreateTimer() )
	    endif 
		set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "htskr" ) ) ) 
		call SaveUnitHandle( udg_hash, id, StringHash( "htskr" ), GetManipulatingUnit() ) 
	    call SaveItemHandle( udg_hash, id, StringHash( "htskrt" ), GetManipulatedItem() ) 
		call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( GetManipulatedItem() ), StringHash( "htskr" ) ), COOLDOWN, true, function Cast ) */
	endfunction 
	
	//=========================================================================== 
	private function init takes nothing returns nothing 
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
		/*set gg_trg_Heat_Seekers = CreateTrigger( ) 
		call TriggerRegisterAnyUnitEventBJ( gg_trg_Heat_Seekers, EVENT_PLAYER_UNIT_PICKUP_ITEM ) 
		call TriggerAddCondition( gg_trg_Heat_Seekers, Condition( function Trig_Heat_Seekers_Conditions ) ) 
		call TriggerAddAction( gg_trg_Heat_Seekers, function Trig_Heat_Seekers_Actions ) */
	endfunction
endscope