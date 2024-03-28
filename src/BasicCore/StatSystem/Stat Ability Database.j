library StatAbilityDatabase initializer init requires StatAbility

  /*constant integer STAT_BUFF_DURATION = 0
	constant integer STAT_COOLDOWN = 1
	constant integer STAT_DAMAGE_DEALT = 2
	constant integer STAT_DAMAGE_DEALT_BOSSES = 3
	constant integer STAT_DAMAGE_DEALT_MINIONS = 4
	constant integer STAT_DAMAGE_DEALT_MINIONS_PHY = 5
	constant integer STAT_DAMAGE_DEALT_MAG = 6
	constant integer STAT_DAMAGE_DEALT_PHY = 7
	constant integer STAT_DAMAGE_TAKEN = 8
	constant integer STAT_DAMAGE_TAKEN_PHY = 9
	constant integer STAT_DODGE = 10
	constant integer STAT_GOLD_GAIN = 11
	constant integer STAT_HEAL_BONUS = 12
	constant integer STAT_HEAL_TAKEN = 13
	constant integer STAT_MANA_HEAL_BONUS = 14
	constant integer STAT_MOON_SET_DAMAGE_DEALT = 15
	constant integer STAT_VAMPIRISM = 16
	constant integer STAT_VAMPIRISM_MAG = 17
	constant integer STAT_VAMPIRISM_PHY = 18
	constant integer STAT_SHOP_DISCOUNT = 19*/

	private function delay takes nothing returns nothing
		//STAT_VAMPIRISM_PHY
		call ConnectAbilityToStat( 'A1F1', STAT_VAMPIRISM_PHY, 15 )
		call ConnectAbilityToStat( 'A1FI', STAT_VAMPIRISM_PHY, 10 )
		//STAT_VAMPIRISM_MAG
		call ConnectAbilityToStat( 'A1F2', STAT_VAMPIRISM_MAG, 20 )
		//STAT_VAMPIRISM
		call ConnectAbilityToStat( 'A1F3', STAT_VAMPIRISM, 60 )
		//STAT_HEAL_BONUS
		call ConnectAbilityToStat( 'A1F4', STAT_HEAL_BONUS, 150 )
		call ConnectAbilityToStat( 'A1FM', STAT_HEAL_BONUS, 20 )
		//STAT_DAMAGE_DEALT_PHY
		call ConnectAbilityToStat( 'A1FV', STAT_DAMAGE_DEALT_PHY, 10 )
		call ConnectAbilityToStat( 'A1F5', STAT_DAMAGE_DEALT_PHY, 40 )
		call ConnectAbilityToStat( 'A1FW', STAT_DAMAGE_DEALT_PHY, 45 )
		call ConnectAbilityToStat( 'A1FQ', STAT_DAMAGE_DEALT_PHY, 100 )
		//STAT_DAMAGE_DEALT_MINIONS_PHY
		call ConnectAbilityToStat( 'A1F6', STAT_DAMAGE_DEALT_MINIONS_PHY, 200 )
		//STAT_DAMAGE_DEALT_MAG
		call ConnectAbilityToStat( 'A1F7', STAT_DAMAGE_DEALT_MAG, 75 )
		//STAT_DODGE
		call ConnectAbilityToStat( 'A1F8', STAT_DODGE, 15 )
		call ConnectAbilityToStat( 'A1FK', STAT_DODGE, 1 )
		call ConnectAbilityToStat( 'A1FO', STAT_DODGE, 25 )
		//STAT_DAMAGE_DEALT_BOSSES
		call ConnectAbilityToStat( 'A1F9', STAT_DAMAGE_DEALT_BOSSES, 30 )
		//STAT_DAMAGE_DEALT
		call ConnectAbilityToStat( 'A1FA', STAT_DAMAGE_DEALT, 25 )
		//STAT_COOLDOWN
		call ConnectAbilityToStat( 'A1FB', STAT_COOLDOWN, -30 )
		call ConnectAbilityToStat( 'A1FL', STAT_COOLDOWN, -10 )
		//STAT_BUFF_DURATION
		call ConnectAbilityToStat( 'A1FC', STAT_BUFF_DURATION, 50 )
		//STAT_MANA_HEAL_BONUS
		call ConnectAbilityToStat( 'A1FD', STAT_MANA_HEAL_BONUS, 100 )
		//STAT_GOLD_GAIN
		call ConnectAbilityToStat( 'A1FE', STAT_GOLD_GAIN, 20 )
		call ConnectAbilityToStat( 'A1FJ', STAT_GOLD_GAIN, -90 )
		call ConnectAbilityToStat( 'A1FN', STAT_GOLD_GAIN, 35 )
		//STAT_DAMAGE_TAKEN_PHY
		call ConnectAbilityToStat( 'A1FF', STAT_DAMAGE_TAKEN_PHY, -40 )
		call ConnectAbilityToStat( 'A1FU', STAT_DAMAGE_TAKEN_PHY, -10 )
		call ConnectAbilityToStat( 'A1FP', STAT_DAMAGE_TAKEN_PHY, 100 )
		//STAT_MOON_SET_DAMAGE_DEALT
		call ConnectAbilityToStat( 'A1FG', STAT_MOON_SET_DAMAGE_DEALT, 50 )
		//STAT_SHOP_DISCOUNT
		call ConnectAbilityToStat( 'A1FH', STAT_SHOP_DISCOUNT, -20 )
	endfunction

	private function init takes nothing returns nothing
		call TimerStart( CreateTimer(), 0.5, false, function delay )
	endfunction

endlibrary