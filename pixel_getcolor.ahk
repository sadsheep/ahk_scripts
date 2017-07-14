PixelColor(pc_x, pc_y, pc_wID)
{
    If pc_wID
    {
        pc_hDC := DllCall("GetDC", "UInt", pc_wID)
        WinGetPos, , , pc_w, pc_h, ahk_id %pc_wID%
        pc_hCDC := CreateCompatibleDC(pc_hDC)
        pc_hBmp := CreateCompatibleBitmap(pc_hDC, pc_w, pc_h)
        pc_hObj := SelectObject(pc_hCDC, pc_hBmp)
        
        pc_hmCDC := CreateCompatibleDC(pc_hDC)
        pc_hmBmp := CreateCompatibleBitmap(pc_hDC, 1, 1)
        pc_hmObj := SelectObject(pc_hmCDC, pc_hmBmp)
        
        DllCall("PrintWindow", "UInt", pc_wID, "UInt", pc_hCDC, "UInt", 0)
        DllCall("BitBlt" , "UInt", pc_hmCDC, "Int", 0, "Int", 0, "Int", 1, "Int", 1, "UInt", pc_hCDC, "Int", pc_x, "Int", pc_y, "UInt", 0xCC0020)
        pc_fmtI := A_FormatInteger
        SetFormat, Integer, Hex
        DllCall("GetBitmapBits", "UInt", pc_hmBmp, "UInt", VarSetCapacity(pc_bits, 4, 0), "UInt", &pc_bits)
        pc_c := NumGet(pc_bits, 0)
        SetFormat, Integer, %pc_fmtI%

        DeleteObject(pc_hBmp), DeleteObject(pc_hmBmp)
        DeleteDC(pc_hCDC), DeleteDC(pc_hmCDC)
        DllCall("ReleaseDC", "UInt", pc_wID, "UInt", pc_hDC)
        Return pc_c
    }
}


CreateCompatibleDC(hdc=0) {
    return DllCall("CreateCompatibleDC", "UInt", hdc)
}     

CreateCompatibleBitmap(hdc, w, h) {
    return DllCall("CreateCompatibleBitmap", UInt, hdc, Int, w, Int, w)
}

SelectObject(hdc, hgdiobj) {
    return DllCall("SelectObject", "UInt", hdc, "UInt", hgdiobj)
}

DeleteObject(hObject) {
   Return, DllCall("DeleteObject", "UInt", hObject)
}

DeleteDC(hdc) {
    Return, DllCall("DeleteDC", "UInt", hdc)
}
