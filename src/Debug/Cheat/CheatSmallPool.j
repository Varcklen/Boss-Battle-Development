scope CheatSmallPool initializer init

	globals
		public trigger Trigger = null
	endglobals

	private function action takes nothing returns nothing
		call BJDebugMsg("Small artifact pool set.")
		
		// Обычный. 0
	    set udg_base = 0
	    set DB_Items[1][BaseNum()] = 'I0AK'
	    set DB_Items[1][BaseNum()] = 'I0AM'
	    set DB_Items[1][BaseNum()] = 'I010'
	    set DB_Items[1][BaseNum()] = 'I0BN'
	    set DB_Items[1][BaseNum()] = 'I0EC'
	    set DB_Items[1][BaseNum()] = 'I0AV'
	    set DB_Items[1][BaseNum()] = 'I06H'
	    set DB_Items[1][BaseNum()] = 'I00K'
	    set DB_Items[1][BaseNum()] = 'I01B'
	    set DB_Items[1][BaseNum()] = 'I014'
	    set DB_Items[1][BaseNum()] = 'I06F'
	    set DB_Items[1][BaseNum()] = 'I06L'
	    set DB_Items[1][BaseNum()] = 'I0BF'
	    set DB_Items[1][BaseNum()] = 'I04G'
	    set DB_Items[1][BaseNum()] = 'I013'
	    set DB_Items[1][BaseNum()] = 'I0B1'
	    set DB_Items[1][BaseNum()] = 'I036'
	    set DB_Items[1][BaseNum()] = 'I0A2'
	    set DB_Items[1][BaseNum()] = 'I049'
	    set DB_Items[1][BaseNum()] = 'I048'
	    set DB_Items[1][BaseNum()] = 'I06P'
	    set DB_Items[1][BaseNum()] = 'I029'
		
		// Редкий
	    set udg_base = 0
	    set DB_Items[2][BaseNum()] = 'I07L'
	    set DB_Items[2][BaseNum()] = 'I02L'
	    set DB_Items[2][BaseNum()] = 'I044'
	    set DB_Items[2][BaseNum()] = 'I021'
	    set DB_Items[2][BaseNum()] = 'I02N'
	    set DB_Items[2][BaseNum()] = 'I06Q'
	    set DB_Items[2][BaseNum()] = 'I02V'
	    set DB_Items[2][BaseNum()] = 'I00H'
	    set DB_Items[2][BaseNum()] = 'I04A'
	    set DB_Items[2][BaseNum()] = 'I00P'
	    set DB_Items[2][BaseNum()] = 'I01X'
	    set DB_Items[2][BaseNum()] = 'I045'
	    set DB_Items[2][BaseNum()] = 'I09H'
	    set DB_Items[2][BaseNum()] = 'I0BI'
	    set DB_Items[2][BaseNum()] = 'I03W'
	    set DB_Items[2][BaseNum()] = 'I06N'
	    set DB_Items[2][BaseNum()] = 'I00B'
	    set DB_Items[2][BaseNum()] = 'I00C'
	    set udg_Database_NumberItems[2] = udg_base
		
		// Легендарный
	    set udg_base = 0
	    set DB_Items[3][BaseNum()] = 'I04L'
	    set DB_Items[3][BaseNum()] = 'I00T'
	    set DB_Items[3][BaseNum()] = 'I040'
	    set DB_Items[3][BaseNum()] = 'I04T'
	    set DB_Items[3][BaseNum()] = 'I020'
	    set DB_Items[3][BaseNum()] = 'I0BL'
	    set DB_Items[3][BaseNum()] = 'I05U'
	    set DB_Items[3][BaseNum()] = 'I00G'
	    set DB_Items[3][BaseNum()] = 'I00W'
	    set DB_Items[3][BaseNum()] = 'I06S'
	    set DB_Items[3][BaseNum()] = 'I01L'
	    set DB_Items[3][BaseNum()] = 'I070'
	    set DB_Items[3][BaseNum()] = 'I02S'
	    set DB_Items[3][BaseNum()] = 'I0H9'
	    set DB_Items[3][BaseNum()] = 'I0D6'
	    set DB_Items[3][BaseNum()] = 'I08T'
	    set udg_Database_NumberItems[3] = udg_base
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-pool", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope