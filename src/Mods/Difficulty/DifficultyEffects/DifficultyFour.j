scope DifficultyFour initializer init

	globals
		private integer DIFFICULTY_REQUIRED = 4
		private boolean isActive = false
		
		private integer ITEM_CREATED = 'I0B5'
		private integer CURSES_TO_ADD = 2
	endglobals
	
	private function condition takes nothing returns boolean
	    return isActive == false and Difficulty_GetIndex() >= DIFFICULTY_REQUIRED
	endfunction

	private function action takes nothing returns nothing
		local integer i 
		local unit hero
	
	    set isActive = true
	    
	    set i = 1
	    loop
	    	exitwhen i > 4
	    	set hero = udg_hero[i]
	    	if hero != null then
	    		call UnitAddItem(hero, CreateItem(ITEM_CREATED, GetUnitX(hero), GetUnitY(hero)))
	    	endif
	    	set i = i + 1
    	endloop
    	
    	set i = 1
	    loop
	    	exitwhen i > CURSES_TO_ADD
	    	call ModeSystem_Enable(ModeSystem_GetRandomCurse(false))
	    	set i = i + 1
    	endloop
    	
    	set hero = null
	endfunction

	private function init takes nothing returns nothing
	    call OnModsAwake.AddListener(function action, function condition)
	endfunction

endscope