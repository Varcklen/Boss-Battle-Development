library Aspects initializer init

    globals
        constant integer ASPECT_LIMIT = 3
        integer array Aspect[100][4]//номер героя/аспекты
        boolean array IsAspectActive[100][4]//номер героя/аспекты
        boolean array IsHeroCanUseAspect[100]
        
        constant integer ASPECT_01 = 1
        constant integer ASPECT_02 = 2
        constant integer ASPECT_03 = 3
    endglobals

    private function SetAspect takes integer index, integer abilityOne, integer abilityTwo, integer abilityThree returns nothing
        set IsHeroCanUseAspect[index] = true
        set Aspect[index][1] = abilityOne
        set Aspect[index][2] = abilityTwo
        set Aspect[index][3] = abilityThree
    endfunction

    private function init takes nothing returns nothing
        //Beorn Patriarch
        call SetAspect(7, 'A0WG', 'A0X3', 'A0X4')
        
        //Druid-Naturalist
        call SetAspect(10, 'A0TR', 'A0TS', 'A0P8')
        
        //Samurai
        call SetAspect(32, 'A0V9', 'A0VY', 'A0TT')
        
        //Berry Dealer
        call SetAspect(36, 'A1CF', 'A1CG', 'A1CE')
        
        //Toxic Elemental
        call SetAspect(56, 'A1CB', 'A1CC', 'A1CD')
        
        //Armsmaster
        call SetAspect(63, 'A16B', 'A16A', 'A16C')
        
        //Wanderer
        call SetAspect(67, 'A16E', 'A16F', 'A16D')
        
        //Bard
        call SetAspect(70, 'A1B5', 'A1C0', 'A1C1')
        
        //Ent
        call SetAspect(74, 'A1DF', 'A1DD', 'A1DE')
        
        //Lycanthrope
        call SetAspect(75, 'A1DB', 'A1DA', 'A1DC')
    endfunction

    public function IsHeroCanUseAspects takes unit hero returns boolean
        local boolean work = false
        
        set work = IsHeroCanUseAspect[udg_HeroNum[GetUnitUserData(hero)]]

        set hero = null
        return work
    endfunction
    
    public function IsHeroIndexCanUseAspects takes integer heroIndex returns boolean
        local boolean work = false
        
        set work = IsHeroCanUseAspect[heroIndex]

        return work
    endfunction
    
    public function IsHeroAspectActive takes unit hero, integer aspect returns boolean
        local integer heroIndex = 0
        local integer playerIndex = GetUnitUserData(hero)
    
        if aspect < 1 or aspect > 3 then
            call BJDebugMsg("You are trying to address an aspect that does not exist. Please report this to the developer. Current aspect: " + I2S(aspect))
            return false
        elseif playerIndex < 1 or playerIndex > 4 then
            //call BJDebugMsg("You are trying to address an aspect of a non-existent hero. Please report this to the developer. Current playerIndex: " + I2S(playerIndex))
            return false
        endif
        set heroIndex = udg_HeroNum[playerIndex]
    
        set hero = null
        return IsAspectActive[heroIndex][aspect]
    endfunction
    
endlibrary