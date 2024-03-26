scope BlessTriad initializer init

	globals
		private trigger Trigger = null
		
		private constant integer SET_AMOUNT = 3
	    private constant integer PIECES_TO_ADD = 1
	    
	    private boolean isUsedAgain = false
	    private string extraText = ""
	    
	    private integer array Sets
	endglobals
	
	private function AddPieces takes integer value returns nothing
		local integer i
		local integer k
	
		set i = 1
	    loop
	        exitwhen i > SET_AMOUNT
	        set k = 1
	        loop
	            exitwhen k > PLAYERS_LIMIT
	            if udg_hero[k] != null then
	                call SetCount_AddPiece( udg_hero[k], Sets[i], PIECES_TO_ADD )
	            endif
	            set k = k + 1
	        endloop
	        set i = i + 1
	    endloop
	endfunction
	
	private function AddText takes nothing returns nothing
		local integer iconPosition
	    local string modeId
	    
	    set modeId = "ModGood" + I2S(ModeTemp.id)
	    set iconPosition = GetIconFrameNumberByKey( modeId )
	    
	    if iconPosition != -1 then
	        call IconFrameReplaceDescription(modeId, BlzFrameGetText(bonustxt[iconPosition]) + extraText )
	    endif
	endfunction

	private function SetPieces takes nothing returns nothing
	    local integer i
	    local integer rand
	    local integer array numberArray
	    local integer numberMaxSize
	    
	    set numberMaxSize = SETS_COUNT
	    set i = 1
	    loop
	        exitwhen i > SETS_COUNT
	        set numberArray[i] = i
	        set i = i + 1
	    endloop
	    
	    set i = 1
	    loop
	        exitwhen i > SET_AMOUNT
	        set rand = GetRandomInt(1, numberMaxSize)
	        set Sets[i] = numberArray[rand]
	        
	        set numberArray[rand] = numberArray[numberMaxSize]
	        set numberMaxSize = numberMaxSize - 1
	        set i = i + 1
	    endloop
	    
	    if Sets[1] == 0 or Sets[2] == 0 or Sets[3] == 0 then
	        call BJDebugMsg("\"Triad\" blessing is not working correctly. Please report this to the developer. (" + I2S(Sets[1]) + " " + I2S(Sets[2]) + " " + I2S(Sets[3]) + ").")
	        return
	    endif
	    
	    set i = 1
	    loop
	        exitwhen i > SET_AMOUNT
	        set extraText = extraText + " " + SetCount_GetSetName( Sets[i] )
	        set i = i + 1
	    endloop
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		if isUsedAgain == false then
			call SetPieces()
			set isUsedAgain = true
		endif
		call AddPieces(PIECES_TO_ADD)
		call AddText()
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
		call AddPieces(-PIECES_TO_ADD)
    endfunction
	
	private function init takes nothing returns nothing
		
	endfunction

endscope