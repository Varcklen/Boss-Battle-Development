library HideMinDamageText initializer init_function requires optional FrameLoader
// HideMinDamageV4
    globals
        private framehandle DamageA
        private framehandle DamageB
        private framehandle DamageA2
        private framehandle DamageB2
        private framehandle ParentA
        private framehandle ParentB
        private string Text
        private integer Index
        private integer LoopA
        private integer LoopAEnd
    endglobals
    private function find takes nothing returns nothing
        set LoopAEnd = StringLength(Text) - 1
        set LoopA = 1
        loop
            exitwhen LoopA >= LoopAEnd
            if SubString(Text, LoopA, LoopA +3) == " - " then
                set Index = LoopA + 3
                return
            endif
            set LoopA = LoopA + 1
        endloop
        set Index = 0
    endfunction
    
    private function update takes nothing returns nothing
        if BlzFrameIsVisible(ParentA) then
            set Text = BlzFrameGetText(DamageA)
            call find()
            call BlzFrameSetText(DamageA2, SubString(Text, Index, StringLength(Text)))
        endif
        if BlzFrameIsVisible(ParentB) then
            set Text = BlzFrameGetText(DamageB)
            call find()
            call BlzFrameSetText(DamageB2, SubString(Text, Index, StringLength(Text)))
        endif
    endfunction
    
    private function At0s takes nothing returns nothing
        set ParentA = BlzGetFrameByName("SimpleInfoPanelIconDamage", 0)
        set ParentB = BlzGetFrameByName("SimpleInfoPanelIconDamage", 1)
        set DamageA = BlzGetFrameByName("InfoPanelIconValue", 0)
        set DamageB = BlzGetFrameByName("InfoPanelIconValue", 1)
        call BlzCreateSimpleFrame("SimpleInfoPanelDestructableDetail", ParentA, 11)        
        set DamageA2 = BlzGetFrameByName("SimpleDestructableNameValue", 11)
        //call BlzFrameSetFont(DamageA2, SkinManagerGetLocalPath("InfoPanelTextFont"), 0.008, 0)
        call BlzFrameSetFont(DamageA2, "Fonts/frizqt__.ttf", 0.008, 0)
        call BlzFrameClearAllPoints(DamageA2)
        call BlzFrameSetPoint(DamageA2, FRAMEPOINT_TOPLEFT, BlzGetFrameByName("InfoPanelIconLabel", 0), FRAMEPOINT_BOTTOMLEFT, 0.002625, -0.003)
        call BlzCreateSimpleFrame("SimpleInfoPanelDestructableDetail", ParentB, 12)
        set DamageB2 = BlzGetFrameByName("SimpleDestructableNameValue", 12)
        //call BlzFrameSetFont(DamageB2, SkinManagerGetLocalPath("InfoPanelTextFont"), 0.008, 0)
        call BlzFrameSetFont(DamageB2, "Fonts/frizqt__.ttf", 0.008, 0)
        call BlzFrameClearAllPoints(DamageB2)
        call BlzFrameSetPoint(DamageB2, FRAMEPOINT_TOPLEFT, BlzGetFrameByName("InfoPanelIconLabel", 1), FRAMEPOINT_BOTTOMLEFT, 0.002625, -0.003)
        call BlzFrameSetFont(DamageA, "", 0, 0)
        call BlzFrameSetFont(DamageB, "", 0, 0)
        call TimerStart(GetExpiredTimer(), 0.05, true, function update)
    endfunction
    private function init_function takes nothing returns nothing
        static if LIBRARY_FrameLoader then
            call FrameLoaderAdd(function At0s)
        endif
        call TimerStart(CreateTimer(), 0, false, function At0s)
    endfunction
endlibrary
