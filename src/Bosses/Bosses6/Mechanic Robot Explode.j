scope MechanicRobotExplode initializer init

	globals
		private constant integer DAMAGE = 300
		private constant integer AREA = 300
		private constant real DELAY = 1.5
		private constant string EXPLOSION_ANIMATION = "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl"
		private constant real ANIMATION_SIZE = AREA / 150
	endglobals

	private function condition takes nothing returns boolean
	    return GetUnitTypeId(GetDyingUnit()) == 'n012'
	endfunction
	
	private function Explode takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer( ) )
        local unit dummy = LoadUnitHandle(udg_hash, id, StringHash( "sheep_explode" ) )
        local effect model = LoadEffectHandle( udg_hash, id, StringHash("sheep_explode_model") )
        local effect explosion
        local location dummyLoc = GetUnitLoc(dummy)

		set explosion = AddSpecialEffectLoc( EXPLOSION_ANIMATION, dummyLoc )
		call BlzSetSpecialEffectScale( explosion, ANIMATION_SIZE )
		call DestroyEffect( explosion )
		
	    call GroupAoE( dummy, GetUnitX( dummy ), GetUnitY( dummy ), DAMAGE, AREA, "enemy", null, null )
	    
	    call DestroyEffect( model )
	    call RemoveUnit(dummy)
        call FlushChildHashtable( udg_hash, id )
        
        call RemoveLocation(dummyLoc)
        set dummyLoc = null
        set explosion = null
        set model = null
        set dummy = null
    endfunction
	
	private function action takes nothing returns nothing
		local unit caster = GetDyingUnit()
		local unit dummy
		local integer id
		local effect model
		local real x = GetUnitX( caster )
		local real y = GetUnitY( caster )
		local real angle = GetUnitFacing(caster)
		
		call ShowUnitHide(caster)
		
	    set dummy = CreateUnit( GetOwningPlayer(caster), 'u000', x, y, angle )
	    call IndicatorSystem_Create( INDICATOR_WARNING, x, y, AREA, DELAY, dummy)
	    
	    set model = AddSpecialEffect( "war3mapImported\\ExplosiveSheep.mdl", x, y )
	    call BlzSetSpecialEffectScale( model, 2 )
	    call BlzSetSpecialEffectYaw( model, Deg2Rad( angle ) )
	    call BlzSetSpecialEffectAnimation( model, "stand 2" )
	    
	    set id = InvokeTimerWithUnit( dummy, "sheep_explode", DELAY, true, function Explode )
	    call SaveEffectHandle( udg_hash, id, StringHash("sheep_explode_model"), model )

		set caster = null
		set dummy = null
		set model = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, function condition )
	endfunction

endscope