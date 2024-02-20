library TrashCollector

    private function OnRemoveUnit takes unit u returns nothing
        call FlushChildHashtable( udg_hash, GetHandleId(u) )
    endfunction
    
    //Barnacle Blood Issue
    /*private function OnRemoveItem takes item it returns nothing
        call FlushChildHashtable( udg_hash, GetHandleId(it) )
    endfunction*/
    
    private function OnRemoveTimer takes timer tim returns nothing
        call FlushChildHashtable( udg_hash, GetHandleId(tim) )
    endfunction

    hook RemoveUnit OnRemoveUnit
    //hook RemoveItem OnRemoveItem
    hook DestroyTimer OnRemoveTimer
    
endlibrary