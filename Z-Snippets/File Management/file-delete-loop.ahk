Loop, C:\My_Folder\*.*, 1, 1
{
FileDelete, %A_LoopFileFullPath% ; Delete file
;FileRemoveDir, %A_LoopFileFullPath% ; Delete directory
}