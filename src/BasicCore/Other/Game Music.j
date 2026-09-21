library GameMusic initializer init requires LibDataItems

	globals
		private string array BattleMusicList
		private integer BattleMusicList_Max
		
		private string array RestMusicList
		private integer RestMusicList_Max
		
		private string array LastBossMusicList
		private integer LastBossMusicList_Max
		
		private constant real VOLUME_MULTIPLIER = 0.7
	endglobals
	
	private function SetData takes nothing returns nothing
		set udg_base = 0
		set BattleMusicList[BaseNum()] = gg_snd_ArthasTheme
		set BattleMusicList[BaseNum()] = gg_snd_OrcX1
		set BattleMusicList[BaseNum()] = gg_snd_Battle_A
		set BattleMusicList[BaseNum()] = gg_snd_Battle_B
		set BattleMusicList[BaseNum()] = gg_snd_Orc3
		set BattleMusicList_Max = udg_base
		
		set udg_base = 0
		set LastBossMusicList[BaseNum()] = gg_snd_PursuitTheme
		set LastBossMusicList[BaseNum()] = gg_snd_Battle_Intense_C
		set LastBossMusicList_Max = udg_base
		
		set udg_base = 0
		set RestMusicList[BaseNum()] = gg_snd_Human1
		set RestMusicList[BaseNum()] = gg_snd_Human2
		set RestMusicList[BaseNum()] = gg_snd_Human3
		set RestMusicList[BaseNum()] = gg_snd_Forsaken1Calm
		set RestMusicList[BaseNum()] = gg_snd_Forsaken3
		set RestMusicList_Max = udg_base
	endfunction
	
	public function PlayTrack takes string musicTrack, boolean setVolumeMultiplier returns nothing
		call StopMusic( false )
		call ClearMapMusic()
		call PlayMusicBJ( musicTrack )
		
		if setVolumeMultiplier then
			call VolumeGroupSetVolume( SOUND_VOLUMEGROUP_MUSIC, VOLUME_MULTIPLIER )
		endif
	endfunction
	
	private function OnBattleStart takes nothing returns nothing
		if udg_Boss_LvL >= 10 and udg_fightmod[1] then
			call PlayTrack( LastBossMusicList[GetRandomInt(1, LastBossMusicList_Max)], false )
		else
	        call PlayTrack( BattleMusicList[GetRandomInt(1, BattleMusicList_Max)], true )
		endif
	endfunction
	
	//===========================================================================
	private function OnBattleEnd_Condition takes nothing returns boolean
		return IsVictory == false
	endfunction
	
	private function OnBattleEnd takes nothing returns nothing
        call PlayTrack( RestMusicList[GetRandomInt(1, RestMusicList_Max)], true )
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		call BattleStartGlobal.AddListener(function OnBattleStart, null )
		call BattleEndGlobal.AddListener(function OnBattleEnd, function OnBattleEnd_Condition )
		call SetData()
	endfunction

endlibrary