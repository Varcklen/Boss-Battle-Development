library WrathBarVisual initializer init 
    globals 
        private framehandle WrathBar = null  
        private framehandle WrathBarVessel = null 
        private framehandle WrathBarData = null 
        private framehandle WrathBarGlow = null 
        private framehandle WrathBarText = null 
        
        private constant string GLOW_IMAGE = "wrathbar_bluelight.blp"
        private constant string VESSEL_IMAGE = "wrathbar_energy_bar.blp"
        private constant integer BAR_MAX_VALUE = 99
    endglobals
    
    public function SetValue takes player owner, integer newValue returns nothing
        local integer alpha

        set alpha = R2I(newValue * 255. / 100.)
        
        if GetLocalPlayer() == owner then
            call BlzFrameSetValue(WrathBarData, IMinBJ(newValue, BAR_MAX_VALUE))
            call BlzFrameSetText(WrathBarText, I2S(newValue) + "%")
            call BlzFrameSetAlpha(WrathBarGlow, alpha)
        endif
    endfunction
    
    public function SetVisibility takes player owner, boolean isVisible returns nothing
        if GetLocalPlayer() == owner then
            call BlzFrameSetVisible( WrathBar, isVisible )
        endif
    endfunction
    
    //TEST
    globals
        private integer number = 0
    endglobals
    private function update takes nothing returns nothing
        set number = number + 20
        if number > 100 then
            set number = 0
        endif
    
        call SetValue(Player(0), number)
    endfunction
    
    private function enable_test takes nothing returns nothing
        local trigger test_trigger = CreateTrigger(  )

        call TriggerRegisterTimerEventPeriodic( test_trigger, 1.00 )
        call TriggerAddAction( test_trigger, function update )
        call BlzFrameSetVisible( WrathBar, true )
        call BJDebugMsg("WrathBar - Test Enabled.")
    endfunction
    //
    
    private function init takes nothing returns nothing

        //Parent Frame
        set WrathBar = BlzCreateFrameByType("FRAME", "", BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0), "", 1)
        call BlzFrameSetAbsPoint(WrathBar, FRAMEPOINT_TOPLEFT, 0.00700000, 0.188760)
        call BlzFrameSetAbsPoint(WrathBar, FRAMEPOINT_BOTTOMRIGHT, 0.201720, 0.165000)
        call BlzFrameSetVisible( WrathBar, false )

        //Glow
        set WrathBarGlow = BlzCreateFrameByType("BACKDROP", "BACKDROP", WrathBar, "", 1)
        call BlzFrameSetPoint(WrathBarGlow, FRAMEPOINT_TOPLEFT, WrathBar, FRAMEPOINT_TOPLEFT, 0.0036900, 0.024970)
        call BlzFrameSetPoint(WrathBarGlow, FRAMEPOINT_BOTTOMRIGHT, WrathBar, FRAMEPOINT_BOTTOMRIGHT, -0.0027800, 0.018670)
        call BlzFrameSetLevel( WrathBarGlow, -2 )
        call BlzFrameSetTexture(WrathBarGlow, GLOW_IMAGE, 0, true)

        //Bar
        set WrathBarData = BlzCreateFrameByType("STATUSBAR", "name", WrathBar, "", 0)
        call BlzFrameSetPoint(WrathBarData, FRAMEPOINT_TOPLEFT, WrathBar, FRAMEPOINT_TOPLEFT, 0.0070300, -0.0029800)
        call BlzFrameSetPoint(WrathBarData, FRAMEPOINT_BOTTOMRIGHT, WrathBar, FRAMEPOINT_BOTTOMRIGHT, -0.0089100, 0.0026100)
        
        call BlzFrameSetModel(WrathBarData, "ui\\feedback\\progressbar\\timerbar.mdx", 0)
        call BlzFrameSetValue(WrathBarData, 50)
        
        //Vessel Image
        set WrathBarVessel = BlzCreateFrameByType("BACKDROP", "BACKDROP", WrathBar, "", 1)
        call BlzFrameSetPoint(WrathBarVessel, FRAMEPOINT_TOPLEFT, WrathBar, FRAMEPOINT_TOPLEFT, 0.0, -0.0007)
        call BlzFrameSetPoint(WrathBarVessel, FRAMEPOINT_BOTTOMRIGHT, WrathBar, FRAMEPOINT_BOTTOMRIGHT, -0.001, 0.0)
        call BlzFrameSetLevel( WrathBarVessel, 5 )
        call BlzFrameSetTexture(WrathBarVessel, VESSEL_IMAGE, 0, true)
        
        //Text
        set WrathBarText = BlzCreateFrameByType("TEXT", "name", WrathBar, "", 0)
        call BlzFrameSetPoint(WrathBarText, FRAMEPOINT_TOPLEFT, WrathBar, FRAMEPOINT_TOPLEFT, 0.14795, -0.0039800)
        call BlzFrameSetPoint(WrathBarText, FRAMEPOINT_BOTTOMRIGHT, WrathBar, FRAMEPOINT_BOTTOMRIGHT, -0.015580, 0.0042000)
        call BlzFrameSetText(WrathBarText, "NN%")
        call BlzFrameSetLevel( WrathBarText, 10 )
        call BlzFrameSetTextAlignment(WrathBarText, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_RIGHT)

        //TEST
        //call enable_test()
        //call SetValue(Player(0), 0)
        //call BlzFrameSetVisible( WrathBar, true )
    endfunction

endlibrary
