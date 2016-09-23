#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icons\Elegantthemes-Beautiful-Flat-Compose.ico
#AutoIt3Wrapper_Outfile=SelectBot.Exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=For MyBot.run. Made by Fliegerfaust
#AutoIt3Wrapper_Res_Description=SelectBot for MyBot
#AutoIt3Wrapper_Res_Fileversion=3.6.2.0
#AutoIt3Wrapper_Res_LegalCopyright=Fliegerfaust
#AutoIt3Wrapper_Run_Tidy=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#RequireAdmin
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include <ListBoxConstants.au3>
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <TrayConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ComboConstants.au3>
#include <WinAPIFiles.au3>
#include <File.au3>
#include <Array.au3>
#include <ProcessConstants.au3>
#include <WinAPIProc.au3>
#include <WinAPISys.au3>
#include <GuiMenu.au3>
#include <InetConstants.au3>
#include <Misc.au3>
#include <WinAPI.au3>
#include <EditConstants.au3>
#include <ColorConstants.au3>

Global $sBotFile = "mybot.run.exe"
Global $sBotFileAU3 = "mybot.run.au3"
Global $iFlag = 0
Global $sVersion = "3.6.2"
Global $sProfiles = @MyDocumentsDir & "\Profiles.ini"
Global $sIniProfile, $sIniEmulator, $sIniInstance, $sIniDir
Global Enum $IdRun = 1000, $IdEdit, $IdDelete, $IdNickname

; Not sure if $Wow6432Node is really required for 64 Bit Machines but adding it doesn't hurt
If @OSArch = "X86" Then
	$Wow6432Node = ""
	$HKLM = "HKLM"
Else
	$Wow6432Node = "\Wow6432Node"
	$HKLM = "HKLM64"
EndIf

GUI_Main()

Func GUI_Main()

	Global $Gui_Main = GUICreate("Select", 258, 452, -1, -1)
	Global $Lstbx_Main = GUICtrlCreateList("", 8, 24, 241, 305, BitOR($LBS_SORT, $LBS_NOTIFY, $LBS_EXTENDEDSEL))
	$Lbl_Setups = GUICtrlCreateLabel("Your saved Setups:", 8, 4, 200, 17)
	Global $Lbl_Log = GUICtrlCreateLabel("Made by: Fliegerfaust", 8, 416, 244, 17)
	$Btn_Setup = GUICtrlCreateButton("New Setup", 8, 336, 107, 25, $WS_GROUP)
	Global $Btn_Shortcut = GUICtrlCreateButton("New Shortcut", 136, 336, 113, 25, $WS_GROUP)
	Global $Btn_AutoStart = GUICtrlCreateButton("Auto Start", 136, 368, 113, 25, $WS_GROUP)
	$Menu_Help = GUICtrlCreateMenu("&Help")
	$Menu_HelpMsg = GUICtrlCreateMenuItem("Help", $Menu_Help)
	$Menu_ForumTopic = GUICtrlCreateMenuItem("Forum Topic", $Menu_Help)
	$Menu_Documents = GUICtrlCreateMenuItem("Profile Directory", $Menu_Help)
	$Menu_Startup = GUICtrlCreateMenuItem("Startup Directory", $Menu_Help)
	$Menu_Emulators = GUICtrlCreateMenu("&Emulators")
	$Menu_BlueStacks1 = GUICtrlCreateMenuItem("BlueStacks", $Menu_Emulators)
	$Menu_BlueStacks2 = GUICtrlCreateMenuItem("BlueStacks2", $Menu_Emulators)
	$Menu_MEmu = GUICtrlCreateMenuItem("MEmu", $Menu_Emulators)
	$Menu_Droid4X = GUICtrlCreateMenuItem("Droid4X", $Menu_Emulators)
	$Menu_Nox = GUICtrlCreateMenuItem("Nox", $Menu_Emulators)
	$Menu_LeapDroid = GUICtrlCreateMenuItem("LeapDroid", $Menu_Emulators)
	$Menu_Update = GUICtrlCreateMenu("Updates")
	$Menu_CheckForUpdate = GUICtrlCreateMenuItem("Check for Updates", $Menu_Update)
	$Menu_Misc = GUICtrlCreateMenu("Misc")
	$Menu_Clear = GUICtrlCreateMenuItem("Clear Local Files", $Menu_Misc)
	GUISetState(@SW_SHOW)
	; GUI MAIN

	GUIRegisterMsg($WM_CONTEXTMENU, "WM_CONTEXTMENU")
	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

	Global $Context_Main = _GUICtrlMenu_CreatePopup()

	_GUICtrlMenu_InsertMenuItem($Context_Main, 0, "Run", $IdRun)
	_GUICtrlMenu_InsertMenuItem($Context_Main, 1, "Edit", $IdEdit)
	_GUICtrlMenu_InsertMenuItem($Context_Main, 2, "Delete", $IdDelete)
	_GUICtrlMenu_InsertMenuItem($Context_Main, 3, "Nickname", $IdNickname)
	;CONTEXT MENU OF MAIN GUI

	WelcomeMsg()
	UpdateList_Main()



	While 1




		$aMsg = GUIGetMsg(1)
		Switch $aMsg[1]

			Case $Gui_Main
				Switch $aMsg[0]
					Case $GUI_EVENT_CLOSE
						ExitLoop

					Case $GUI_EVENT_SECONDARYDOWN

						If GUICtrlRead($Lstbx_Main) Then
							$iFlag = 1
						EndIf

					Case $Menu_HelpMsg
						MsgBox($MB_OK, "Help", "To create a new Setup just press the New Setup Button and walk through the Guide!" & @CRLF & @CRLF & "To create a new Shortcut just press the New Shortcut Button and a Shortcut gets created on your Desktop!" & @CRLF & @CRLF & "Double Click an Item in the List to start the Bot with the highlighted Setup!" & @CRLF & @CRLF & "Right Click for a Context Menu." & @CRLF & @CRLF & "The Auto Updater will be downloaded and when you turn it off it will stay there but won't activate. When you delete this Tool make sure to Click on Misc and then Clear Local Files!", 0, $Gui_Main)
					Case $Menu_ForumTopic
						ShellExecute("https://mybot.run/forums/index.php?/topic/15860-how-to-run-multiple-botshow-to-bot-on-droid4x-and-memu-w-updated-tool/")

					Case $Menu_Documents
						ShellExecute(@MyDocumentsDir)

					Case $Menu_Startup
						ShellExecute(@StartupDir)

					Case $Menu_BlueStacks1
						ShellExecute("https://mega.nz/#!GFVilDAL!Wkyp2xpxFOx8J_Gz8wIf0jGSxTT3IiT6xthvrHhRbME")

					Case $Menu_BlueStacks2
						ShellExecute("https://mega.nz/#!BpdEUBbZ!4unxWMPzA5rESONTVgNrxlNxSj8H2wwicx4Q15PmBo4")

					Case $Menu_MEmu
						ShellExecute("http://www.memuplay.com/download.php?file_name=Memu-Setup&from=home_en")

					Case $Menu_Droid4X
						ShellExecute("http://dl.haima.me/download/DXDown/win/Z001/Droid4XInstaller.exe")

					Case $Menu_Nox
						ShellExecute("http://en.bignox.com/en/download/fullPackage")
					Case $Menu_LeapDroid
						ShellExecute("http://www.leapdroid.com/installer/current/LeapdroidVMInstallerFull.exe")

					Case $Menu_CheckForUpdate

						$sTempPath = _WinAPI_GetTempFileName(@TempDir)
						$hUpdateFile = InetGet("https://raw.githubusercontent.com/Fliegerfaust33/SelectBot/master/CheckUpdate.txt", $sTempPath, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)
						Do
							Sleep(250)
						Until InetGetInfo($hUpdateFile, $INET_DOWNLOADCOMPLETE)

						InetClose($hUpdateFile)
						$hGitVersion = FileRead($sTempPath)
						$sGitVersion = StringStripWS($hGitVersion, 8)
						$Update = _VersionCompare($sVersion, $hGitVersion)

						Select
							Case $Update = -1
								$msgUpdate = MsgBox($MB_YESNO, "Update", "New SelectBot Update found" & @CRLF & "New: " & $sGitVersion & @CRLF & "Old: " & $sVersion & @CRLF & "Do you want to download it?", 0, $Gui_Main)
								If $msgUpdate = $IDYES Then
									UpdateSelect()
								EndIf
							Case $Update = 0
								MsgBox($MB_OK, "Update", "No new Update found (" & $sVersion & ")")
							Case $Update = 1
								MsgBox($MB_OK, "Update", "You are using a future Version (" & $sVersion & ")")
						EndSelect

						FileDelete($sTempPath)

					Case $Menu_Clear
						$hMsgDelete = MsgBox($MB_YESNO, "Delete Local Files", "This will delete all SelectBot Files (Profiles, Config and Auto Update) Do you want to proceed?", 0, $Gui_Main)
						If $hMsgDelete = 6 Then
							FileDelete(@StartupDir & "\SelectBotAutoUpdate.exe")
							FileDelete($sProfiles)
							UpdateList_Main()
							MsgBox($MB_OK, "Delete Local Files", "Deleted all Files from your Computer!", 0, $Gui_Main)

						EndIf




					Case $Btn_Setup

						GUICtrlSetData($Lbl_Log, "Profile Creation started!")
						Do
							WinSetOnTop($Gui_Main, "", $WINDOWS_ONTOP)
							GUISetState(@SW_DISABLE, $Gui_Main)
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
							WinSetOnTop($Gui_Main, "", $WINDOWS_NOONTOP)

						Until 1

						GUISetState(@SW_ENABLE, $Gui_Main)
						UpdateList_Main()

					Case $Btn_AutoStart

						GUI_AutoStart()
						GUISetState(@SW_ENABLE, $Gui_Main)

					Case $Btn_Shortcut

						$sSelectedProfile = _GUICtrlListBox_GetSelItemsText($Lstbx_Main)
						For $i = 1 To $sSelectedProfile[0]
							ReadIni($sSelectedProfile[$i])
							If FileExists($sIniDir & "\" & $sBotFile) = 1 Then
								FileCreateShortcut($sIniDir & "\" & $sBotFile, @DesktopDir & "\MyBot -" & $sIniProfile & ".lnk", $sIniDir, $sIniProfile & " " & $sIniEmulator & " " & $sIniInstance, "Shortcut for Bot Profile:" & $sIniProfile)
							ElseIf FileExists($sIniDir & "\" & $sBotFileAU3) = 1 Then
								FileCreateShortcut($sIniDir & "\" & $sBotFileAU3, @DesktopDir & "\MyBot -" & $sIniProfile & ".lnk", $sIniDir, $sIniProfile & " " & $sIniEmulator & " " & $sIniInstance, "Shortcut for Bot Profile:" & $sIniProfile)
							Else
								MsgBox($MB_OK, "No Bot found", "Couldn't find any Bot in the Directory, please check if you have the mybot.run.exe or the mybot.run.au3 in the Dir and if you selected the right Dir!", 0, $Gui_Main)
							EndIf

						Next

					Case $Lstbx_Main

						$iLstbx_GetSel = _GUICtrlListBox_GetSelCount($Lstbx_Main)

						If $iLstbx_GetSel > 1 Then
							_GUICtrlMenu_SetItemDisabled($Context_Main, 1)
							_GUICtrlMenu_SetItemDisabled($Context_Main, 3)
						ElseIf $iLstbx_GetSel < 2 Then
							_GUICtrlMenu_SetItemEnabled($Context_Main, 1)
							_GUICtrlMenu_SetItemEnabled($Context_Main, 3)
						EndIf

				EndSwitch

		EndSwitch

	WEnd
EndFunc   ;==>GUI_Main



Func GUI_Profile()
	Global $aGuiPos_Main = WinGetPos($Gui_Main, "")
	Global $Gui_Profile = GUICreate("Profile", 255, 167, $aGuiPos_Main[0], $aGuiPos_Main[1] + 150, -1, -1, $Gui_Main)
	$Ipt_Profile = GUICtrlCreateInput("", 24, 72, 201, 21)
	$Btn_Next = GUICtrlCreateButton("Next step", 72, 120, 97, 25, $WS_GROUP)
	GUICtrlSetState($Btn_Next, $GUI_DISABLE)
	$Lbl_Info = GUICtrlCreateLabel("Please type in the full Name of your Profile to continue", 24, 8, 204, 57)
	GUISetState()

	Local $BtnEnabled = False


	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				Global $sTypedProfile = GUICtrlRead($Ipt_Profile)
				IniDelete($sProfiles, $sTypedProfile)
				GUICtrlSetData($Lbl_Log, "Profile Selection cancelled!")
				GUIDelete($Gui_Profile)
				Return -1
			Case $Btn_Next
				Global $sTypedProfile = GUICtrlRead($Ipt_Profile)
				GUICtrlSetData($Lbl_Log, "Profile:" & " " & $sTypedProfile)
				IniWrite($sProfiles, $sTypedProfile, "Profile", $sTypedProfile)
				GUIDelete($Gui_Profile)
				Return 0
		EndSwitch

		If $BtnEnabled Then ContinueLoop
		If GUICtrlRead($Ipt_Profile) Then
			ContinueLoop
		Else
			GUICtrlSetState($Btn_Next, $GUI_ENABLE)
			$BtnEnabled = True
		EndIf
	WEnd
EndFunc   ;==>GUI_Profile



Func GUI_Emulator()
	Global $Gui_Emulator = GUICreate("Emulator", 258, 167, $aGuiPos_Main[0], $aGuiPos_Main[1] + 150, -1, -1, $Gui_Main)
	$Cmb_Emulator = GUICtrlCreateCombo("BlueStacks", 24, 72, 201, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData($Cmb_Emulator, "BlueStacks2|MEmu|Droid4X|Nox|LeapDroid")
	$Btn_Next = GUICtrlCreateButton("Next step", 72, 120, 97, 25, $WS_GROUP)
	$Lbl_Info = GUICtrlCreateLabel("Please select your Emulator", 24, 8, 204, 57)
	GUISetState()



	While 1

		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				IniDelete($sProfiles, $sTypedProfile)
				GUICtrlSetData($Lbl_Log, "Profile Creation cancelled.")
				GUIDelete($Gui_Emulator)
				Return -1
			Case $Btn_Next
				Global $sSelectedEmulator = GUICtrlRead($Cmb_Emulator)
				If EmuInstalled() = True Then
					GUICtrlSetData($Lbl_Log, "Emulator:" & " " & $sSelectedEmulator)
					IniWrite($sProfiles, $sTypedProfile, "Emulator", $sSelectedEmulator)
					GUIDelete($Gui_Emulator)
					Return 0

				ElseIf EmuInstalled() = False Then
					$msgEmulator = MsgBox($MB_YESNO, "Error", "Sorry Chief!" & @CRLF & "Couldn't find " & $sSelectedEmulator & " installed on your Computer. Did you chose the wrong Emulator ? If you are sure you got it installed please click 'Yes'" & @CRLF & @CRLF & "Do you want to continue?", 0, $Gui_Emulator)
					If $msgEmulator = $IDYes Then
						GUICtrlSetData($Lbl_Log, "Emulator:" & " " & $sSelectedEmulator)
						IniWrite($sProfiles, $sTypedProfile, "Emulator", $sSelectedEmulator)
						GUIDelete($Gui_Emulator)
						Return 0
					EndIf
				EndIf

		EndSwitch
	WEnd
EndFunc   ;==>GUI_Emulator



Func GUI_Instance()
	Global $Gui_Instance = GUICreate("Instance", 258, 167, $aGuiPos_Main[0], $aGuiPos_Main[1] + 150, -1, -1, $Gui_Main)
	Local $Ipt_Instance = GUICtrlCreateInput("", 24, 72, 201, 21)
	$Btn_Next = GUICtrlCreateButton("Next step", 72, 120, 97, 25, $WS_GROUP)
	Global $Lbl_Info = GUICtrlCreateLabel("Please write the Instance Name you want to link", 24, 8, 204, 57)
	GUISetState(@SW_HIDE, $Gui_Instance)

	Local $iBluestacks = 0


	If $sSelectedEmulator = "BlueStacks" Or $sSelectedEmulator = "BlueStacks2" Then
		$iBluestacks = 1
	ElseIf $sSelectedEmulator = "MEmu" Then
		GUISetState(@SW_SHOW, $Gui_Instance)
		GUICtrlSetData($Lbl_Info, "Please type in your MEmu Instance Name! Example: MEmu , MEmu_1, MEmu_2, etc")
		GUICtrlSetData($Ipt_Instance, "MEmu_")
	ElseIf $sSelectedEmulator = "Droid4x" Then
		GUISetState(@SW_SHOW, $Gui_Instance)
		GUICtrlSetData($Lbl_Info, "Please type in your Droid4x Instance Name! Example: droid4x , droid4x_1, droid4x_2, etc")
		GUICtrlSetData($Ipt_Instance, "droid4x_")
	ElseIf $sSelectedEmulator = "Nox" Then
		GUISetState(@SW_SHOW, $Gui_Instance)
		GUICtrlSetData($Lbl_Info, "Please type in your Nox Instance Name! Example: nox , nox_1, nox_2, etc")
		GUICtrlSetData($Ipt_Instance, "nox_")
	Else
		GUISetState(@SW_SHOW, $Gui_Instance)
		GUICtrlSetData($Lbl_Info, "Please type in your LeapDroid Instance Name! Example: vm1 , vm2, etc")
		GUICtrlSetData($Ipt_Instance, "vm")
	EndIf



	While 1

		If $iBluestacks = 1 Then
			ExitLoop

		EndIf


		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUIDelete($Gui_Instance)
				IniDelete($sProfiles, $sTypedProfile)
				GUICtrlSetData($Lbl_Log, "Profile Creation cancelled.")
				Return -1
			Case $Btn_Next
				$Inst = GUICtrlRead($Ipt_Instance)
				$Instances = LaunchConsole(InstanceMgr(), "list vms", 1000)
				If $sSelectedEmulator <> "LeapDroid" Then
					$Instance = StringRegExp($Instances, "(?i)" & $sSelectedEmulator & "(?:[_][0-9])?", 3)
				ElseIf $sSelectedEmulator = "LeapDroid" Then
					$Instance = StringRegExp($Instances, "(?i)vm\d?", 3)
				EndIf

				If _ArraySearch($Instance, $Inst) = -1 And $Instance = 1 Then
					MsgBox($MB_OK, "Error", "Couldn't find any Instances for " & $sSelectedEmulator & "." & " There are only two reasons why." & @CRLF & "#1: You deleted all Instances" & @CRLF & "#2: You don't have the Emulator installed and still pressed YES on the Pop Up before :(", 0, $Gui_Instance)
					GUIDelete($Gui_Instance)
					IniDelete($sProfiles, $sTypedProfile)
					GUICtrlSetData($Lbl_Log, "Profile Creation cancelled.")
					Return -1

				ElseIf _ArraySearch($Instance, $Inst) = -1 Then
					$Msg2 = MsgBox($MB_OK, "Typo ?", "Couldn't find the Instance Name you typed in. Please check your Instances once again and retype it." & @CRLF & "Here is a list of Instances I could find on your PC:" & @CRLF & @CRLF & _ArrayToString($Instance, @CRLF) & @CRLF & @CRLF & 'If you are sure that you got the Instance right but this Message keeps coming then press "Yes" to continue!' & @CRLF & @CRLF & "Do you want to continue?", 0, $Gui_Instance)
					If $Msg2 = $IDYES Then
						GUICtrlSetData($Lbl_Log, "Instance:" & " " & $Inst)
						IniWrite($sProfiles, $sTypedProfile, "Instance", $Inst)
						GUIDelete($Gui_Instance)
						Return 0
					EndIf
				Else
					GUICtrlSetData($Lbl_Log, "Instance:" & " " & $Inst)
					IniWrite($sProfiles, $sTypedProfile, "Instance", $Inst)
					GUIDelete($Gui_Instance)
					Return 0
				EndIf

		EndSwitch
	WEnd
EndFunc   ;==>GUI_Instance

Func GUI_DIR()
	Global $Gui_Dir = GUICreate("Directory", 258, 167, $aGuiPos_Main[0], $aGuiPos_Main[1] + 150, -1, -1, $Gui_Main)
	$Btn_Folder = GUICtrlCreateButton("Choose Folder", 24, 72, 201, 21)
	$Btn_Finish = GUICtrlCreateButton("Finish", 72, 120, 97, 25, $WS_GROUP)
	GUICtrlSetState($Btn_Finish, $GUI_DISABLE)
	$Lbl_Info = GUICtrlCreateLabel("Please select the MyBot Folder where the mybot.run.exe or .au3 is located at", 24, 8, 204, 57)
	GUISetState()



	While 1

		Switch GUIGetMsg()


			Case $GUI_EVENT_CLOSE
				IniDelete($sProfiles, $sTypedProfile)
				GUICtrlSetData($Lbl_Log, "Profile Creation cancelled")
				GUIDelete($Gui_Dir)
				ExitLoop

			Case $Btn_Folder
				WinSetOnTop($Gui_Main, "", $WINDOWS_NOONTOP)
				Local $sFileSelectFolder = FileSelectFolder("Select your MyBot Folder", "")
				If @error Then
					GUICtrlSetData($Lbl_Log, "File Selection aborted.")
				Else
					GUICtrlSetData($Lbl_Log, $sFileSelectFolder)
				EndIf
				WinSetOnTop($Gui_Main, "", $WINDOWS_ONTOP)


				If $sFileSelectFolder = "" Then
					ContinueLoop
				ElseIf FileExists($sFileSelectFolder & "\" & $sBotFile) And FileExists($sFileSelectFolder & "\" & $sBotFileAU3) = 0 Then
					MsgBox($MB_OK, "Error", "Looks like there is no runable mybot file in the Folder? Did you select the right folder or is in the Folder the mybot.run.exe or mybot.run.au3 renamed? Please select another Folder or rename Files!", 0, $Gui_Dir)
					GUICtrlSetData($Lbl_Log, "No Runable File found in the Dir")
					ContinueLoop
				Else
					GUICtrlSetState($Btn_Finish, $GUI_ENABLE)
				EndIf

			Case $Btn_Finish

				IniWrite($sProfiles, $sTypedProfile, "Dir", $sFileSelectFolder)
				GUICtrlSetData($Lbl_Log, "Profile got created successfully!")
				GUIDelete($Gui_Dir)
				ExitLoop


		EndSwitch
	WEnd




EndFunc   ;==>GUI_DIR



Func GUI_Edit()

	$aLstbx_GetSelTxt = _GUICtrlListBox_GetSelItemsText($Lstbx_Main)
	ReadIni($aLstbx_GetSelTxt[1])
	$sFolder = $sIniDir
	$aGuiPos_Main = WinGetPos($Gui_Main, "")
	$Gui_Edit = GUICreate("Edit INI", 258, 187, $aGuiPos_Main[0], $aGuiPos_Main[1] + 150, -1, -1, $Gui_Main)
	$Ipt_Profile = GUICtrlCreateInput($sIniProfile, 112, 8, 137, 21)
	$Cmb_Emulator = GUICtrlCreateCombo($sIniEmulator, 112, 40, 137, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	$Ipt_Instance = GUICtrlCreateInput($sIniInstance, 112, 72, 137, 21)
	$Btn_Folder = GUICtrlCreateButton("Open Dialog", 112, 105, 137, 23, $WS_GROUP)
	$Lbl_Profile = GUICtrlCreateLabel("Profile Name:", 8, 8, 95, 17)
	$Lbl_Emulator = GUICtrlCreateLabel("Emulator:", 8, 40, 95, 17)
	$Lbl_Instance = GUICtrlCreateLabel("Instance:", 8, 72, 95, 17)
	$Lbl_Dir = GUICtrlCreateLabel("Directory:", 8, 104, 95, 17)
	$Btn_Save = GUICtrlCreateButton("Save and Close", 76, 150, 97, 25, $WS_GROUP)
	GUISetState()



	Select
		Case $sIniEmulator = "BlueStacks"
			GUICtrlSetData($Cmb_Emulator, "BlueStacks2|MEmu|Droid4X|Nox|LeapDroid")
			GUICtrlSetState($Ipt_Instance, $GUI_DISABLE)
		Case $sIniEmulator = "BlueStacks2"
			GUICtrlSetData($Cmb_Emulator, "BlueStacks|MEmu|Droid4X|Nox|LeapDroid")
			GUICtrlSetState($Ipt_Instance, $GUI_DISABLE)
		Case $sIniEmulator = "MEmu"
			GUICtrlSetData($Cmb_Emulator, "BlueStacks|BlueStacks2|Droid4X|Nox|LeapDroid")
		Case $sIniEmulator = "Droid4X"
			GUICtrlSetData($Cmb_Emulator, "BlueStacks|BlueStacks2|MEmu|Nox|LeapDroid")
		Case $sIniEmulator = "Nox"
			GUICtrlSetData($Cmb_Emulator, "BlueStacks|BlueStacks2|MEmu|Droid4X|LeapDroid")
		Case $sIniEmulator = "LeapDroid"
			GUICtrlSetData($Cmb_Emulator, "BlueStacks|BlueStacks2|MEmu|Droid4X|Nox")
		Case Else
			MsgBox($MB_OK, "Error", "Oops, as it looks like you changed Data in the Config File.Pleae delete all corrupted Sections!", 0, $Gui_Edit)
	EndSelect



	While 1

		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUICtrlSetData($Lbl_Log, "Editing cancelled")
				GUIDelete($Gui_Edit)
				ExitLoop

			Case $Cmb_Emulator
				$sSelectedEmulator = GUICtrlRead($Cmb_Emulator)
				If $sSelectedEmulator = "BlueStacks" Or $sSelectedEmulator = "BlueStacks2" Then
					GUICtrlSetState($Ipt_Instance, $GUI_DISABLE)
					GUICtrlSetData($Ipt_Instance, "")
				ElseIf $sSelectedEmulator <> "BlueStacks" And "BlueStacks2" Then
					GUICtrlSetState($Ipt_Instance, $GUI_ENABLE)
					Select
						Case $sSelectedEmulator = "MEmu"
							GUICtrlSetData($Ipt_Instance, "MEmu_")
						Case $sSelectedEmulator = "Droid4X"
							GUICtrlSetData($Ipt_Instance, "droid4x_")
						Case $sSelectedEmulator = "Nox"
							GUICtrlSetData($Ipt_Instance, "Nox_")
						Case $sSelectedEmulator = "LeapDroid"
							GUICtrlSetData($Ipt_Instance, "vm")
						Case Else
							MsgBox($MB_OK, "Error", "Oops, as it looks like you changed Data in the Config File. Please revert it or delete all corrupted Sections!", 0, $Gui_Edit)
					EndSelect
				EndIf


			Case $Btn_Folder
				Local $sSelectedFolder = FileSelectFolder("Select your MyBot Folder", $sIniDir)

			Case $Btn_Save

				$sSelectedProfile = GUICtrlRead($Ipt_Profile)
				$sSelectedEmulator = GUICtrlRead($Cmb_Emulator)
				$sSelectedInstance = GUICtrlRead($Ipt_Instance)
				IniDelete(@MyDocumentsDir & "\Profiles.ini", $aLstbx_GetSelTxt[1])
				IniWrite($sProfiles, $aLstbx_GetSelTxt[1], "Profile", $sSelectedProfile)
				IniWrite($sProfiles, $aLstbx_GetSelTxt[1], "Emulator", $sSelectedEmulator)
				IniWrite($sProfiles, $aLstbx_GetSelTxt[1], "Instance", $sSelectedInstance)
				IniWrite($sProfiles, $aLstbx_GetSelTxt[1], "Dir", $sSelectedFolder)
				GUIDelete($Gui_Edit)
				ExitLoop

		EndSwitch

	WEnd
EndFunc   ;==>GUI_Edit


Func GUI_AutoStart()

	$aGuiPos_Main = WinGetPos($Gui_Main, "")
	$Gui_AutoStart = GUICreate("Auto Start Setup", 258, 187, $aGuiPos_Main[0], $aGuiPos_Main[1] + 150, -1, -1, $Gui_Main)
	Global $Lst_AutoStart = GUICtrlCreateList("", 8, 48, 241, 84, BitOR($LBS_SORT, $LBS_NOTIFY, $LBS_NOSEL))
	$Lbl_Info = GUICtrlCreateLabel("Add or Remove a Profile from Autostart" & @CRLF & "These are currently in the Folder:", 8, 8, 220, 34)
	$Btn_Add = GUICtrlCreateButton("Add", 8, 144, 97, 25, $WS_GROUP)
	Local $Btn_Remove = GUICtrlCreateButton("Remove", 152, 144, 97, 25, $WS_GROUP)
	GUISetState()

	$sText = ""


	$aLstbx_GetSelTxt = _GUICtrlListBox_GetSelItemsText($Lstbx_Main)
	$iLstbx_GetSel = _GUICtrlListBox_GetSelCount($Lstbx_Main)
	For $i = 1 To $aLstbx_GetSelTxt[0]
		ReadIni($aLstbx_GetSelTxt[$i])
		If FileExists(@StartupDir & "\MyBot -" & $sIniProfile & ".lnk") = 0 Then
			GUICtrlSetState($Btn_Add, $GUI_ENABLE)
			GUICtrlSetState($Btn_Remove, $GUI_DISABLE)
		Else
			GUICtrlSetState($Btn_Add, $GUI_DISABLE)
			GUICtrlSetState($Btn_Remove, $GUI_ENABLE)
		EndIf
	Next


	UpdateList_AS()

	While 1

		Switch GUIGetMsg()

			Case $GUI_EVENT_CLOSE
				GUICtrlSetData($Lbl_Log, "Auto Start Setup stopped")
				GUIDelete($Gui_AutoStart)
				ExitLoop

			Case $Btn_Add

				For $i = 1 To $aLstbx_GetSelTxt[0]
					ReadIni($aLstbx_GetSelTxt[$i])
					If FileExists($sIniDir & "\" & $sBotFile) = 1 Then
						$sBotFile = $sBotFile
					ElseIf FileExists($sIniDir & "\" & $sBotFileAU3) = 1 Then
						$sBotFile = $sBotFileAU3
					EndIf

					FileCreateShortcut($sIniDir & "\" & $sBotFile, @StartupDir & "\MyBot -" & $sIniProfile & ".lnk", $sIniDir, $sIniProfile & " " & $sIniEmulator & " " & $sIniInstance, "Shortcut for Bot Profile:" & $sIniProfile)

					UpdateList_AS()
					If FileExists(@StartupDir & "\MyBot -" & $sIniProfile & ".lnk") = 0 Then
						GUICtrlSetState($Btn_Remove, $GUI_DISABLE)
						GUICtrlSetState($Btn_Add, $GUI_ENABLE)
					Else
						GUICtrlSetState($Btn_Remove, $GUI_ENABLE)
						GUICtrlSetState($Btn_Add, $GUI_DISABLE)
					EndIf
				Next



			Case $Btn_Remove

				For $i = 1 To $aLstbx_GetSelTxt[0]
					ReadIni($aLstbx_GetSelTxt[$i])
					If FileExists(@StartupDir & "\MyBot -" & $sIniProfile & ".lnk") = 1 Then
						FileDelete(@StartupDir & "\MyBot -" & $sIniProfile & ".lnk")
						GUICtrlSetData($Lst_AutoStart, "")

					EndIf

					UpdateList_AS()
					If FileExists(@StartupDir & "\MyBot -" & $sIniProfile & ".lnk") = 0 Then
						GUICtrlSetState($Btn_Remove, $GUI_DISABLE)
						GUICtrlSetState($Btn_Add, $GUI_ENABLE)
					Else
						GUICtrlSetState($Btn_Remove, $GUI_ENABLE)
						GUICtrlSetState($Btn_Add, $GUI_DISABLE)
					EndIf

				Next


		EndSwitch

	WEnd
EndFunc   ;==>GUI_AutoStart



Func RunSetup()
	$aLstbx_GetSelTxt = _GUICtrlListBox_GetSelItemsText($Lstbx_Main)
	For $i = 1 To $aLstbx_GetSelTxt[0]
		ReadIni($aLstbx_GetSelTxt[$i])
		If FileExists($sIniDir & "\" & $sBotFile) = 1 Then
			ShellExecute($sBotFile, $sIniProfile & " " & $sIniEmulator & " " & $sIniInstance, $sIniDir)
		ElseIf FileExists($sIniDir & "\" & $sBotFileAU3) = 1 Then
			ShellExecute($sBotFileAU3, $sIniProfile & " " & $sIniEmulator & " " & $sIniInstance, $sIniDir)
		Else
			MsgBox($MB_OK, "No Bot found", "Couldn't find any Bot in the Directory, please check if you have the mybot.run.exe or the mybot.run.au3 in the Dir and if you selected the right Dir!", 0, $Gui_Main)
			GUICtrlSetData($Lbl_Log, "Couldn't find runable Bot!")
		EndIf
	Next
EndFunc   ;==>RunSetup




Func UpdateList_Main() ; Main List Updating
	_GUICtrlListBox_BeginUpdate($Lstbx_Main)
	_GUICtrlListBox_ResetContent($Lstbx_Main)
	Local $sections = IniReadSectionNames($sProfiles)
	For $i = 1 To UBound($sections, 1) - 1
		_GUICtrlListBox_AddString($Lstbx_Main, $sections[$i])
	Next

	$iLstBx_Items = _GUICtrlListBox_GetCount($Lstbx_Main)
	If $iLstBx_Items = -1 Then
		GUICtrlSetState($Btn_Shortcut, $GUI_DISABLE)
		GUICtrlSetState($Btn_AutoStart, $GUI_DISABLE)
	ElseIf $iLstBx_Items <> -1 Then
		GUICtrlSetState($Btn_Shortcut, $GUI_ENABLE)
		GUICtrlSetState($Btn_AutoStart, $GUI_ENABLE)
	EndIf

	$RemoveSettings = _GUICtrlListBox_FindString($Lstbx_Main, "Settings")
	_GUICtrlListBox_DeleteString($Lstbx_Main, $RemoveSettings)
	_GUICtrlListBox_EndUpdate($Lstbx_Main)
	_GUICtrlListBox_ClickItem($Lstbx_Main, 0)
EndFunc   ;==>UpdateList_Main



Func UpdateList_AS()
	GUICtrlSetData($Lst_AutoStart, "")
	$aProfiles = IniReadSectionNames($sProfiles)
	For $i = 1 To $aProfiles[0]
		$sProfiles2 = IniRead($sProfiles, $aProfiles[$i], "Profile", "")
		If FileExists(@StartupDir & "\MyBot -" & $sProfiles2 & ".lnk") Then
			GUICtrlSetData($Lst_AutoStart, $sProfiles2)
		EndIf
	Next

EndFunc   ;==>UpdateList_AS



Func CheckIfListEmpty()

	$iLstBx_Items = _GUICtrlListBox_GetCount($Lstbx_Main)
	If $iLstBx_Items = -1 Then
		GUICtrlSetState($Btn_Shortcut, $GUI_DISABLE)
		GUICtrlSetState($Btn_AutoStart, $GUI_DISABLE)
	ElseIf $iLstBx_Items <> -1 Then
		GUICtrlSetState($Btn_Shortcut, $GUI_ENABLE)
		GUICtrlSetState($Btn_AutoStart, $GUI_ENABLE)
	EndIf

EndFunc   ;==>CheckIfListEmpty



Func ReadIni($sSelectedProfile)

	$sIniProfile = IniRead($sProfiles, $sSelectedProfile, "Profile", "")
	If StringRegExp($sIniProfile, " ") = 1 Then
		$sIniProfile = '"' & $sIniProfile & '"'
	EndIf
	$sIniEmulator = IniRead($sProfiles, $sSelectedProfile, "Emulator", "")
	$sIniInstance = IniRead($sProfiles, $sSelectedProfile, "Instance", "")
	$sIniDir = IniRead($sProfiles, $sSelectedProfile, "Dir", "")

EndFunc   ;==>ReadIni



Func WM_CONTEXTMENU($hWnd, $Msg, $wParam, $lParam)
	Local $tPoint = _WinAPI_GetMousePos(True, GUICtrlGetHandle($Lstbx_Main))
	Local $iY = DllStructGetData($tPoint, "Y")

	$lst2 = _GUICtrlListBox_GetCount($Lstbx_Main)
	If $lst2 > 0 Then
		For $i = 0 To 50
			Local $aRect = _GUICtrlListBox_GetItemRect($Lstbx_Main, $i)
			If ($iY >= $aRect[1]) And ($iY <= $aRect[3]) Then _ContextMenu($i)
		Next
		Return $GUI_RUNDEFMSG

	Else
		If $iFlag Then Return 0
		Return $GUI_RUNDEFMSG
	EndIf
EndFunc   ;==>WM_CONTEXTMENU



Func _ContextMenu($sItem)
	Switch _GUICtrlMenu_TrackPopupMenu($Context_Main, GUICtrlGetHandle($Lstbx_Main), -1, -1, 1, 1, 2)
		Case $IdRun
			RunSetup()

		Case $IdEdit

			GUISetState(@SW_DISABLE, $Gui_Main)
			GUICtrlSetData($Lbl_Log, "Starting to edit Profile")
			GUI_Edit()
			GUICtrlSetData($Lbl_Log, "Editing Profile done")
			GUISetState(@SW_ENABLE, $Gui_Main)

		Case $IdDelete

			$sLstbx_GetSelTxt = _GUICtrlListBox_GetSelItemsText($Lstbx_Main)
			$sLstbx_GetSel = _GUICtrlListBox_GetSelCount($Lstbx_Main)
			For $i = 1 To $sLstbx_GetSelTxt[0]
				IniDelete(@MyDocumentsDir & "\Profiles.ini", $sLstbx_GetSelTxt[$i])
				If FileExists(@StartupDir & "\MyBot -" & $sLstbx_GetSelTxt[$i] & ".lnk") = 1 Then FileDelete(@StartupDir & "\MyBot -" & $sLstbx_GetSelTxt[$i] & ".lnk")
			Next

			GUICtrlSetData($Lbl_Log, "Deleted" & " " & $sLstbx_GetSel & " Profiles")
			UpdateList_Main()

		Case $IdNickname

			$sLstbx_GetSelTxt = _GUICtrlListBox_GetSelItemsText($Lstbx_Main)
			ReadIni($sLstbx_GetSelTxt[1])
			$sIptbx = InputBox("Give Profile a Nickname", "Here you can set a NickName for each Setup. It will be shown in Brackets behind the Profile Name! To Remove a Nick just press OK when nothing is in the Input!", "", "", -1, -1, Default, Default, 0, $Gui_Main)
			If $sIptbx = "" Then
				IniRenameSection($sProfiles, $sLstbx_GetSelTxt[1], $sIniProfile)
			Else
				IniRenameSection($sProfiles, $sLstbx_GetSelTxt[1], $sIniProfile & " ( " & $sIptbx & " )")
			EndIf
			UpdateList_Main()

	EndSwitch
EndFunc   ;==>_ContextMenu


Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)


	#forceref $hWnd, $iMsg
	Local $hWndFrom, $iIDFrom, $iCode, $hWndListBox
	If Not IsHWnd($Lstbx_Main) Then $hWndListBox = GUICtrlGetHandle($Lstbx_Main)
	$hWndFrom = $lParam
	$iIDFrom = BitAND($wParam, 0xFFFF)
	$iCode = BitShift($wParam, 16)

	Switch $hWndFrom
		Case $Lstbx_Main, $hWndListBox
			Switch $iCode
				Case $LBN_DBLCLK
					RunSetup()

			EndSwitch
	EndSwitch

	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND


Func UpdateSelect()

	$hUpdateFile = InetGet("https://github.com/Fliegerfaust33/SelectBot/raw/master/SelectBot.Exe", @DesktopDir & "\SelectBot.exe", $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)
	Do
		Sleep(250)
	Until InetGetInfo($hUpdateFile, $INET_DOWNLOADCOMPLETE)

	InetClose($hUpdateFile)
	MsgBox($MB_OK, "Update", "Update finished! Downloaded newer Version and placed it on your Desktop!. After you pressed OK this Open Window will close itself and also will open the new Tool!", 0, $Gui_Main)
	ShellExecute(@DesktopDir & "\SelectBot.exe")
	FileDelete(@ScriptDir)
	Exit



EndFunc   ;==>UpdateSelect

Func WelcomeMsg()
	$sTempPath2 = @MyDocumentsDir & "\WelcomeMsg.txt"
	$hUpdateFile = InetGet("https://raw.githubusercontent.com/Fliegerfaust33/SelectBot/master/WelcomeMsg.txt", $sTempPath2, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)
	Do
		Sleep(250)
	Until InetGetInfo($hUpdateFile, $INET_DOWNLOADCOMPLETE)

	InetClose($hUpdateFile)
	If IniRead($sTempPath2, "General", "DisplayMsg", "") = 1 Then
		$sDisplayMsg = IniRead($sTempPath2, "General", "Msg", "")
		If $sDisplayMsg <> "" Then
			$sDisplayMsg2 = StringRegExpReplace($sDisplayMsg, "%", @CRLF)
			TrayTip("SelectBot", $sDisplayMsg2, 40, $TIP_ICONASTERISK)
		EndIf
	EndIf

	FileDelete($sTempPath2)


EndFunc   ;==>WelcomeMsg










Func GetLeapDroidPath()
	Local $LeapDroid_Path = RegRead($HKLM & "\SOFTWARE\Leapdroid\Leapdroid VM\", "InstallDir")
	If $LeapDroid_Path <> "" And FileExists($LeapDroid_Path & "\LeapdroidVM.exe") = 0 Then
		$LeapDroid_Path = ""
	EndIf
	; pre 1.5.0
	Local $InstallLocation = RegRead($HKLM & "\SOFTWARE" & $Wow6432Node & "\Microsoft\Windows\CurrentVersion\Uninstall\LeapdroidVM\", "InstallLocation")
	If $LeapDroid_Path = "" And FileExists($InstallLocation & "\leapdroidvm.ini") = 1 Then
		$LeapDroid_Path = IniRead($InstallLocation & "\leapdroidvm.ini", "main", "install_path", "")
		If FileExists($LeapDroid_Path & "\LeapdroidVM.exe") = 0 Then
			$LeapDroid_Path = ""
		EndIf
	EndIf
	If $LeapDroid_Path = "" And FileExists($InstallLocation & "\LeapdroidVM.exe") = 1 Then
		$LeapDroid_Path = $InstallLocation
	EndIf
	If $LeapDroid_Path = "" And FileExists(@ProgramFilesDir & "\Leapdroid\VM\LeapdroidVM.exe") = 1 Then
		$LeapDroid_Path = @ProgramFilesDir & "\Leapdroid\VM"
	EndIf
	If $LeapDroid_Path <> "" And StringRight($LeapDroid_Path, 1) <> "\" Then $LeapDroid_Path &= "\"
	Return $LeapDroid_Path
EndFunc   ;==>GetLeapDroidPath

Func GetMEmuPath()
	Local $MEmu_Path = EnvGet("MEmu_Path") & "\MEmu\"
	If FileExists($MEmu_Path & "MEmu.exe") = 0 Then
		Local $InstallLocation = RegRead($HKLM & "\SOFTWARE" & $Wow6432Node & "\Microsoft\Windows\CurrentVersion\Uninstall\MEmu\", "InstallLocation")
		If @error = 0 And FileExists($InstallLocation & "\MEmu\MEmu.exe") = 1 Then
			$MEmu_Path = $InstallLocation & "\MEmu\"
		Else
			Local $DisplayIcon = RegRead($HKLM & "\SOFTWARE" & $Wow6432Node & "\Microsoft\Windows\CurrentVersion\Uninstall\MEmu\", "DisplayIcon")
			If @error = 0 Then
				Local $iLastBS = StringInStr($DisplayIcon, "\", 0, -1)
				$MEmu_Path = StringLeft($DisplayIcon, $iLastBS)
				If StringLeft($MEmu_Path, 1) = """" Then $MEmu_Path = StringMid($MEmu_Path, 2)
			Else
				$MEmu_Path = @ProgramFilesDir & "\Microvirt\MEmu\"
			EndIf
		EndIf
	EndIf
	Return $MEmu_Path
EndFunc   ;==>GetMEmuPath

Func GetNoxPath()
	Local $path = RegRead($HKLM & "\SOFTWARE" & $Wow6432Node & "\DuoDianOnline\SetupInfo\", "InstallPath")
	If @error = 0 Then
		If StringRight($path, 1) <> "\" Then $path &= "\"
		$path &= "bin\"
	Else
		$path = ""
	EndIf
	Return $path
EndFunc   ;==>GetNoxPath

Func GetNoxRtPath()
	Local $path = RegRead($HKLM & "\SOFTWARE\BigNox\VirtualBox\", "InstallDir")
	If @error = 0 Then
		If StringRight($path, 1) <> "\" Then $path &= "\"
	Else
		$path = @ProgramFilesDir & "\Bignox\BigNoxVM\RT\"
	EndIf
	Return $path
EndFunc   ;==>GetNoxRtPath

Func GetDroid4XPath()
	Local $droid4xPath = RegRead($HKLM & "\SOFTWARE\Droid4X\", "InstallDir")
	If @error <> 0 Then
		Local $DisplayIcon = RegRead($HKLM & "\SOFTWARE" & $Wow6432Node & "\Microsoft\Windows\CurrentVersion\Uninstall\Droid4X\", "DisplayIcon")
		If @error = 0 Then
			Local $iLastBS = StringInStr($DisplayIcon, "\", 0, -1)
			$droid4xPath = StringLeft($DisplayIcon, $iLastBS)
		EndIf
	EndIf
	If @error <> 0 Then
		$droid4xPath = @ProgramFilesDir & "\Droid4X\"
	EndIf
	Return $droid4xPath
EndFunc   ;==>GetDroid4XPath

Func GetBsPath()
	$BsPath = RegRead($HKLM & "\SOFTWARE\BlueStacks\", "InstallDir")
	$plusMode = RegRead($HKLM & "\SOFTWARE\BlueStacks\", "Engine") = "plus"
	$frontend_exe = "HD-Frontend.exe"
	If $plusMode = True Then $frontend_exe = "HD-Plus-Frontend.exe"
	If $BsPath = "" And FileExists(@ProgramFilesDir & "\BlueStacks\" & $frontend_exe) = 1 Then
		$BsPath = @ProgramFilesDir & "\BlueStacks\"
	EndIf

	Return $BsPath
EndFunc   ;==>GetBsPath

Func EmuInstalled()

	Select
		Case $sSelectedEmulator = "MEmu"
			$EmuPath = GetMEmuPath()
			$EmuExe = "MEmu.exe"

		Case $sSelectedEmulator = "Droid4X"
			$EmuPath = GetDroid4XPath()
			$EmuExe = "Droid4X.exe"

		Case $sSelectedEmulator = "Nox"
			$EmuPath = GetNoxPath()
			$EmuExe = "Nox.exe"

		Case $sSelectedEmulator = "LeapDroid"
			$EmuPath = GetLeapDroidPath()
			$EmuExe = "LeapdroidVM.exe"

		Case $sSelectedEmulator = "BlueStacks" Or "BlueStacks2"
			$EmuPath = GetBsPath()
			$plusMode = RegRead($HKLM & "\SOFTWARE\BlueStacks\", "Engine") = "plus"
			$EmuExe = "HD-Frontend.exe"
			If $plusMode = True Then $EmuExe = "HD-Plus-Frontend.exe"

	EndSelect

	If FileExists($EmuPath & $EmuExe) = 1 Then
		$EmuInstalled = True
	Else
		$EmuInstalled = False

	EndIf


	Return $EmuInstalled


EndFunc   ;==>EmuInstalled

Func InstanceMgr()
	Select
		Case $sSelectedEmulator = "MEmu"
			$MgrPath = EnvGet("MEmuHyperv_Path") & "\MEmuManage.exe"
			If FileExists($MgrPath) = 0 Then
				$MgrPath = GetMEmuPath() & "..\MEmuHyperv\MEmuManage.exe"
			EndIf

		Case $sSelectedEmulator = "Droid4X"
			$MgrPath = RegRead($HKLM & "\SOFTWARE\Oracle\VirtualBox\", "InstallDir")
			If @error <> 0 Then
				$MgrPath = @ProgramFilesDir & "\Oracle\VirtualBox\"
			EndIf

		Case $sSelectedEmulator = "Nox"
			$MgrPath = GetNoxRtPath() & "BigNoxVMMgr.exe"

		Case $sSelectedEmulator = "LeapDroid"
			$MgrPath = GetLeapDroidPath() & "VBoxManage.exe"
	EndSelect


	Return $MgrPath

EndFunc   ;==>InstanceMgr

Func LaunchConsole($cmd, $param, $process_killed, $timeout = 10000)


	Local $data, $pid, $hTimer

	If StringLen($param) > 0 Then $cmd &= " " & $param

	$hTimer = TimerInit()
	$process_killed = False

	$pid = Run($cmd, "", @SW_HIDE, $STDERR_MERGED)
	If $pid = 0 Then
		Return
	EndIf

	Local $hProcess
	If _WinAPI_GetVersion() >= 6.0 Then
		$hProcess = _WinAPI_OpenProcess($PROCESS_QUERY_LIMITED_INFORMATION, 0, $pid)
	Else
		$hProcess = _WinAPI_OpenProcess($PROCESS_QUERY_INFORMATION, 0, $pid)
	EndIf

	$data = ""
	$iDelaySleep = 100
	Local $timeout_sec = Round($timeout / 1000)

	While True
		If $hProcess Then
			_WinAPI_WaitForSingleObject($hProcess, $iDelaySleep)
		Else
			Sleep($iDelaySleep)
		EndIf
		$data &= StdoutRead($pid)
		If @error Then ExitLoop
		If ($timeout > 0 And TimerDiff($hTimer) > $timeout) Then ExitLoop
	WEnd

	If $hProcess Then
		_WinAPI_CloseHandle($hProcess)
		$hProcess = 0
	EndIf

	CleanLaunchOutput($data)

	If ProcessExists($pid) Then
		If ProcessClose($pid) = 1 Then
			$process_killed = True
		EndIf
	EndIf
	StdioClose($pid)
	Return $data
EndFunc   ;==>LaunchConsole

Func CleanLaunchOutput(ByRef $output)
	$output = StringReplace($output, @CR & @CR, "")
	$output = StringReplace($output, @CRLF & @CRLF, "")
	If StringRight($output, 1) = @LF Then $output = StringLeft($output, StringLen($output) - 1)
	If StringRight($output, 1) = @CR Then $output = StringLeft($output, StringLen($output) - 1)
EndFunc   ;==>CleanLaunchOutput







