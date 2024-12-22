/*

Heroes:
Troll Mage - Q 		: heal/damage 	20 + 20x lvl 	-> 30 + 30x lvl
Troll Mage - R 		: damage 		40 + 40x lvl 	-> 30 + 30x lvl
Divine Maiden - Q 	: armour 		2 + lvl 		-> 1 + 2x lvl
Berry Dealer - Q/R	: banana gold 	25x SP 			-> 20x SP
Skeltor - E 		: life time 	15 				-> 15x SP
Gambler - Aspects

Mechanics:
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

Added skin: Toxic Elemental - lvl 11

    local real x = GetLocationX(source) + dist * Cos(angle * bj_DEGTORAD)
    local real y = GetLocationY(source) + dist * Sin(angle * bj_DEGTORAD)






 */