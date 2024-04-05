library TagSystem initializer init requires Trigger

	globals
		private Tag array Tags
		private integer Tags_Max = 0
		
		public hashtable TagTable = InitHashtable()
	endglobals
	
	
	//Init
	//========================================================
	globals
		constant integer TAG_NULL = 0
		constant integer TAG_UNMERGED_ORB = 1
		constant integer TAG_TRIPLE_SET_PIECE = 2
	endglobals
	
	private function InitTags takes nothing returns nothing
		call Tag.create("Unmerged Orb", "unmerged_orb", TAG_UNMERGED_ORB)
		call Tag.create("Triple Set", "triple_set", TAG_TRIPLE_SET_PIECE)
	endfunction
	//========================================================
	
	
	//Public Functions
	//========================================================
	public function CheckTag takes integer itemType, integer tagType returns boolean
		if tagType < 1 or tagType > Tags_Max then
			call BJDebugMsg("Error! TagSystem - CheckTag: tagType out of range [1:" + I2S(Tags_Max) + "]. Current: " + I2S(tagType) )
			return false
		endif
		return LoadBoolean(TagTable, itemType, Tags[tagType].StringHash)
	endfunction
	
	public function CheckTagItem takes item itemUsed, integer tagType returns boolean
		if itemUsed == null then
			return false
		endif
		return CheckTag(GetItemTypeId(itemUsed), tagType)
	endfunction
	
	public function GetInventoryAmountOfTagItems takes unit hero, integer tagType returns integer
		local integer index = CorrectPlayer(hero)
		local player owner = Player(index - 1)
		local integer id = GetHandleId(owner)
		local integer stringHash
		
		set owner = null
		if tagType < 1 or tagType > Tags_Max then
			call BJDebugMsg("Error! TagSystem - GetInventoryAmountOfTagItems: tagType out of range [1:" + I2S(Tags_Max) + "]. Current: " + I2S(tagType) )
			return 0
		endif
		set stringHash = Tags[tagType].StringHash
		return LoadInteger(udg_hash, id, stringHash)
	endfunction
	
	public function GetTagData takes integer tagType returns Tag
		return Tags[tagType]
	endfunction
	
	public function GetTagsMax takes nothing returns integer
		return Tags_Max
	endfunction
	//========================================================
	
	struct Tag
		readonly integer StringHash
		readonly string Name
	
		static method create takes string name, string stringHash, integer index returns thistype
			local thistype p = thistype.allocate()
			
			set p.StringHash = StringHash(stringHash)
			set p.Name = name
			
			set Tags_Max = Tags_Max + 1
			set Tags[index] = p
			
            return p
        endmethod
	endstruct
	
	private function ChangeAmount takes unit caster, integer tagType, integer toAdd returns nothing
		local integer index = CorrectPlayer(caster)
		local player owner = Player(index - 1)
		local integer id = GetHandleId(owner)
		local integer stringHash = Tags[tagType].StringHash
		local integer amount = LoadInteger(udg_hash, id, stringHash)
		
		call SaveInteger(udg_hash, id, stringHash, amount + toAdd)
		
		set owner = null
	endfunction
	
	private function ToAdd takes integer toAdd returns nothing
		local unit caster = GetManipulatingUnit()
		local item itemCheck = GetManipulatedItem()
		local integer i = 1
		local integer iMax = Tags_Max
		local integer amount
		
		loop
			exitwhen i > iMax
			//call BJDebugMsg("i:")
			if CheckTagItem(itemCheck, i) then
				//call BJDebugMsg("FIND!")
				call ChangeAmount(caster, i, toAdd)
			endif
			set i = i + 1
		endloop
		
		set caster = null
		set itemCheck = null
	endfunction
	
	private function ItemAdd takes nothing returns nothing
		call ToAdd(1)
	endfunction
	
	private function ItemLose takes nothing returns nothing
		call ToAdd(-1)
	endfunction
	
	private function delay takes nothing returns nothing
		call InitTags()
		call TagSystemInit_Register.evaluate()
	endfunction

	private function init takes nothing returns nothing
		call TimerStart( CreateTimer(), 0.5, false, function delay )
		
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function ItemAdd, null )
		call CreateNativeEvent( EVENT_PLAYER_UNIT_DROP_ITEM, function ItemLose, null )
	endfunction

endlibrary