library TripleSet initializer init requires TagSystemInit

	globals
		private TripleSet array TripleSets
		private integer TripleSets_Max = 0
		
		public constant integer PIECE_AMOUNT = 3
	endglobals

	private function InitTripleSets takes nothing returns nothing
		call TripleSet.create('I000', 'I001', 'I002', 'I003')
		call TripleSet.create('I05V', 'I06A', 'I06B', 'I06K')
		call TripleSet.create('I0BK', 'I0AA', 'I0CV', 'I0EI')
		call TripleSet.create('I02Q', 'I02J', 'I02D', 'I02R')
		call TripleSet.create('I085', 'I08C', 'I07O', 'I09L')
	endfunction

	struct TripleSet
		readonly integer array Piece[PIECE_AMOUNT]
		readonly integer Reward
		readonly integer Id
		
		static method create takes integer piece1, integer piece2, integer piece3, integer reward returns thistype
			local thistype p = thistype.allocate()
			
			set p.Id = TripleSets_Max
			set TripleSets[TripleSets_Max] = p
			set TripleSets_Max = TripleSets_Max + 1
			
			set p.Piece[0] = piece1
			set p.Piece[1] = piece2
			set p.Piece[2] = piece3
			set p.Reward = reward
			
			call TagSystemInit_InitTripleSet(piece1, piece2, piece3)
			
            return p
        endmethod
        
        method IsPiece takes integer itemType returns boolean
        	local integer i = 0
    		loop
    			exitwhen i >= PIECE_AMOUNT
    			if .Piece[i] == itemType then
    				return true
    			endif
    			set i = i + 1
			endloop
			return false
        endmethod
        
        static method Get takes integer piece returns thistype
        	local integer i
        	local integer iMax
        	local integer k
        	local TripleSet tripleSet
        	
        	set i = 0
        	set iMax = TripleSets_Max
        	loop
        		exitwhen i >= iMax
        		set tripleSet = TripleSets[i]
        		set k = 0
        		loop
        			exitwhen k >= PIECE_AMOUNT
        			if tripleSet.Piece[k] == piece then
        				return tripleSet
        			endif
        			set k = k + 1
    			endloop
        		set i = i + 1
    		endloop
    		call BJDebugMsg("Error! TripleSet.Get: not found! Piece: " + I2S(piece) )
    		return 0
        endmethod
	endstruct
	
	private function delay takes nothing returns nothing
		call InitTripleSets()
	endfunction

	private function init takes nothing returns nothing
		call TimerStart( CreateTimer(), 0.55, false, function delay )
	endfunction

endlibrary