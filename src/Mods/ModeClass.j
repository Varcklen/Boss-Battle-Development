library ModeClass initializer init requires TextLib

	globals
		public ListInt InactiveBlesses
		public ListInt InactiveCurses
		
		public ListInt ActiveBlesses 
		public ListInt ActiveCurses
	endglobals

	struct Mode
		readonly integer Info
		readonly boolean IsBless
		readonly integer id
		
		private ListInt CurrentList
		
		readonly string ScopeName
		
		readonly boolean IsActive = false
		
		static method create takes integer info, string scopeName, boolean isBless returns thistype
			local thistype p = thistype.allocate()
			
			set p.Info = info
			set p.IsBless = isBless
			set p.id = si__Mode_I
			set p.ScopeName = scopeName
			
			if isBless then
				set p.CurrentList = InactiveBlesses
			else
				set p.CurrentList = InactiveCurses
			endif
			call p.CurrentList.Add(p)
			
            return p
        endmethod
        
        method SetState takes boolean isActive returns nothing
        	if .IsActive == isActive then
        		call BJDebugMsg("Error! Mode - SetState: You're trying to set \"" + B2S(isActive) + "\" for mode " + BlzGetAbilityTooltip(.Info, 0) + " that already in this state." )
        		return
        	endif
        	
        	set .IsActive = isActive
        	if isActive then
        		call .CurrentList.RemoveByData(this)
        		if .IsBless then
					set .CurrentList = ActiveBlesses
				else
					set .CurrentList = ActiveCurses
				endif
        		call .CurrentList.Add(this)
        	else
        		call .CurrentList.RemoveByData(this)
        		if .IsBless then
					set .CurrentList = InactiveBlesses
				else
					set .CurrentList = InactiveCurses
				endif
        		call .CurrentList.Add(this)
        	endif
        endmethod
	endstruct
	
	private function init takes nothing returns nothing
		set InactiveBlesses = ListInt.create()
		set InactiveCurses = ListInt.create()
		
		set ActiveBlesses = ListInt.create()
		set ActiveCurses = ListInt.create()
	endfunction

endlibrary