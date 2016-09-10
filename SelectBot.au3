#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icons\Elegantthemes-Beautiful-Flat-Compose.ico
#AutoIt3Wrapper_Outfile=SelectBot.Exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=For MyBot.run. Made by Fliegerfaust
#AutoIt3Wrapper_Res_Description=SelectBot for MyBot
#AutoIt3Wrapper_Res_Fileversion=3.6
#AutoIt3Wrapper_Res_LegalCopyright=Fliegerfaust
#AutoIt3Wrapper_Add_Constants=n
#AutoIt3Wrapper_Run_Tidy=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; *** Start added by AutoIt3Wrapper ***
#include <FileConstants.au3>
; *** End added by AutoIt3Wrapper ***
; *** Start added by AutoIt3Wrapper ***
#include <MsgBoxConstants.au3>
; *** End added by AutoIt3Wrapper ***
#AutoIt3Wrapper_Res_Icon_Add=C:\Users\sturm\Desktop\MyBot.ico
; *** Start added by AutoIt3Wrapper ***
#include <AutoItConstants.au3>
#include <ListBoxConstants.au3>
; *** End added by AutoIt3Wrapper ***
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ComboConstants.au3>
#include <WinAPIFiles.au3>
#include <File.au3>
#include <Array.au3>
#include <GuiMenu.au3>
#include <InetConstants.au3>
#include <Misc.au3>
#include <WinAPI.au3>
#include <EditConstants.au3>

Global $File = "mybot.run.exe"
Global $File1 = "mybot.run.au3"
Global $iFlag = 0, $MyVersion = "3.6"
Global $ProfileDir = @MyDocumentsDir & "\Profiles.ini"
Global Enum $IdRun = 1000, $IdEdit, $IdDelete, $IdNick

GUI_Main()

Func GUI_Main()

	Global $GUI_MAIN = GUICreate("Select", 258, 452, -1, -1)
	Global $List_Main = GUICtrlCreateList("", 8, 24, 241, 305, BitOR($LBS_SORT, $LBS_NOTIFY))
	$LabelSetups = GUICtrlCreateLabel("Your saved Setups:", 8, 4, 200, 17)
	Global $LabelLog = GUICtrlCreateLabel("Made by: Fliegerfaust", 8, 416, 244, 17)
	$ButtonSetup = GUICtrlCreateButton("New Setup", 8, 336, 107, 25, $WS_GROUP)
	Global $ButtonShortcut = GUICtrlCreateButton("New Shortcut", 136, 336, 113, 25, $WS_GROUP)
	Global $ButtonAutoStart = GUICtrlCreateButton("Auto Start", 136, 368, 113, 25, $WS_GROUP)
	$MenuHelp = GUICtrlCreateMenu("&Help")
	$MenuHelpPop = GUICtrlCreateMenuItem("Help", $MenuHelp)
	$MenuTopic = GUICtrlCreateMenuItem("Forum Topic", $MenuHelp)
	$MenuDir = GUICtrlCreateMenuItem("Profile Directory", $MenuHelp)
	$MenuEmu = GUICtrlCreateMenu("&Emulators")
	$MenuBS1 = GUICtrlCreateMenuItem("BlueStacks", $MenuEmu)
	$MenuBS2 = GUICtrlCreateMenuItem("BlueStacks2", $MenuEmu)
	$MenuMEmu = GUICtrlCreateMenuItem("MEmu", $MenuEmu)
	$MenuDroid = GUICtrlCreateMenuItem("Droid4X", $MenuEmu)
	$MenuNox = GUICtrlCreateMenuItem("Nox", $MenuEmu)
	$MenuLD = GUICtrlCreateMenuItem("LeapDroid", $MenuEmu)
	$MenuUpdate = GUICtrlCreateMenu("Updates")
	$MenuCheck = GUICtrlCreateMenuItem("Check for Updates", $MenuUpdate)
	$MenuMisc = GUICtrlCreateMenu("Misc")
	$MenuClear = GUICtrlCreateMenuItem("Clear Local Files", $MenuMisc)
	GUISetState(@SW_SHOW)
	; GUI MAIN



	GUIRegisterMsg($WM_CONTEXTMENU, "WM_CONTEXTMENU")
	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
	; GUI MAIN CONTEXT MENU AND DOUBLE CLICK RUN FUNCTION

	Global $hMenu = _GUICtrlMenu_CreatePopup()

	_GUICtrlMenu_InsertMenuItem($hMenu, 0, "Run", $IdRun)
	_GUICtrlMenu_InsertMenuItem($hMenu, 1, "Edit", $IdEdit)
	_GUICtrlMenu_InsertMenuItem($hMenu, 2, "Delete", $IdDelete)
	_GUICtrlMenu_InsertMenuItem($hMenu, 3, "Nickname", $IdNick)
	;CONTEXT MENU OF MAIN GUI


	$Read1 = ""

	If FileExists($ProfileDir) Then
		$Read1 = FileRead($ProfileDir)

	EndIf

	UpdateList_Main()

	If $Read1 = "" Then
		GUICtrlSetState($ButtonShortcut, $GUI_DISABLE)
		GUICtrlSetState($ButtonAutoStart, $GUI_DISABLE)
	Else
		Dim $section = IniReadSectionNames($ProfileDir)
		Do
			$Rdm = Random(1, UBound($section) - 1, 1)
		Until $Rdm <> ''
		_GUICtrlListBox_ClickItem($List_Main, $Rdm)
	EndIf

	While 1
		$aMsg = GUIGetMsg(1)
		Switch $aMsg[1]

			Case $GUI_MAIN
				Switch $aMsg[0]
					Case $GUI_EVENT_CLOSE
						ExitLoop

					Case $GUI_EVENT_SECONDARYDOWN

						Global $lst1 = GUICtrlRead($List_Main)
						If $lst1 = "" Then
							$iFlag = Not $iFlag
						EndIf




					Case $MenuHelpPop
						WinSetOnTop($GUI_MAIN, "", $Windows_NOONTOP)
						MsgBox(0, "Help", "To create a new Setup just press the New Setup Button and walk through the Guide!" & @CRLF & @CRLF & "To create a new Shortcut just press the New Shortcut Button and a Shortcut gets created on your Desktop!" & @CRLF & @CRLF & "Double Click an Item in the List to start the Bot with the highlighted Setup!" & @CRLF & @CRLF & "Right Click for a Context Menu." & @CRLF & @CRLF & "The Auto Updater will be downloaded and when you turn it off it will stay there but won't activate. When you delete this Tool make sure to Click on Misc and then Clear Local Files!")

					Case $MenuTopic
						ShellExecute("https://mybot.run/forums/index.php?/topic/15860-how-to-run-multiple-botshow-to-bot-on-droid4x-and-memu-w-updated-tool/")

					Case $MenuDir
						ShellExecute(@MyDocumentsDir)


					Case $MenuBS1
						ShellExecute("https://mega.nz/#!GFVilDAL!Wkyp2xpxFOx8J_Gz8wIf0jGSxTT3IiT6xthvrHhRbME")

					Case $MenuBS2
						ShellExecute("https://mega.nz/#!BpdEUBbZ!4unxWMPzA5rESONTVgNrxlNxSj8H2wwicx4Q15PmBo4")

					Case $MenuMEmu
						ShellExecute("http://www.memuplay.com/download.php?file_name=Memu-Setup&from=home_en")

					Case $MenuDroid
						ShellExecute("http://dl.haima.me/download/DXDown/win/Z001/Droid4XInstaller.exe")

					Case $MenuNox
						ShellExecute("http://en.bignox.com/en/download/fullPackage")
					Case $MenuLD
						ShellExecute("http://www.leapdroid.com/installer/current/LeapdroidVMInstallerFull.exe")

					Case $MenuCheck

						$sFilePath = _WinAPI_GetTempFileName(@TempDir)
						$hDownload = InetGet("https://raw.githubusercontent.com/Fliegerfaust33/SelectBot/master/CheckUpdate.txt", $sFilePath, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)
						Do
							Sleep(250)
						Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE)

						InetClose($hDownload)
						$GitVers = FileRead($sFilePath)
						$GitVers = StringStripWS($GitVers, 8)
						$Update = _VersionCompare($MyVersion, $GitVers)

						Select
							Case $Update = -1
								$msg1 = MsgBox(4, "Update", "New SelectBot Update found" & @CRLF & "New: " & $GitVers & @CRLF & "Old: " & $MyVersion & @CRLF & "Do you want to download it?")
							Case $Update = 0
								MsgBox(0, "Update", "No new Update found (" & $MyVersion & ")")
							Case $Update = 1
								MsgBox(0, "Update", "You are using a future Version (" & $MyVersion & ")")
						EndSelect

						FileDelete($sFilePath)

					Case $MenuClear
						$msgDelete = MsgBox(4, "Delete Local Files", "This will delete all SelectBot Files (Profiles, Config and Auto Update) Do you want to proceed?")
						If $msgDelete = 6 Then
							FileDelete(@StartupDir & "\SelectBotAutoUpdate.exe")
							FileDelete($ProfileDir)
							GUICtrlSetData($List_Main, "")
							UpdateList_Main()
							If FileRead($ProfileDir) = "" Then
								GUICtrlSetState($ButtonShortcut, $GUI_DISABLE)
								GUICtrlSetState($ButtonAutoStart, $GUI_DISABLE)
							EndIf
							MsgBox(1, "Delete Local Files", "Deleted all Files from your Computer!")

						EndIf



					Case $ButtonSetup

						WinSetOnTop($GUI_MAIN, "", $Windows_ONTOP)
						GUICtrlSetData($LabelLog, "Profile Creation started!")
						Do
							GUISetState(@SW_DISABLE, $GUI_MAIN)
							Local $profileresult = GUI_Profile()
							If $profileresult = -1 Then
								ExitLoop
							Else
								Local $emulatorResult = GUI_Emulator()
							EndIf
							If $emulatorResult = -1 Then
								ExitLoop
							Else
								Local $instanceResult = GUI_Instance()
							EndIf
							If $instanceResult = -1 Then
								ExitLoop
							Else
								GUI_DIR()
							EndIf
							UpdateList_Main()



						Until 1
						If FileRead($ProfileDir) <> "" Then
							GUICtrlSetState($ButtonShortcut, $GUI_ENABLE)
							GUICtrlSetState($ButtonAutoStart, $GUI_ENABLE)
						EndIf
						GUISetState(@SW_ENABLE, $GUI_MAIN)
						WinSetOnTop($GUI_MAIN, "", $Windows_NOONTOP)



					Case $ButtonAutoStart
						WinSetOnTop($GUI_MAIN, "", $Windows_ONTOP)
						GUI_AutoStart()
						GUISetState(@SW_ENABLE, $GUI_MAIN)
						WinSetOnTop($GUI_MAIN, "", $Windows_NOONTOP)




					Case $ButtonShortcut

						$UIpt11 = ""
						$selectedProfile = GUICtrlRead($List_Main)
						$UIpt1 = IniRead($ProfileDir, $selectedProfile, "Profile", "")
						$String = StringRegExp($UIpt1, " ")
						If $String = 1 Then
							$UIpt11 = '"' & $UIpt1 & '"'
						EndIf
						$UIpt2 = IniRead($ProfileDir, $selectedProfile, "Emulator", "")
						$UIpt3 = IniRead($ProfileDir, $selectedProfile, "Instance", "")
						$UIpt4 = IniRead($ProfileDir, $selectedProfile, "Dir", "")

						$File3 = FileExists($UIpt4 & "\" & $File)
						$File4 = FileExists($UIpt4 & "\" & $File1)
						If $File3 = 1 Then
							FileCreateShortcut($UIpt4 & "\" & $File, @DesktopDir & "\MyBot -" & $UIpt1 & ".lnk", $UIpt4, $UIpt11 & " " & $UIpt2 & " " & $UIpt3, "Shortcut For Bot Profile : " & $UIpt1)
						ElseIf $File4 = 1 Then
							FileCreateShortcut($UIpt4 & "\" & $File1, @DesktopDir & "\MyBot -" & $UIpt1 & ".lnk", $UIpt4, $UIpt11 & " " & $UIpt2 & " " & $UIpt3, "Shortcut for Bot Profile:" & $UIpt1)
						Else
							MsgBox(0, "No Bot found", "Couldn't find any Bot in the Directory, please check if you have the mybot.run.exe or the mybot.run.au3 in the Dir and if you selected the right Dir!")
						EndIf

						GUICtrlSetData($LabelLog, "Shortcut successfully made, check your Desktop")
				EndSwitch





		EndSwitch



	WEnd
EndFunc   ;==>GUI_Main


Func WM_CONTEXTMENU($hWnd, $Msg, $wParam, $lParam) ;Popup Menu only on click on List Item
	Local $tPoint = _WinAPI_GetMousePos(True, GUICtrlGetHandle($List_Main))
	Local $iY = DllStructGetData($tPoint, "Y")

	$lst2 = GUICtrlRead($List_Main)
	If $lst2 <> "" Then
		For $i = 0 To 50
			Local $aRect = _GUICtrlListBox_GetItemRect($List_Main, $i)
			If ($iY >= $aRect[1]) And ($iY <= $aRect[3]) Then _ContextMenu($i)
		Next
		Return $GUI_RUNDEFMSG

	Else
		If $iFlag Then Return 0
		Return $GUI_RUNDEFMSG
	EndIf
EndFunc   ;==>WM_CONTEXTMENU

Func _ContextMenu($sItem) ;Popup Menu
	Switch _GUICtrlMenu_TrackPopupMenu($hMenu, GUICtrlGetHandle($List_Main), -1, -1, 1, 1, 2)
		Case $IdRun
			RunSetup()

		Case $IdEdit

			GUISetState(@SW_DISABLE, $GUI_MAIN)
			GUICtrlSetData($LabelLog, "Starting to edit Profile")
			GUI_Edit()
			WinSetOnTop($GUI_MAIN, "", $WINDOWS_ONTOP)
			GUICtrlSetData($LabelLog, "Editing Profile done")
			GUISetState(@SW_ENABLE, $GUI_MAIN)

		Case $IdDelete

			$PName = GUICtrlRead($List_Main)
			IniDelete(@MyDocumentsDir & "\Profiles.ini", $PName)
			GUICtrlSetData($LabelLog, "Deleted Profile:" & " " & $PName)
			GUICtrlSetData($List_Main, "")
			UpdateList_Main()
			If FileRead(@MyDocumentsDir & "\Profiles.ini") = "" Then
				GUICtrlSetState($ButtonShortcut, $GUI_DISABLE)
				GUICtrlSetState($ButtonAutoStart, $GUI_DISABLE)
			EndIf

		Case $IdNick

			$ReadProf = GUICtrlRead($List_Main)
			$NickIni = IniRead($ProfileDir, $ReadProf, "profile", "")
			$NickIpt = InputBox("Give Profile a Nickname", "Here you can set a NickName for each Setup. It will be shown in Brackets behind the Profile Name! To Remove a Nick just press OK when nothing is in the Input!")
			If $NickIpt = "" Then
				IniRenameSection($ProfileDir, $ReadProf, $NickIni)
			Else
				IniRenameSection($ProfileDir, $ReadProf, $NickIni & " ( " & $NickIpt & " )")
			EndIf
			UpdateList_Main()

	EndSwitch
EndFunc   ;==>_ContextMenu



Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam) ; Double Click to Run Profile


	#forceref $hWnd, $iMsg
	Local $hWndFrom, $iIDFrom, $iCode, $hWndListBox
	If Not IsHWnd($List_Main) Then $hWndListBox = GUICtrlGetHandle($List_Main)
	$hWndFrom = $lParam
	$iIDFrom = BitAND($wParam, 0xFFFF)
	$iCode = BitShift($wParam, 16)

	Switch $hWndFrom
		Case $List_Main, $hWndListBox
			Switch $iCode
				Case $LBN_DBLCLK
					RunSetup()

			EndSwitch
	EndSwitch

	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND


Func GUI_Profile()
	Global $GUI_PROFILE = GUICreate("Profile", 255, 167, -1, -1)
	$InputP1 = GUICtrlCreateInput("", 24, 72, 201, 21)
	$ButtonP1 = GUICtrlCreateButton("Next step", 72, 120, 97, 25, $WS_GROUP)
	GUICtrlSetState($ButtonP1, $GUI_DISABLE)
	$LabelP1 = GUICtrlCreateLabel("Please type in the full Name of your Profile to continue", 24, 8, 204, 57)
	GUISetState()

	WinSetOnTop($GUI_PROFILE, "", $WINDOWS_ONTOP)


	Local $btnEnabled = False
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				Global $Prof2 = GUICtrlRead($InputP1)
				IniDelete($ProfileDir, $Prof2)
				GUICtrlSetData($LabelLog, "Profile Selection cancelled!")
				GUIDelete($GUI_PROFILE)
				Return -1
			Case $ButtonP1
				Global $Prof = GUICtrlRead($InputP1)
				GUICtrlSetData($LabelLog, "Profile:" & " " & $Prof)
				IniWrite($ProfileDir, $Prof, "Profile", $Prof)
				GUIDelete($GUI_PROFILE)
				Return 0
		EndSwitch
		If $btnEnabled Then ContinueLoop
		$IptP1 = GUICtrlRead($InputP1)
		If $IptP1 = "" Then
			ContinueLoop
		Else
			GUICtrlSetState($ButtonP1, $GUI_ENABLE)
			$btnEnabled = True
		EndIf
	WEnd
EndFunc   ;==>GUI_Profile


Func GUI_Emulator()
	Global $GUI_EMULATOR = GUICreate("Emulator", 255, 167, -1, -1)
	$ComboE1 = GUICtrlCreateCombo("BlueStacks", 24, 72, 201, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData($ComboE1, "BlueStacks2|MEmu|Droid4x|Nox|LeapDroid")
	$ButtonE1 = GUICtrlCreateButton("Next step", 72, 120, 97, 25, $WS_GROUP)
	$LabelE1 = GUICtrlCreateLabel("Please select your Emulator", 24, 8, 204, 57)
	GUISetState()

	WinSetOnTop($GUI_EMULATOR, "", $WINDOWS_ONTOP)


	While 1

		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				IniDelete($ProfileDir, $Prof)
				GUICtrlSetData($LabelLog, "Profile Creation cancelled.")
				GUIDelete($GUI_EMULATOR)
				Return -1
			Case $ButtonE1
				Global $Emu = GUICtrlRead($ComboE1)
				GUICtrlSetData($LabelLog, "Emulator:" & " " & $Emu)
				IniWrite($ProfileDir, $Prof, "Emulator", $Emu)
				GUIDelete($GUI_EMULATOR)
				Return 0

		EndSwitch
	WEnd
EndFunc   ;==>GUI_Emulator


Func GUI_Instance()
	Local $bs = 0
	Global $GUI_INSTANCE = GUICreate("Instance", 255, 167, -1, -1)
	Local $InputI1 = GUICtrlCreateInput("", 24, 72, 201, 21)
	$ButtonI1 = GUICtrlCreateButton("Next step", 72, 120, 97, 25, $WS_GROUP)
	Global $LabelI1 = GUICtrlCreateLabel("Please write the Instance Name you want to link", 24, 8, 204, 57)
	$Emulator = IniRead($ProfileDir, $Prof, "Emulator", "")
	GUISetState(@SW_HIDE, $GUI_INSTANCE)

	WinSetOnTop($GUI_INSTANCE, "", $WINDOWS_ONTOP)


	If $Emu = "BlueStacks" Or $Emu = "BlueStacks2" Then
		$bs = 1
	ElseIf $Emu = "MEmu" Then
		GUISetState(@SW_SHOW, $GUI_INSTANCE)
		GUICtrlSetData($LabelI1, "Please type in your MEmu Instance Name! Example: MEmu , MEmu_1, MEmu_2, etc")
		GUICtrlSetData($InputI1, "MEmu_")
	ElseIf $Emu = "Droid4x" Then
		GUISetState(@SW_SHOW, $GUI_INSTANCE)
		GUICtrlSetData($LabelI1, "Please type in your Droid4x Instance Name! Example: droid4x , droid4x_1, droid4x_2, etc")
		GUICtrlSetData($InputI1, "droid4x_")
	ElseIf $Emu = "Nox" Then
		GUISetState(@SW_SHOW, $GUI_INSTANCE)
		GUICtrlSetData($LabelI1, "Please type in your Nox Instance Name! Example: nox , nox_1, nox_2, etc")
		GUICtrlSetData($InputI1, "nox_")
	Else
		GUISetState(@SW_SHOW, $GUI_INSTANCE)
		GUICtrlSetData($LabelI1, "Please type in your LeapDroid Instance Name! Example: vm1 , vm2, etc")
		GUICtrlSetData($InputI1, "vm")
	EndIf





	While 1

		If $bs = 1 Then
			ExitLoop

		EndIf


		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUIDelete($GUI_INSTANCE)
				IniDelete($ProfileDir, $Prof)
				GUICtrlSetData($LabelLog, "Profile Creation cancelled.")
				Return -1
			Case $ButtonI1
				$Inst = GUICtrlRead($InputI1)
				GUICtrlSetData($LabelLog, "Instance:" & " " & $Inst)
				IniWrite($ProfileDir, $Prof, "Instance", $Inst)
				GUIDelete($GUI_INSTANCE)
				Return 0

		EndSwitch
	WEnd
EndFunc   ;==>GUI_Instance

Func GUI_DIR()
	Global $GUI_DIR = GUICreate("Directory", 255, 167, -1, -1)
	$ButtonD1 = GUICtrlCreateButton("Choose Folder", 24, 72, 201, 21)
	$ButtonD2 = GUICtrlCreateButton("Finish", 72, 120, 97, 25, $WS_GROUP)
	GUICtrlSetState($ButtonD2, $GUI_DISABLE)
	$LabelD1 = GUICtrlCreateLabel("Please select the MyBot Folder where the mybot.run.exe or .au3 is located at", 24, 8, 204, 57)
	GUISetState()

	WinSetOnTop($GUI_DIR, "", $WINDOWS_ONTOP)



	While 1

		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				IniDelete($ProfileDir, $Prof)
				GUICtrlSetData($LabelLog, "Profile Creation cancelled")
				GUIDelete($GUI_DIR)
				ExitLoop

			Case $ButtonD1
				WinSetOnTop($GUI_MAIN, "", $WINDOWS_NOONTOP)
				WinSetOnTop($GUI_DIR, "", $WINDOWS_NOONTOP)
				Local $sFileSelectFolder = FileSelectFolder("Select your MyBot Folder", "")
				If @error Then
					GUICtrlSetData($LabelLog, "File Selection aborted.")
				Else
					GUICtrlSetData($LabelLog, $sFileSelectFolder)
					WinSetOnTop($GUI_MAIN, "", $WINDOWS_ONTOP)
					WinSetOnTop($GUI_DIR, "", $WINDOWS_ONTOP)
				EndIf


				If $sFileSelectFolder = "" Then
					ContinueLoop
				ElseIf FileExists($sFileSelectFolder & "\" & $File) = 0 Or FileExists($sFileSelectFolder & "\" & $File1) = 0 Then
					WinSetOnTop($GUI_MAIN, "", $WINDOWS_NOONTOP)
					WinSetOnTop($GUI_DIR, "", $WINDOWS_NOONTOP)
					MsgBox(0, "Error", "Looks like there is no runable mybot file in the Folder? Did you select the right folder or is in the Folder the mybot.run.exe or mybot.run.au3 renamed? Please select another Folder or rename Files!")
					WinSetOnTop($GUI_MAIN, "", $WINDOWS_ONTOP)
					WinSetOnTop($GUI_DIR, "", $WINDOWS_ONTOP)
					GUICtrlSetData($LabelLog, "No Runable File found in the Dir")
					ContinueLoop
				Else
					GUICtrlSetState($ButtonD2, $GUI_ENABLE)
				EndIf

			Case $ButtonD2

				IniWrite($ProfileDir, $Prof, "Dir", $sFileSelectFolder)
				GUICtrlSetData($LabelLog, "Profile got created successfully!")
				UpdateList_Main()
				GUIDelete($GUI_DIR)
				ExitLoop



		EndSwitch
	WEnd




EndFunc   ;==>GUI_DIR

Func GUI_Edit()


	$PN = GUICtrlRead($List_Main)
	$IniCont1 = IniRead($ProfileDir, $PN, "Profile", "")
	$IniCont2 = IniRead($ProfileDir, $PN, "Emulator", "")
	$IniCont3 = IniRead($ProfileDir, $PN, "Instance", "")
	$IniCont4 = IniRead($ProfileDir, $PN, "Dir", "")


	$GUI_EDIT = GUICreate("Edit INI", 255, 187, -1, -1)
	$InputED1 = GUICtrlCreateInput("", 112, 8, 137, 21)
	$InputED2 = GUICtrlCreateCombo($IniCont2, 112, 40, 137, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	$InputED3 = GUICtrlCreateInput("", 112, 72, 137, 21)
	$ButtonED2 = GUICtrlCreateButton("Open Dialog", 112, 105, 137, 23, $WS_GROUP)
	$LabelED1 = GUICtrlCreateLabel("Profile Name:", 8, 8, 95, 17)
	$LabelED2 = GUICtrlCreateLabel("Emulator:", 8, 40, 95, 17)
	$LabelED3 = GUICtrlCreateLabel("Instance:", 8, 72, 95, 17)
	$LabelED4 = GUICtrlCreateLabel("Directory:", 8, 104, 95, 17)
	$ButtonED1 = GUICtrlCreateButton("Save and Close", 76, 150, 97, 25, $WS_GROUP)
	GUISetState()

	$sFileSelectFolder = $IniCont4

	GUICtrlSetData($InputED1, $IniCont1)
	GUICtrlSetData($InputED2, $IniCont2)
	GUICtrlSetData($InputED3, $IniCont3)

	Select
		Case $IniCont2 = "BlueStacks"
			GUICtrlSetData($InputED2, "BlueStacks2|MEmu|Droid4X|Nox|LeapDroid")
			GUICtrlSetState($InputED3, $GUI_DISABLE)
		Case $IniCont2 = "BlueStacks2"
			GUICtrlSetData($InputED2, "BlueStacks|MEmu|Droid4X|Nox|LeapDroid")
			GUICtrlSetState($InputED3, $GUI_DISABLE)
		Case $IniCont2 = "MEmu"
			GUICtrlSetData($InputED2, "BlueStacks|BlueStacks2|Droid4X|Nox|LeapDroid")
		Case $IniCont2 = "Droid4X"
			GUICtrlSetData($InputED2, "BlueStacks|BlueStacks2|MEmu|Nox|LeapDroid")
		Case $IniCont2 = "Nox"
			GUICtrlSetData($InputED2, "BlueStacks|BlueStacks2|MEmu|Droid4X|LeapDroid")
		Case $IniCont2 = "LeapDroid"
			GUICtrlSetData($InputED2, "BlueStacks|BlueStacks2|MEmu|Droid4X|Nox")
		Case Else
			MsgBox(1, "Error", "Oops, as it looks like you changed Data in the Config File. Please revert it or delete the corrupted Section:" & $PN)
	EndSelect



	WinSetOnTop($GUI_MAIN, "", $WINDOWS_ONTOP)
	WinSetOnTop($GUI_EDIT, "", $WINDOWS_ONTOP)

	While 1

		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUICtrlSetData($LabelLog, "Editing cancelled")
				GUIDelete($GUI_EDIT)
				ExitLoop

			Case $InputED2

				$Ipt22 = GUICtrlRead($InputED2)
				If $Ipt22 = "BlueStacks" Or $Ipt22 = "BlueStacks2" Then
					GUICtrlSetState($InputED3, $GUI_DISABLE)
					GUICtrlSetData($InputED3, "")
				Else
					GUICtrlSetState($InputED3, $GUI_ENABLE)
					Select
						Case $Ipt22 = "MEmu"
							GUICtrlSetData($InputED3, "MEmu_")
						Case $Ipt22 = "Droid4X"
							GUICtrlSetData($InputED3, "droid4x_")
						Case $Ipt22 = "Nox"
							GUICtrlSetData($InputED3, "Nox_")
						Case $Ipt22 = "LeapDroid"
							GUICtrlSetData($InputED3, "vm")
						Case Else
							MsgBox(1, "Error", "Oops, as it looks like you changed Data in the Config File. Please revert it or delete the corrupted Section:" & $PN)
					EndSelect
				EndIf


			Case $ButtonED2

				WinSetOnTop($GUI_MAIN, "", $WINDOWS_NOONTOP)
				WinSetOnTop($GUI_EDIT, "", $WINDOWS_NOONTOP)
				Local $sFileSelectFolder = FileSelectFolder("Select your MyBot Folder", $IniCont4)
				WinSetOnTop($GUI_MAIN, "", $WINDOWS_ONTOP)
				WinSetOnTop($GUI_EDIT, "", $WINDOWS_ONTOP)


			Case $ButtonED1

				WinSetOnTop($GUI_MAIN, "", $WINDOWS_ONTOP)
				WinSetOnTop($GUI_EDIT, "", $WINDOWS_NOONTOP)
				$Ipt1 = GUICtrlRead($InputED1)
				$Ipt2 = GUICtrlRead($InputED2)
				$Ipt3 = GUICtrlRead($InputED3)
				IniDelete(@MyDocumentsDir & "\Profiles.ini", $PN)
				$IniCont11 = IniWrite($ProfileDir, $Ipt1, "Profile", $Ipt1)
				$IniCont22 = IniWrite($ProfileDir, $Ipt1, "Emulator", $Ipt2)
				$IniCont33 = IniWrite($ProfileDir, $Ipt1, "Instance", $Ipt3)
				$IniCont44 = IniWrite($ProfileDir, $Ipt1, "Dir", $sFileSelectFolder)
				GUICtrlSetData($List_Main, "")
				UpdateList_Main()
				GUIDelete($GUI_EDIT)

				ExitLoop


		EndSwitch

	WEnd
EndFunc   ;==>GUI_Edit


Func GUI_AutoStart()

	$GUI_AS = GUICreate("Auto Start Setup", 255, 187, -1, -1)
	Global $List_AS = GUICtrlCreateList("", 8, 48, 241, 84, BitOR($LBS_SORT, $LBS_NOTIFY, $LBS_NOSEL))
	$LabelA1 = GUICtrlCreateLabel("Add or Remove a Profile from Autostart" & @CRLF & "These are currently in the Folder:", 8, 8, 220, 34)
	$ButtonA1 = GUICtrlCreateButton("Add", 8, 144, 97, 25, $WS_GROUP)
	Local $ButtonA2 = GUICtrlCreateButton("Remove", 152, 144, 97, 25, $WS_GROUP)
	$Text = ""
	$profileAS = GUICtrlRead($List_Main)
	GUISetState()


	WinSetOnTop($GUI_MAIN, "", $WINDOWS_ONTOP)
	WinSetOnTop($GUI_AS, "", $WINDOWS_ONTOP)

	UpdateList_AS()
	$FileAS1 = FileExists(@StartupDir & "\MyBot -" & $profileAS & ".lnk")
	If $FileAS1 = 0 Then
		GUICtrlSetState($ButtonA2, $GUI_DISABLE)

	Else
		GUICtrlSetState($ButtonA2, $GUI_ENABLE)
	EndIf

	$FileAS2 = FileExists(@StartupDir & "\MyBot -" & $profileAS & ".lnk")
	If $FileAS2 = 0 Then
		GUICtrlSetState($ButtonA1, $GUI_ENABLE)
	Else
		GUICtrlSetState($ButtonA1, $GUI_DISABLE)
	EndIf


	While 1

		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUICtrlSetData($LabelLog, "Auto Start Setup stopped")
				GUIDelete($GUI_AS)
				ExitLoop
			Case $ButtonA1

				$UIpt11 = ""
				$UIpt1 = IniRead($ProfileDir, $profileAS, "Profile", "")
				$String = StringRegExp($UIpt1, " ")
				If $String = 1 Then
					$UIpt11 = '"' & $UIpt1 & '"'
				EndIf
				$UIpt2 = IniRead($ProfileDir, $profileAS, "Emulator", "")
				$UIpt3 = IniRead($ProfileDir, $profileAS, "Instance", "")
				$UIpt4 = IniRead($ProfileDir, $profileAS, "Dir", "")

				$File3 = FileExists($UIpt4 & "\" & $File)
				$File4 = FileExists($UIpt4 & "\" & $File1)
				If $File3 = 1 Then
					FileCreateShortcut($UIpt4 & "\" & $File, @StartupDir & "\MyBot -" & $UIpt1 & ".lnk", $UIpt4, $UIpt11 & " " & $UIpt2 & " " & $UIpt3, "Shortcut for Bot Profile:" & $UIpt1)

				ElseIf $File4 = 1 Then
					FileCreateShortcut($UIpt4 & "\" & $File1, @StartupDir & "\MyBot -" & $UIpt1 & ".lnk", $UIpt4, $UIpt11 & " " & $UIpt2 & " " & $UIpt3, "Shortcut for Bot Profile:" & $UIpt1)

				Else
					MsgBox(0, "No Bot found", "Couldn't find any Bot in the Directory, please check if you have the mybot.run.exe or the mybot.run.au3 in the Dir and if you selected the right Dir!")

				EndIf
				GUICtrlSetData($List_AS, "")
				UpdateList_AS()
				$FileAS1 = FileExists(@StartupDir & "\MyBot -" & $profileAS & ".lnk")
				If $FileAS1 = 0 Then
					GUICtrlSetState($ButtonA2, $GUI_DISABLE)

				Else
					GUICtrlSetState($ButtonA2, $GUI_ENABLE)
				EndIf
				$FileAS2 = FileExists(@StartupDir & "\MyBot -" & $profileAS & ".lnk")
				If $FileAS2 = 0 Then
					GUICtrlSetState($ButtonA1, $GUI_ENABLE)
				Else
					GUICtrlSetState($ButtonA1, $GUI_DISABLE)
				EndIf





			Case $ButtonA2
				$FileAS = FileExists(@StartupDir & "\MyBot -" & $profileAS & ".lnk")
				If $FileAS = 1 Then
					FileDelete(@StartupDir & "\MyBot -" & $profileAS & ".lnk")
					GUICtrlSetData($List_AS, "")
					UpdateList_AS()
					$FileAS1 = FileExists(@StartupDir & "\MyBot -" & $profileAS & ".lnk")
					If $FileAS1 = 0 Then
						GUICtrlSetState($ButtonA2, $GUI_DISABLE)
					Else
						GUICtrlSetState($ButtonA2, $GUI_ENABLE)
					EndIf
					$FileAS2 = FileExists(@StartupDir & "\MyBot -" & $profileAS & ".lnk")
					If $FileAS2 = 0 Then
						GUICtrlSetState($ButtonA1, $GUI_ENABLE)
					Else
						GUICtrlSetState($ButtonA1, $GUI_DISABLE)
					EndIf

				Else
					MsgBox(1, "No File found", "Sorry Chief, we couldn't find a File in the AutoStart Folder. Did you renamed it or didn't you even had one in there ?")
				EndIf


		EndSwitch

	WEnd
EndFunc   ;==>GUI_AutoStart

Func RunSetup() ;Starting Premade Setup
	$ClickedProfile = GUICtrlRead($List_Main)
	GUICtrlSetData($LabelLog, "Running:" & " " & $ClickedProfile)

	$Ipt1 = IniRead($ProfileDir, $ClickedProfile, "Profile", "")
	$String = StringRegExp($Ipt1, " ")
	If $String = 1 Then
		$Ipt1 = '"' & $Ipt1 & '"'
	EndIf
	$Ipt2 = IniRead($ProfileDir, $ClickedProfile, "Emulator", "")
	$Ipt3 = IniRead($ProfileDir, $ClickedProfile, "Instance", "")
	$Ipt4 = IniRead($ProfileDir, $ClickedProfile, "Dir", "")

	$File3 = FileExists($Ipt4 & "\" & $File)
	$File4 = FileExists($Ipt4 & "\" & $File1)
	If $File3 = 1 Then
		ShellExecute($File, $Ipt1 & " " & $Ipt2 & " " & $Ipt3, $Ipt4)
	ElseIf $File4 = 1 Then
		ShellExecute($File1, $Ipt1 & " " & $Ipt2 & " " & $Ipt3, $Ipt4)
	Else
		MsgBox(0, "No Bot found", "Couldn't find any Bot in the Directory, please check if you have the mybot.run.exe or the mybot.run.au3 in the Dir and if you selected the right Dir!")
		GUICtrlSetData($LabelLog, "Couldn't find runable Bot!")
	EndIf

EndFunc   ;==>RunSetup




Func UpdateList_Main() ; Main List Updating
	GUICtrlSetData($List_Main, "")
	Local $sections = IniReadSectionNames($ProfileDir)
	For $i = 1 To UBound($sections, 1) - 1
		GUICtrlSetData($List_Main, $sections[$i])
	Next
EndFunc   ;==>UpdateList_Main



Func UpdateList_AS() ; AutoStart List Updateing
	$Profiles = IniReadSectionNames($ProfileDir)
	For $i = 1 To $Profiles[0]
		If FileExists(@StartupDir & "\MyBot -" & $Profiles[$i] & ".lnk") Then
			GUICtrlSetData($List_AS, $Profiles[$i])
		EndIf
	Next

EndFunc   ;==>UpdateList_AS



Func CheckIfListEmpty()
	$ReadFile = FileRead($ProfileDir)
	If $ReadFile = "" Then
		GUICtrlSetState($ButtonAutoStart, $GUI_DISABLE)
		GUICtrlSetState($ButtonShortcut, $GUI_DISABLE)
	EndIf
EndFunc   ;==>CheckIfListEmpty





