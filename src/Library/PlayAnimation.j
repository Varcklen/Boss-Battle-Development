library PlayAnimation requires DeathLib

	globals
		private constant string STEAL_ANIMATION = "Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl"
		private constant string PROJECTILE_MODEL = "Objects\\InventoryItems\\TreasureChest\\treasurechest.mdl"
		private constant string RAY_MODEL = "DRAM"
		private constant real ANIMATION_TICK = 0.04
		private constant integer ANIMATION_SPEED = 25
		private constant integer RANGE_END = 50
	endglobals

	private function AnimationChange takes integer id, timer timerUsed returns nothing
		local effect projectile = 		LoadEffectHandle( udg_hash, id, StringHash("steal_animation_projectile") )
		local location vaultLoc = 		LoadLocationHandle(udg_hash, id, StringHash("steal_animation_vault_loc") )
		local location projectileLoc = 	LoadLocationHandle(udg_hash, id, StringHash("steal_animation_proj_loc") )
		local lightning ray = 			LoadLightningHandle(udg_hash, id, StringHash("steal_animation_ray") )
		local real angle = 				AngleBetweenPoints(projectileLoc, vaultLoc)
		local location newLoc = 		PolarProjectionBJ(projectileLoc, ANIMATION_SPEED, angle)
		
		/*call BJDebugMsg("DistanceBetweenPoints: " + R2S(DistanceBetweenPoints(vaultLoc, newLoc)) )
		call BJDebugMsg("angle: " + R2S(angle) )*/
		
		if DistanceBetweenPoints(vaultLoc, newLoc) <= RANGE_END then
			//call BJDebugMsg("end" )
			call RemoveLocation(newLoc)
			call RemoveLocation(vaultLoc)
			call DestroyLightning(ray)
			call DestroyEffect(projectile)
			call DestroyTimer( timerUsed )
	        call FlushChildHashtable( udg_hash, id )
		else
			call SaveLocationHandle(udg_hash, id, StringHash("steal_animation_proj_loc"), newLoc )
			call BlzSetSpecialEffectPositionLoc(projectile, newLoc)
			call MoveLightningLoc(ray, vaultLoc, newLoc)
		endif
		
		call RemoveLocation(projectileLoc)
		set newLoc = null
		set vaultLoc = null
		set ray = null
		set projectile = null
		set projectileLoc = null
	endfunction
	
	private function AnimationTick takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer() )
		local unit vault = LoadUnitHandle( udg_hash, id, StringHash("steal_animation_vault") )
		
		if IsUnitDead(vault) then
			//call BJDebugMsg("vault dead" )
			call DestroyTimer( GetExpiredTimer() )
	        call FlushChildHashtable( udg_hash, id )
		else
			call AnimationChange(id, GetExpiredTimer() )
		endif
		
		set vault = null
	endfunction
	
	public function ItemSteal takes unit hero, unit vault returns nothing
		local location heroLoc = GetUnitLoc(hero)
		local location vaultLoc = GetUnitLoc(vault)
		local lightning ray
		local effect projectile 
		local integer id
		
		set ray = AddLightningLoc( RAY_MODEL, vaultLoc, heroLoc )
		set projectile = AddSpecialEffectLoc( PROJECTILE_MODEL, heroLoc )
		call BlzSetSpecialEffectYaw( projectile, Deg2Rad(270) )
		
		set id = InvokeTimerWithEffect( projectile, "steal_animation_projectile", ANIMATION_TICK, true, function AnimationTick )
		call SaveLocationHandle(udg_hash, id, StringHash("steal_animation_vault_loc"), vaultLoc )
		call SaveLocationHandle(udg_hash, id, StringHash("steal_animation_proj_loc"), heroLoc )
		call SaveLightningHandle(udg_hash, id, StringHash("steal_animation_ray"), ray )
		call SaveUnitHandle(udg_hash, id, StringHash("steal_animation_vault"), vault )
		
		call DestroyEffect( AddSpecialEffectTarget( STEAL_ANIMATION, hero, "origin" ) )

		set heroLoc = null
		set vaultLoc = null
		set ray = null
		set projectile = null
	endfunction

endlibrary