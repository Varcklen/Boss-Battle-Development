library ModeDatabase initializer init requires ModeClass

	private function delay takes nothing returns nothing
		//Bless
		call Mode.create( 'A0E4', "BlessThirst", true)
		call Mode.create( 'A0FH', "BlessMagic", true)
		call Mode.create( 'A00A', "BlessNecroPotion", true)
		call Mode.create( 'A0AK', "BlessHronoSpeed", true)
		call Mode.create( 'A0BA', "BlessMalice", true)
		call Mode.create( 'A11B', "BlessReborn", true)
		call Mode.create( 'A112', "BlessChest", true)
		call Mode.create( 'A0FI', "BlessChaosEarning", true)
		call Mode.create( 'A0IG', "BlessRevert", true)
		call Mode.create( 'A0GU', "BlessTriad", true)
		call Mode.create( 'A14F', "BlessMajesticMates", true)
		call Mode.create( 'A14I', "BlessEmotionalSuppression", true)
		call Mode.create( 'A0QE', "BlessTrade", true)
		call Mode.create( 'A1DJ', "BlessTeamWork", true)
		call Mode.create( 'A0BB', "BlessActivation", true)
		call Mode.create( 'A03P', "BlessImmortality", true)
		call Mode.create( 'A0QI', "BlessProduction", true)
		call Mode.create( 'A0DJ', "BlessChosenOne", true)
		call Mode.create( 'A0QL', "BlessPurse", true)
		call Mode.create( 'A0FY', "BlessSaturation", true)
		call Mode.create( 'A0QF', "BlessSquire", true)
		call Mode.create( 'A0Q8', "BlessEnlightenment", true)
		call Mode.create( 'A0QC', "BlessHonor", true)
		call Mode.create( 'A110', "BlessLuck", true)
		call Mode.create( 'A116', "BlessIdentity", true)
		call Mode.create( 'A115', "BlessSecondChance", true)
		call Mode.create( 'A114', "BlessSap", true)
		call Mode.create( 'A119', "BlessPurification", true)
		call Mode.create( 'A117', "BlessBloodsuckers", true)
		call Mode.create( 'A113', "BlessFieryRain", true)
		call Mode.create( 'A0MK', "BlessIKnowGuy", true)
		call Mode.create( 'A0NF', "BlessLaboratoryEquipment", true)
		call Mode.create( 'A0P1', "BlessPlotTwist", true)
		call Mode.create( 'A0SY', "BlessExtraTry", true)
		call Mode.create( 'A18S', "BlessForesight", true)
		call Mode.create( 'A19M', "BlessRuneMaking", true)
		
		//Curse
		call Mode.create( 'A0QA', "CurseFlame", false)
	endfunction
	
	private function init takes nothing returns nothing
		call TimerStart( CreateTimer(), 0.5, false, function delay )
	endfunction

endlibrary