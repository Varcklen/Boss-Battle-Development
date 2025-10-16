/*
	HEROES:
	Fixed many instances of spells scaling from spellpower twice.
	
	Keeper otGT - 	Q : reduced range to be in line with most other teleport/movement abilities : 900 -> 600
	
	Apex Predator - Q : knockback scales with level : 450 	-> 330 + 60xLVL
						fixed the bug that capped knockback at ~200 (+-30)
						optimized the code to exclude 15 extra tangent calculations
						while knockback numbers are reduced at lvl 1, it will still be at least 50% better due to the bugfix 
						
	Wanderer - 		W : made waves hitbox slightly more generous; changed cost, duration and cd, adjusted damage to loosely match DPS
						Damage		: 5 + 3xLVL 			-> 5 + 5xLVL
						Cooldown	: 8 					-> 10 - LVL
						Duration	: 7						-> 8  - LVL
						Cost		: 60MP, 30 + 10xLVL HP	-> 50 HP/MP
	
	Outcast Demon - Rework 2
	New mechanic: Withdrawal
	
		Extra ability changed to Defiance:
	If the hero has used Vengeful Strike no more than 3 times during the battle, gain 3 Strength at the end of the round.
	The effect is the same for Demonic Blast (Agility) and Power Overwhelming (Intelligence).
	
		Denial of the Past (E) rework:
	After 5 seconds of not using a hero ability, enter Withdrawal; 
	while in that state, all damage is increased by 40/55/70/85/100% of Agility and Intelligence, 
	but health is drained every 2 seconds, starting at 1% and doubling every tick.
	Dying or using hero abilities exists Withdrawal.
	At the end of the round, gain 0/1/2/3/4 extra strength and agility if Defiance was fully successful.
	
	ITEMS:
	Energy Charge quest requires 50 more mana with every completion. Reward unchanged.
	Magic Fern and Natural Deselection should now properly add luck again.
	Natural Deselection now copies over the stats for until the revived hero dies.
	
	OTHER:
	Time command now accepts values as low as 40s.
	Attempted to improve the stability of resurrection effects.
 */