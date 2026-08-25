library PotionShopDatabase initializer init

	struct PotionSlot
		readonly integer itemId
		readonly integer sizeType
		
        static method create takes integer itemId, integer sizeType returns PotionSlot
            local PotionSlot this = PotionSlot.allocate()
            
            set .itemId = itemId
            set .sizeType = sizeType
            return this
        endmethod
	
	endstruct

	globals
		public constant integer POTION_SLOTS = 12
		
		public constant integer POTION_SIZE_SMALL = 0
		public constant integer POTION_SIZE_MEDIUM = 1
		public constant integer POTION_SIZE_BIG = 2
		
		public integer array PotionSizeCost[4]
		public PotionSlot array Slot[POTION_SLOTS]
	endglobals
	
	private function init takes nothing returns nothing 
		set PotionSizeCost[POTION_SIZE_SMALL] = 40
		set PotionSizeCost[POTION_SIZE_MEDIUM] = 80
		set PotionSizeCost[POTION_SIZE_BIG] = 120
		
		set Slot[0] = PotionSlot.create('I054', POTION_SIZE_SMALL)
		set Slot[1] = PotionSlot.create('I055', POTION_SIZE_SMALL)
		set Slot[2] = PotionSlot.create('I056', POTION_SIZE_SMALL)
		set Slot[3] = PotionSlot.create('I057', POTION_SIZE_SMALL)
		set Slot[4] = PotionSlot.create('I058', POTION_SIZE_MEDIUM)
		set Slot[5] = PotionSlot.create('I059', POTION_SIZE_MEDIUM)
		set Slot[6] = PotionSlot.create('I05B', POTION_SIZE_MEDIUM)
		set Slot[7] = PotionSlot.create('I05A', POTION_SIZE_MEDIUM)
		set Slot[8] = PotionSlot.create('I0HW', POTION_SIZE_MEDIUM)
		set Slot[9] = PotionSlot.create('I0HX', POTION_SIZE_MEDIUM)
		set Slot[10] = PotionSlot.create('I05C', POTION_SIZE_BIG)
		set Slot[11] = PotionSlot.create('I05D', POTION_SIZE_BIG)
	endfunction

endlibrary