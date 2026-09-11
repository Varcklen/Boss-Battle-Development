scope GameMusic initializer init

	globals
		private string array BattleMusicList
		private integer BattleMusicList_Max
		
		private string array RestMusicList
		private integer RestMusicList_Max
	endglobals
	
	private function SetData takes nothing returns nothing
		set udg_base = 0
		set BattleMusicList[BaseNum()] = gg_snd_ArthasTheme
		set BattleMusicList[BaseNum()] = gg_snd_OrcX1
		set BattleMusicList_Max = udg_base
		
		set udg_base = 0
		set RestMusicList[BaseNum()] = gg_snd_Human1
		set RestMusicList[BaseNum()] = gg_snd_Human2
		set RestMusicList[BaseNum()] = gg_snd_Human3
		set RestMusicList_Max = udg_base
	endfunction

	private function OnBattleStart takes nothing returns nothing
		call StopMusic( false )
		call ClearMapMusic()
		
		if udg_Boss_LvL >= 10 and udg_fightmod[1] then
			call PlayMusicBJ( gg_snd_PursuitTheme )
		else
	        call PlayMusicBJ( BattleMusicList[GetRandomInt(1, BattleMusicList_Max)] )
			call VolumeGroupSetVolume( SOUND_VOLUMEGROUP_MUSIC, 0.7 )
		endif
	endfunction
	
	//===========================================================================
	private function OnBattleEnd_Condition takes nothing returns boolean
		return IsVictory == false
	endfunction
	
	private function OnBattleEnd takes nothing returns nothing
		call StopMusic( false )
        call ClearMapMusic()
        
        call PlayMusicBJ( RestMusicList[GetRandomInt(1, RestMusicList_Max)] )
		call VolumeGroupSetVolume( SOUND_VOLUMEGROUP_MUSIC, 0.7 )
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		call BattleStartGlobal.AddListener(function OnBattleStart, null )
		call BattleEndGlobal.AddListener(function OnBattleEnd, function OnBattleEnd_Condition )
		call SetData()
	endfunction

endscope