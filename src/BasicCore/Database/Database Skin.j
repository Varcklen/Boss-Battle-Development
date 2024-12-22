scope Skins

	globals
		integer array skinmodel[80][6]//модель/номер
	    integer array skinlvl[80][6]//уровень/номер
	    string array skiniconBTN[10][6]//позиция/номер
	    string array skiniconDIS[10][6]//позиция/номер	
	    boolean array skinAddGlow[80][6]//модель/номер
	endglobals

    public function DataSkins takes nothing returns nothing
        set udg_DB_Skin_Limit = 3
        
        //===========1============
        //Monk
        set skinmodel[2][1] = 'O01D'
        set skinlvl[2][1] = 7
        set skiniconBTN[2][1] = "war3mapImported\\BTNSumo.blp"
        set skiniconDIS[2][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISPASBTNSumo.blp"
        //Preacher of the Light
        set skinmodel[6][1] = 'N04V'
        set skinlvl[6][1] = 19
        set skiniconBTN[6][1] = "war3mapImported\\BTNjudgment.paladin.blp"
        set skiniconDIS[6][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNjudgment.paladin.blp"
        //===============
        set skinmodel[10][1] = 'N04T'
        set skinlvl[10][1] = 11
        set skiniconBTN[10][1] = "war3mapImported\\BTNdruidskin.blp"
        set skiniconDIS[10][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNdruidskin.blp"
        //Scarab King
        set skinmodel[12][1] = 'N016'
        set skinlvl[12][1] = 13
        set skiniconBTN[12][1] = "war3mapImported\\BTNScarabKingSkin01.blp"
        set skiniconDIS[12][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNScarabKingSkin01.blp"
        //===============
        set skinmodel[14][1] = 'N04R'
        set skinlvl[14][1] = 9
        set skiniconBTN[14][1] = "war3mapImported\\BTNHellTauren.blp"
        set skiniconDIS[14][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNHellTauren.blp"
        //===============
        set skinmodel[15][1] = 'N04Z'
        set skinlvl[15][1] = 12
        set skiniconBTN[15][1] = "war3mapImported\\BTNSkinmentor1.blp"
        set skiniconDIS[15][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNSkinmentor1.blp"
        //Pyrolord
        set skinmodel[16][1] = 'N033'
        set skinlvl[16][1] = 14
        set skiniconBTN[16][1] = "war3mapImported\\BTNskinFirelord01.blp"
        set skiniconDIS[16][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinFirelord01.blp"
        //Miracle Alchemist
        set skinmodel[20][1] = 'O01S'
        set skinlvl[20][1] = 7
        set skiniconBTN[20][1] = "war3mapImported\\BTNskinwitchdoctor2.blp"
        set skiniconDIS[20][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinwitchdoctor2.blp"
        //===============
        set skinmodel[22][1] = 'N04Y'
        set skinlvl[22][1] = 16
        set skiniconBTN[22][1] = "war3mapImported\\BTNSkinbarb1.blp"
        set skiniconDIS[22][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNSkinbarb1.blp"
        //===============
        set skinmodel[25][1] = 'H024'
        set skinlvl[25][1] = 13
        set skiniconBTN[25][1] = "war3mapImported\\BTNknightskin.blp"
        set skiniconDIS[25][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNknightskin.blp"
        //===============
        set skinmodel[27][1] = 'O01H'
        set skinlvl[27][1] = 25
        set skiniconBTN[27][1] = "war3mapImported\\BTNundyingp.blp"
        set skiniconDIS[27][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNundyingp.blp"
        set skinAddGlow[27][1] = true
        //===============
        set skinmodel[28][1] = 'N04U'
        set skinlvl[28][1] = 17
        set skiniconBTN[28][1] = "war3mapImported\\BTNskinharpy.blp"
        set skiniconDIS[28][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinharpy.blp"
        //Commander
        set skinmodel[29][1] = 'O01P'
        set skinlvl[29][1] = 21
        set skiniconBTN[29][1] = "war3mapImported\\BTNskinCommander01.blp"
        set skiniconDIS[29][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinCommander01.blp"
        //===============
        set skinmodel[32][1] = 'N04Q'
        set skinlvl[32][1] = 5
        set skiniconBTN[32][1] = "ReplaceableTextures\\CommandButtons\\BTNChaosBlademaster.blp"
        set skiniconDIS[32][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNChaosBlademaster.blp"
        //Dream Devourer
        set skinmodel[33][1] = 'O01V'
        set skinlvl[33][1] = 8
        set skiniconBTN[33][1] = "war3mapImported\\BTNskinDevouver01.blp"
        set skiniconDIS[33][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinDevouver01.blp"
        //===============
        set skinmodel[34][1] = 'O01G'
        set skinlvl[34][1] = 10
        set skiniconBTN[34][1] = "war3mapImported\\BTNskintuskar.blp"
        set skiniconDIS[34][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskintuskar.blp"
        //Combat Ogre
        set skinmodel[37][1] = 'N03A'
        set skinlvl[37][1] = 9
        set skiniconBTN[37][1] = "war3mapImported\\BTNskinCombatOgre01.blp"
        set skiniconDIS[37][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinCombatOgre01.blp"
        //===============
        set skinmodel[38][1] = 'O01E'
        set skinlvl[38][1] = 15
        set skiniconBTN[38][1] = "war3mapImported\\BTNskindryad.blp"
        set skiniconDIS[38][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskindryad.blp"
        //===============
        set skinmodel[39][1] = 'N051'
        set skinlvl[39][1] = 18
        set skiniconBTN[39][1] = "war3mapImported\\BTNskinmetalmage1.blp"
        set skiniconDIS[39][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinmetalmage1.blp"
        //===============
        set skinmodel[41][1] = 'H025'
        set skinlvl[41][1] = 8
        set skiniconBTN[41][1] = "war3mapImported\\BTNskinsludge1.blp"
        set skiniconDIS[41][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinsludge1.blp"
        //Incarnation of the Void
        set skinmodel[42][1] = 'N03D'
        set skinlvl[42][1] = 28
        set skiniconBTN[42][1] = "war3mapImported\\BTNskinincarnation1.blp"
        set skiniconDIS[42][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinincarnation1.blp"
        //Shoggoth
        set skinmodel[45][1] = 'O01U'
        set skinlvl[45][1] = 29
        set skiniconBTN[45][1] = "war3mapImported\\BTNCthunIcon.blp"
        set skiniconDIS[45][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNCthunIcon.blp"
        //===============
        set skinmodel[46][1] = 'O01M'
        set skinlvl[46][1] = 14
        set skiniconBTN[46][1] = "ReplaceableTextures\\CommandButtons\\BTNSkeletonMage.blp"
        set skiniconDIS[46][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNSkeletonMage.blp"
        //===============
        set skinmodel[49][1] = 'N052'
        set skinlvl[49][1] = 21
        set skiniconBTN[49][1] = "war3mapImported\\BTNDemoness.blp"
        set skiniconDIS[49][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNDemoness.blp"
        //Toxic Elemental
        set skinmodel[56][1] = 'O022'
        set skinlvl[56][1] = 11
        set skiniconBTN[56][1] = "ReplaceableTextures\\CommandButtons\\BTNSeaElemental.blp"
        set skiniconDIS[56][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNSeaElemental.blp"
        //Grim Ninja
        set skinmodel[57][1] = 'N034'
        set skinlvl[57][1] = 22
        set skiniconBTN[57][1] = "war3mapImported\\BTNskinNinja01.blp"
        set skiniconDIS[57][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinNinja01.blp"
        //===============
        set skinmodel[63][1] = 'N056'
        set skinlvl[63][1] = 6
        set skiniconBTN[63][1] = "war3mapImported\\BTNskilarmsmaster1.blp"
        set skiniconDIS[63][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskilarmsmaster1.blp"
        //===============
        set skinmodel[67][1] = 'N02I'
        set skinlvl[67][1] = 20
        set skiniconBTN[67][1] = "war3mapImported\\BTNskinwanderer1.blp"
        set skiniconDIS[67][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinwanderer1.blp"
        //Abyssal Infernal
        set skinmodel[69][1] = 'N013'
        set skinlvl[69][1] = 15
        set skiniconBTN[69][1] = "war3mapImported\\BTNFelReaverIcon.blp"
        set skiniconDIS[69][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNFelReaverIcon.blp"
        //Bard
        set skinmodel[70][1] = 'O01W'
        set skinlvl[70][1] = 9
        set skiniconBTN[70][1] = "war3mapImported\\BTNskinBard01.blp"
        set skiniconDIS[70][1] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinBard01.blp"
        set skinAddGlow[70][1] = true


        //===========2============
        //Preacher of the Light
        set skinmodel[6][2] = 'N03C'
        set skinlvl[6][2] = 19
        set skiniconBTN[6][2] = "war3mapImported\\BTNBlackOrderGrandMasterIcon.blp"
        set skiniconDIS[6][2] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNBlackOrderGrandMasterIcon.blp"
        //Minotaur
        set skinmodel[14][2] = 'N050'
        set skinlvl[14][2] = 20
        set skiniconBTN[14][2] = "war3mapImported\\BTNskinminotair2.blp"
        set skiniconDIS[14][2] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinminotair2.blp"
        //Commander
        set skinmodel[29][2] = 'O01Q'
        set skinlvl[29][2] = 24
        set skiniconBTN[29][2] = "war3mapImported\\BTNskinCommander2.blp"
        set skiniconDIS[29][2] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinCommander2.blp"
        //Dream Devourer
        set skinmodel[33][2] = 'O01X'
        set skinlvl[33][2] = 12
        set skiniconBTN[33][2] = "war3mapImported\\BTNskinDevourer02.blp"
        set skiniconDIS[33][2] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinDevourer02.blp"
        //Combat Ogre
        set skinmodel[37][2] = 'N03B'
        set skinlvl[37][2] = 24
        set skiniconBTN[37][2] = "war3mapImported\\BTNOgronIconYellow.blp"
        set skiniconDIS[37][2] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNOgronIconYellow.blp"
        //Troll Mage
        set skinmodel[46][2] = 'O00U'
        set skinlvl[46][2] = 23
        set skiniconBTN[46][2] = "war3mapImported\\BTNskinwitchdoctor2.blp"
        set skiniconDIS[46][2] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNskinwitchdoctor2.blp"
        //Toxic Elemental
        set skinmodel[56][2] = 'O01T'
        set skinlvl[56][2] = 27
        set skiniconBTN[56][2] = "war3mapImported\\BTNPoisonElemental.blp"
        set skiniconDIS[56][2] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNPoisonElemental.blp"
        
        
        
        //===========3============
        //Troll Mage
        set skinmodel[46][3] = 'O01R'
        set skinlvl[46][3] = 26
        set skiniconBTN[46][3] = "war3mapImported\\BTNVol'jin.blp"
        set skiniconDIS[46][3] = "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNVol'jin.blp"
    endfunction

endscope