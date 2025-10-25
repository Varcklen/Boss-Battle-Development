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
						
						
	Lycan -			A lot of changes since R is the main use the hero gets, and that ability is being changed.
					Q : Buff Effect : 5% per stack			-> 6% per stack
						Duration	: 15					-> 20
						ALT Damage	: 60 + 20xLVL			-> 35 + 35xLVL
						ALT HP Cost	: 30					-> 0
						ALT Effect	: 10% per stack			-> 12% per stack
						fixed an oversight where the aspect improved Q damage resistance
						
					E : Cooldown	: 22 - 2xLVL			-> 43 - 3xLVL
						Random R now prioritizes allied heroes with high health*
						Random Q casts twice
						
				   *R : Buff Effect : 10%					-> 12%
				   		Cooldown	: 20					-> 25
				   		Cost		: 50HP + 50MP			-> 50HP + 150MP
				   		Alternate mode reworked to be in line with Reaper class identity:
					Apply a buff to an ally. Every second, damage enemies around the target for 8% 
					of what was taken while the debuff was active. 
					Likewise, it restores target's health equal to 12% of the damage taken.
					Duration: 6/7/8/9/10 seconds.
					Cooldown: 25 seconds.
					Cost: 150 mana and health.
			
			
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
	
	
			Added new hero: Arcanologist.
		Q - Replenish
	Applies a Shield effect worth 120/160/200/240/280 (SP) health and restores 40/50/60/70/80 (SP) mana. Provoke a random nearby enemy.
		W - Investigate
	Passive: when you reach fifth level of this ability for the first time, get a random signature artifact.
	Active: Apply an effect to self that deals 15 (SP) damage to all nearby enemies every second and restores 15 (SP) mana.
	Duration: 7/9/11/13/15 seconds.
	Cooldown: 20 seconds.
	Cost: 50/60/70/80/90 mana.
		E - Runic Enchantment
	Reduces damage taken by 9/13/17/21/25%. While your mana capacity is at 30% or more, redirects 45% damage taken to mana.
	Increases maximum mana by 100/115/130/145/160.
		R - Arcane Intellect
	Increases Strength of a random hero by 3/4/5/6/7 + 15/20/25/30/35% of maximum Strength among all heroes. Repeat for Agility and Intelligence.
	Duration: 19 seconds.
	Cooldown: 30 seconds.
	Cost: 70/85/100/115/130 mana.
	Effects are cumulative, but have a significantly reduced effectiveness beyond the first stack.
	
	
	ITEMS:
	Idol of Kusa - silence : 5s		-> 4s
	Celestial Quartz - CD  : 60s	-> 40s
	Red Poppy	 					-> added 1 Random Bonus
	Magic Dispenser - SP   : .5/AGI -> .4/AGI
	Ancient Pearl - ExHeal : 25/lvl	-> 50/lvl
	Fighter's Glove - ASPD : 20% 	-> 25%
	Penny Pincher - Gold   : 3 		-> 4
	
	
			New item - Grateful Dead - Common
		While your hero is dead, gain 200% spellpower.
		
			New item - Witness Cleaver - Common, Weapon
		Increases strength by 4. Every 15 seconds, increases spell power by 2% until end of battle.
		
			New item - Immovable Brigandine - Rare
		Activation: Places the caster in stasis. The hero cannot do anything and becomes invulnerable.
		Duration: 6 seconds.
		Cooldown: 45 seconds.
		Cost: 60 mana.
		
			New item - Oath of Resourcefulness - Legendary
		Cursed. Your corrupted items transform into "Weapon Gift" after being used instead of disappearing.
		
			New item - Runestone Lous - Legendary, Rune, Crystal
		When your shield is destroyed, deal 40 (SP) damage to nearby enemies.
		Decreases Spell Power by 35%.
		
	
	Energy Charge quest requires 50 more mana with every completion. Reward unchanged.
	Magic Fern and Natural Deselection should now properly add luck again.
	Natural Deselection now copies over the stats for until the revived hero dies.
	
	Fixed an oversight that led Runesmith, Wrath Collector and Sheperd to have incorrect interactions with Dream Catcher.
	The latter will now fizzle (is intended), the other 2 use their own abilities instead of fizzling or stealing someone else's ability.
	
	OTHER:
		New Special - Farewell
	Quickly jump towards target area with moderate precision.
	Cooldown: 25 seconds.
	
	Time command now accepts values as low as 40s.
	Attempted to improve the stability of resurrection effects.
	Fixed roles display for Evil Spirit.
	Fixed shields applying to dead heroes.
 */