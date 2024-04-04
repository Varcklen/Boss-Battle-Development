library IndicatorSystem initializer init requires CommonTimer

	globals
		private effect temp_Effect = null
		
		private string STRING_HASH_STRING = "particle_delete"
		private integer STRING_HASH = StringHash(STRING_HASH_STRING)
		
		constant integer INDICATOR_SKULL = 0
		constant integer INDICATOR_AIM = 1
		constant integer INDICATOR_WARNING = 2
		
		private Indicator array Indicators
		private integer Indicators_Max = 0
		
		private effect array ParticlesCreated
		private integer ParticlesCreated_Max = 0
	endglobals
	
	struct Indicator
		private string Path
		readonly real BaseSize
		readonly boolean HideImmediately
		
		private string PathAlt = null
		private integer SizeAlt = 0
		
		static method create takes real baseSize, boolean hideImmediately, string path returns thistype
			local thistype p = thistype.allocate()
			
			set p.Path = path
			set p.BaseSize = baseSize
			set p.HideImmediately = hideImmediately
			
			set Indicators[Indicators_Max] = p
			set Indicators_Max = Indicators_Max + 1
			
            return p
        endmethod
        
        method SetAlt takes integer sizeAlt, string pathAlt returns nothing
			set .SizeAlt = sizeAlt
			set .PathAlt = pathAlt
        endmethod
        
        method GetPath takes real size returns string
        	//call BJDebugMsg("size: " + R2S(size))
        	//call BJDebugMsg(".SizeAlt: " + R2S(.SizeAlt))
			if .PathAlt != null and size >= .SizeAlt then
				//call BJDebugMsg(".PathAlt: " + .PathAlt )
				return .PathAlt
			endif
			//call BJDebugMsg(".Path: " + .Path )
			return .Path
        endmethod
	endstruct
	
	private function SetData takes nothing returns nothing
		local Indicator indicator
		call Indicator.create(1, false, "war3mapImported\\AuraOfDeath.mdx")
		set indicator = Indicator.create(1,false, "war3mapImported\\Indicator_Aim.mdx")
		call indicator.SetAlt( 150, "war3mapImported\\Indicator_Aim_Thin.mdx")
		call Indicator.create(1.25, true, "war3mapImported\\BossColor.mdx")
	endfunction
	
	private function ClearParticles takes nothing returns nothing
		local integer i = 0
		local integer iMax = ParticlesCreated_Max
		
		loop
			exitwhen i >= iMax
			call DestroyEffect( ParticlesCreated[i] )
			set i = i + 1
		endloop
		set ParticlesCreated_Max = 0
	endfunction

	private function end takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer() )
		local effect particle = LoadEffectHandle(udg_hash, id, STRING_HASH )
		local Indicator indicator = LoadInteger(udg_hash, id, STRING_HASH )
		
		if indicator.HideImmediately then
			call BlzSetSpecialEffectZ( particle, -1000 )
		endif
		call DestroyEffect( particle )
		
		call FlushChildHashtable( udg_hash, id )
		
		set particle = null
	endfunction

	public function Create takes integer indicatorType, real x, real y, real area, real duration returns effect
		local Indicator indicator = Indicators[indicatorType]
		local integer id
		
		set temp_Effect = AddSpecialEffect( indicator.GetPath(area), x, y )
		call BlzSetSpecialEffectScale( temp_Effect, area / 100 * indicator.BaseSize )
		call BlzSetSpecialEffectColorByPlayer( temp_Effect, Player(12) ) //Red Color
		
		set id = InvokeTimerWithEffect( temp_Effect, STRING_HASH_STRING, duration, false, function end )
		call SaveInteger(udg_hash, id, STRING_HASH, indicator)
		
		set ParticlesCreated[ParticlesCreated_Max] = temp_Effect
		set ParticlesCreated_Max = ParticlesCreated_Max + 1
		
		return temp_Effect
	endfunction
	
	private function init takes nothing returns nothing
		call SetData()
		call BattleEndGlobal.AddListener( function ClearParticles, null)
	endfunction
	
endlibrary