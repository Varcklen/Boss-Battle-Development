library Potion requires Trigger

	globals
	    integer array PotionsUsedPerBattle[5]
	    
	    real Event_PotionUsed = 0
	    unit Event_PotionUsed_Unit
	endglobals
	
	function potionst takes unit caster returns nothing
	    local integer id = GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "lqsf" ) ) )
	    local integer i = GetPlayerId( GetOwningPlayer( caster ) ) + 1
	    local string str
	    local item it
	    
	    if udg_combatlogic[i] and not(udg_fightmod[3]) then
	        set udg_PotionsUsed[i] = udg_PotionsUsed[i] + 1 
	        if inv( caster, 'I0BA' ) > 0 then
	            set it = GetItemOfTypeFromUnitBJ(caster, 'I0BA')
	            if udg_PotionsUsed[i] == 5 then
	                call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", GetUnitX( caster ), GetUnitY( caster ) ) )
	                set str = words( caster, BlzGetItemDescription(it), "|cFF959697(", ")|r", "Active!" )
	                call BlzSetItemExtendedTooltip( it, str ) // sadtwig
	                //call BlzSetItemIconPath( it, str )
	            elseif udg_PotionsUsed[i] < 5 then
	                set str = words( caster, BlzGetItemDescription(it), "|cFF959697(", ")|r", I2S( udg_PotionsUsed[i] ) + "/5" )
	                call BlzSetItemExtendedTooltip( it, str ) // sadtwig
	                //call BlzSetItemIconPath( it, str )
	            endif
	        endif
	    endif
	    if inv(caster, 'I01Y') > 0 then
	        set PotionsUsedPerBattle[i] = PotionsUsedPerBattle[i] + 1
	    endif
	    
	    //set Trigger_GlobalEventUnit = caster
	    set Event_PotionUsed_Unit = caster
	    set Event_PotionUsed = 1
	    set Event_PotionUsed = 0
	    //set Trigger_GlobalEventUnit = null
	    
	    call PotionUsed.SetDataUnit("caster", caster)
	    call PotionUsed.Invoke()
	    
	    set it = null
	endfunction

endlibrary