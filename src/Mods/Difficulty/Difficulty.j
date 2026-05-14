library Difficulty initializer init requires Multiboard, SpellPower

	globals
    	constant integer DIFFICULTY_MAX = 5
    	private constant string STATIC_DESCRIPTION = "Enemies are stronger.|n"
    	
    	private string Difficulty_Name = "Normal"
    	
    	private framehandle modesdiftool = null
    	private framehandle modesdificon = null
    	private framehandle modesdifname = null
	endglobals

	private function Setup_DB takes nothing returns nothing
		set udg_DB_ModesFrame_DifficultyNum = DIFFICULTY_MAX
	    set udg_DB_ModesFrame_Difficulty[0] = 'A0EH'
	    set udg_DB_ModesFrame_Difficulty[1] = 'A043'
	    set udg_DB_ModesFrame_Difficulty[2] = 'A046'
	    set udg_DB_ModesFrame_Difficulty[3] = 'A047'
	    set udg_DB_ModesFrame_Difficulty[4] = 'A045'
	    set udg_DB_ModesFrame_Difficulty[5] = 'A048'
	    /*set udg_DB_ModesFrame_Difficulty[6] = 'A04H'
	    set udg_DB_ModesFrame_Difficulty[7] = 'AZD1'
	    set udg_DB_ModesFrame_Difficulty[8] = 'AZD2'
	    set udg_DB_ModesFrame_Difficulty[9] = 'AZD3'*/
	    
	    set udg_DB_Hardest[0] = "Common +0"
	    set udg_DB_Hardest[1] = "Rare +1"
	    set udg_DB_Hardest[2] = "Epic +2"
	    set udg_DB_Hardest[3] = "Legendary +3"
	    set udg_DB_Hardest[4] = "Mythical +4"
	    set udg_DB_Hardest[5] = "Horrific +5"
	    /*set udg_DB_Hardest[6] = "Monstrous +6"
	    set udg_DB_Hardest[7] = "Demonic +7"
	    set udg_DB_Hardest[8] = "Diabolic +8"
	    set udg_DB_Hardest[9] = "Infernal +9"*/
	    //set udg_DB_Hardest_On[0] = 'A0EH'
	    set udg_DB_Hardest_On[1] = 'A043'
	    set udg_DB_Hardest_On[2] = 'A046'
	    set udg_DB_Hardest_On[3] = 'A047'
	    set udg_DB_Hardest_On[4] = 'A045'
	    set udg_DB_Hardest_On[5] = 'A048'
	    /*set udg_DB_Hardest_On[6] = 'A04H'
	    set udg_DB_Hardest_On[7] = 'AZD1'
	    set udg_DB_Hardest_On[8] = 'AZD2'
	    set udg_DB_Hardest_On[9] = 'AZD3'*/
	    
	    set udg_HardModBonus[1] = 'A0CA'
	    set udg_HardModBonus[2] = 'A0CG'
	    set udg_HardModBonus[3] = 'A05S'
	    set udg_HardModBonus[4] = 'A07Q'
	    
	    set HardModAspd[0]=1.0
	    set HardModAspd[1]=1.4
	    set HardModAspd[2]=1.8
	    set HardModAspd[3]=2.2
	    set HardModAspd[4]=2.6
	    set HardModAspd[5]=3.0
	    /*set HardModAspd[6]=2.2
	    set HardModAspd[7]=2.4
	    set HardModAspd[8]=2.6
	    set HardModAspd[9]=2.8*/
	endfunction
	
	private function GenerateDescription takes nothing returns string
		local string description = "- " + STATIC_DESCRIPTION
		local integer i = 1
		
		loop
			exitwhen i > udg_HardNum
			set description = description + "- " + BlzGetAbilityExtendedTooltip(udg_DB_Hardest_On[i], 0)
			if i < udg_HardNum then
				set description = description + "|n"
			endif
			set i = i + 1
		endloop
		//
		return description
	endfunction
	
	private function onModsAwake takes nothing returns nothing
		local integer difAbilityType
		if udg_HardNum <= 0 then
            return
        endif
        call EnableTrigger( DifficultyUnitSpawn_Trigger )
        call SpellPower_AddBossSpellPower(udg_HardNum * 0.4)

        set difAbilityType = udg_DB_Hardest_On[udg_HardNum]
        call IconFrame( "HardMode", BlzGetAbilityIcon(difAbilityType), BlzGetAbilityTooltip(difAbilityType, 0), GenerateDescription() )
	endfunction
	
	public function GetIndex takes nothing returns integer
		return udg_HardNum
	endfunction
	
	public function GetName takes nothing returns string
		return Difficulty_Name
	endfunction
	
	private function DifficultyEnd takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )

	    if udg_fightmod[0] == false then
	        call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5, "Difficulty |cffffcc00\"" + Difficulty_Name + "\"|r is activated." )
	    endif
	    call FlushChildHashtable( udg_hash, id )
	endfunction
	
	private function DifficultyChange takes player user, integer newValue returns nothing
		local integer id
		local string tooltipDescription
	
		//If change user is not the host, do nothing
		if udg_Host != user then
			return
		endif

        //If difficulty not changed, do nothing
        if newValue == udg_HardNum then
            return
        endif
        
        set newValue = IMinBJ(newValue, DIFFICULTY_MAX)
        set newValue = IMaxBJ(newValue, 0)
        
        set udg_HardNum = newValue
        set Difficulty_Name = udg_DB_Hardest[newValue]
        call MultiSetValue( udg_multi, 3, 2, Difficulty_Name )
        
        set tooltipDescription = BlzGetAbilityExtendedTooltip(udg_DB_ModesFrame_Difficulty[newValue], 0)
        if udg_HardNum > 0 then
        	set tooltipDescription = STATIC_DESCRIPTION + tooltipDescription
        endif
        
        call BlzFrameSetTexture( modesdificon, BlzGetAbilityIcon( udg_DB_ModesFrame_Difficulty[newValue]), 0, true )
        call BlzFrameSetText( modesdiftool, tooltipDescription )
        call BlzFrameSetText( modesdifname, "|cffffcc00" + Difficulty_Name )
        
        if udg_Heroes_Amount > 1 then
            set id = GetHandleId( user )
            if LoadTimerHandle( udg_hash, id, StringHash( "diff" ) ) == null  then
                call SaveTimerHandle( udg_hash, id, StringHash( "diff" ), CreateTimer() )
            endif
            call TimerStart( LoadTimerHandle( udg_hash, id, StringHash( "diff" ) ), 2, false, function DifficultyEnd )
        endif
	endfunction
	
	private function DifficultyMore takes nothing returns nothing
	    if GetLocalPlayer() == GetTriggerPlayer() then
	        call BlzFrameSetVisible( BlzGetTriggerFrame(),false)
			call BlzFrameSetVisible( BlzGetTriggerFrame(),true)
		endif
	    
	    call DifficultyChange(GetTriggerPlayer(), udg_HardNum + 1)
	endfunction
	
	private function DifficultyLess takes nothing returns nothing
	    if GetLocalPlayer() == GetTriggerPlayer() then
	        call BlzFrameSetVisible( BlzGetTriggerFrame(),false)
			call BlzFrameSetVisible( BlzGetTriggerFrame(),true)
		endif
	    
		call DifficultyChange(GetTriggerPlayer(), udg_HardNum - 1)
	endfunction
	
	public function Setup takes framehandle modesback returns nothing
		local framehandle framebase
		local framehandle frame
		local trigger trig
		
	    set framebase = BlzCreateFrame("QuestButtonBackdropTemplate", modesback, 0, 0)
	    call BlzFrameSetPoint(framebase, FRAMEPOINT_TOPLEFT, modesback, FRAMEPOINT_TOPLEFT, 0.005,-0.005) 
	    call BlzFrameSetSize(framebase, 0.25, 0.1)
	    
	    set modesdifname = BlzCreateFrameByType("TEXT", "", modesback, "StandartFrameTemplate", 0)
		call BlzFrameSetSize( modesdifname, 0.08, 0.02 )
		call BlzFrameSetPoint(modesdifname, FRAMEPOINT_TOP, framebase, FRAMEPOINT_TOP, 0.01,-0.01) 
		call BlzFrameSetText( modesdifname, "|cffffcc00" + udg_DB_Hardest[0] )
	    
	    set modesdificon = BlzCreateFrameByType("BACKDROP", "", modesback, "StandartFrameTemplate", 0)
		call BlzFrameSetSize( modesdificon, 0.04, 0.04 )
		call BlzFrameSetPoint(modesdificon, FRAMEPOINT_TOPLEFT, framebase, FRAMEPOINT_TOPLEFT, 0.035,-0.02) //0 
		call BlzFrameSetTexture( modesdificon, BlzGetAbilityIcon( udg_DB_ModesFrame_Difficulty[0]), 0, true )
	
	    set frame = BlzCreateFrame("ScriptDialogButton", modesback, 0,0) 
		call BlzFrameSetSize(frame, 0.03,0.03)
		call BlzFrameSetPoint(frame, FRAMEPOINT_TOPLEFT, framebase, FRAMEPOINT_TOPLEFT, 0.02,-0.06) //-0.02 
		call BlzFrameSetText(frame, "<")
	
	    set trig = CreateTrigger()
		call BlzTriggerRegisterFrameEvent(trig, frame, FRAMEEVENT_CONTROL_CLICK)
		call TriggerAddAction(trig, function DifficultyLess)
	    
	    set frame = BlzCreateFrame("ScriptDialogButton", modesback, 0,0) 
		call BlzFrameSetSize(frame, 0.03,0.03)
		call BlzFrameSetPoint(frame, FRAMEPOINT_TOPLEFT, framebase, FRAMEPOINT_TOPLEFT, 0.06,-0.06) //-0.02 
		call BlzFrameSetText(frame, ">")
	
	    set trig = CreateTrigger()
		call BlzTriggerRegisterFrameEvent(trig, frame, FRAMEEVENT_CONTROL_CLICK)
		call TriggerAddAction(trig, function DifficultyMore)
	    
	    set modesdiftool = BlzCreateFrameByType("TEXT", "", modesback, "StandartFrameTemplate", 0)
		call BlzFrameSetSize( modesdiftool, 0.14, 0.07 )
		call BlzFrameSetPoint(modesdiftool, FRAMEPOINT_TOP, framebase, FRAMEPOINT_TOP, 0.04,-0.02)
	    call BlzFrameSetText( modesdiftool, BlzGetAbilityExtendedTooltip(udg_DB_ModesFrame_Difficulty[0], 0) )
	    
	    set framebase = null
	    set frame = null
	    set trig = null
	endfunction

	private function init takes nothing returns nothing
		local trigger trig  = CreateTrigger()

	    call TriggerRegisterTimerExpireEvent( trig, udg_StartTimer )
	    call TriggerAddAction( trig, function Setup_DB )
	    
	    call OnModsAwake.AddListener(function onModsAwake, null)
	endfunction

endlibrary