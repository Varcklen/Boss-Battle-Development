/*

Heroes:
	Troll Mage - Q 		: heal/damage 	20 + 20x lvl 	-> 30 + 30x lvl			# this used to be not worth using period
	Troll Mage - R 		: damage 		40 + 40x lvl 	-> 30 + 30x lvl			# insane damage nuke on low cd
	Troll Mage - R 		: cd 			15			 	-> 20					# insane damage nuke on low cd
	Troll Mage - Orb 	: Unique Sp 	0% effect		-> 50% effect			# oversight? fix and immediate nerf
	Troll Mage - Orb 	: heal/damage 	5				-> 4					# the hero does everything, so a couple small nerfs
	Troll Mage - Orb 	: life time 	30 				-> 25					# the hero does everything, so a couple small nerfs
	
	Divine Maiden - Q 	: armour 		2 + lvl 		-> 1 + 2x lvl
	Berry Dealer - Q/R	: banana gold 	25x SP 			-> 20x SP
	Skeltor - E 		: life time 	15 				-> 15x SP
	Skeltor - Aspects
	Gambler - Aspects
	Snper - 2 Aspects
	Lycan - Q			: cost 			40m-d/n 		-> 30m-d / 30mh-n		# base form support appeal
	Lycan - W			: upkeep 		5% hp 	 		-> 4% hp				# will look into nerfs if hero is too good early and late after this
	Lycan - E			: scaling 		2 + lvl 	 	-> -1 + 2x lvl			# adjusting for 4 starting abilities and -1 arena
	Lycan - R			: cost 			50m125h-d/n 	-> 50mh-d / 50m125h-n 	# base form support appeal
	Lycan - QAspect		: buff 			3%		 		-> 4%					# base form support appeal
	Lycan - WAspect		: dmgblock 		10		 	 	-> 15					# this effect feels very weak
	Infernal - E 		: mechanics		-> refresh damage between battles & respects armour 	 #infernal was awful on high waves

Mechanics:
	Added AfterDamageSysEvent - afterdamage that respects armour amounts and resistances

	Started switching to polar coordinates in random casts. Affected:
		-troll mage D,W
		-dealer W,E,R
		-keeperofthegreattree Q
		-predator W,R 
		-miraclebrew R
		-sniper R 
		-ninja R 
		-priestess R 
		-gunner Q,R 
		-elemental Q
		-incarnation Q,R
		-ratshaman W 
		-paladin Q 
		-corruptEnt Q
		-ghoulking W,E,R 
		-ghost W 
		-devourer R 
		-wicerd Q 
		-fallenOne R 
		-theplague Q,R
		
		-special:voodooExplosion
		
		-items:TODO

minor improvements to optimization in related heroes&abilities (i.e. GetLocX(GetSpellLoc()) -> GetSpellX() , removed some instances of using same getters multiple times in one func)

UI/UX:
	Added skin: Toxic Elemental - lvl 11
	Rare item models are now tinted blue

    




 */