library ModeUse

    globals
        Mode ModeTemp
    endglobals

    public function EnableTrigger takes Mode modeUsed returns nothing
        set ModeTemp = modeUsed
        
        call ExecuteFunc( modeUsed.ScopeName + "_Enable" )
    endfunction
    
    public function DisableTrigger takes Mode modeUsed returns nothing
        set ModeTemp = modeUsed
        
        call ExecuteFunc(modeUsed.ScopeName + "_Disable")
    endfunction
    
endlibrary