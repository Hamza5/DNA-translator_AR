;AutoIt3
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author:         Hamza Abbad
 Version:        1.0

 Script Function:
   Translate from DNA, mRNA, tRNA to DNA, mRNA, tRNA and polypeptide.

#ce ----------------------------------------------------------------------------
#AutoIt3Wrapper_Version=P
#AutoIt3Wrapper_Icon=E:\Hamza\Pictures\favicon.ico
#AutoIt3Wrapper_OutFile=E:\Hamza\Documents\AutoIt v3\DNA_translator.exe
#AutoIt3Wrapper_OutFile_Type=exe
#AutoIt3Wrapper_Compression=2
#AutoIt3Wrapper_UseUpx=Y
#AutoIt3Wrapper_Change2CUI=N
#AutoIt3Wrapper_Res_Comment=يمكنك هذا البرنامج من ترجمة الشفرات الوراثية
#AutoIt3Wrapper_Res_Description=برنامج لترجمة الشفرات الوراثية
#AutoIt3Wrapper_Res_Fileversion=1.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=P
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_Field=ProductName|مترجم الحمض النووي
#AutoIt3Wrapper_Res_Field=CompanyName|حمزة عبّاد
#AutoIt3Wrapper_Res_Language=5121
#AutoIt3Wrapper_Res_LegalCopyright=حمزة عبّاد 1433/2012
#AutoIt3Wrapper_res_requestedExecutionLevel=None
#AutoIt3Wrapper_res_Compatibility=Vista,Windows7
#AutoIt3Wrapper_Res_SaveSource=N
#AutoIt3Wrapper_Run_AU3Check=N

#NoTrayIcon
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>

Global Const $WindowTitle = "مترجم الحمض النووي"
Global Const $WindowText = "الشفرة الوراثية"
Global $MainWindow = GUICreate( $WindowTitle, 300, 400, @DesktopWidth/4, -1)
If $MainWindow = 0 Then
   MsgBox( 16, "Error", "Can not open the GUI (Graphical User Interface)!" & @CR & "Program will exit.")
   Exit 1
EndIf

Local $Option[6]
$Option[1] = "ADN - السلسلة غير المستنسخة"
$Option[2] = "ADN - السلسلة المستنسخة"
$Option[3] = "ARNm"
$Option[4] = "ARNt"
$Option[5] = "متعدد الببتيد"

If GUISetIcon( "E:\Hamza\Pictures\favicon.ico" ) = 0 Then MsgBox(16, "Error", "Icon Error")
;GUISetBkColor( 0x00EF38 )
;GUICtrlSetDefColor( 0x00FFF6 )
;GUICtrlSetDefBkColor( 0x00EF38 )
GUISetFont(15, 500)
Local $WindowSize = WinGetClientSize( $WindowTitle )
Local Const $WindowWidth = $WindowSize[0]
Local Const $WindowHeight = $WindowSize[1]

GUICtrlCreateLabel( "أدخل الشفرة الوراثية المراد ترجمتها أدناه", $WindowWidth - 280 , 10)
Global $Input = GUICtrlCreateInput( "", 5, 40, 290, Default, BitOr( $GUI_SS_DEFAULT_INPUT, $ES_UPPERCASE ))
GUICtrlSetTip( $Input, "أكتب الشفرة الوراثية هنا", Default, 1, 1)
Global $A = GUICtrlCreateButton( "A", 10, 85, 40, 30 )
Global $T = GUICtrlCreateButton( "T", 50, 85, 40, 30 )
Global $U = GUICtrlCreateButton( "U", 90, 85, 40, 30 )
GUICtrlSetState( $U, $GUI_DISABLE )
Global $C = GUICtrlCreateButton( "C", 130, 85, 40, 30 )
Global $G = GUICtrlCreateButton( "G", 170, 85, 40, 30 )
Global $Seperator = GUICtrlCreateButton( "-", 210, 85, 40, 30 )
Global $Bs = GUICtrlCreateButton( "حذف", $WindowWidth - 50, 85, 40, 30 )
GUICtrlSetTip( $Bs, "حذف التحديد", Default, 1, 1)
GUICtrlCreateLabel( "من", $WindowWidth - 40, 170)
Global $From = GUICtrlCreateCombo( $Option[1], $WindowWidth - 280, 170, 235, 20, BitOr($GUI_SS_DEFAULT_COMBO,$CBS_DROPDOWNLIST) )
GUICtrlSetData($From, $Option[2] & "|" & $Option[3] & "|" & $Option[4])
GUICtrlSetTip( $From, "نوع السلسلة الأصلية"& @CR & "ADN : A,T,C,G" & @CR & "ARN: A,U,C,G" , Default, 1, 1)
GUICtrlCreateLabel( "إلى", $WindowWidth - 40, 210 )
Global $To = GUICtrlCreateCombo( $Option[1], $WindowWidth - 280,  210, 235, 20, BitOr($GUI_SS_DEFAULT_COMBO,$CBS_DROPDOWNLIST) )
GUICtrlSetData($To, $Option[2] & "|" & $Option[3] & "|" & $Option[4] & "|" & $Option[5])
GUICtrlSetTip( $To , "نوع السلسلة الهدف" , Default, 1, 1)
Global $Translate = GUICtrlCreateButton( "ترجم", 50, 270, 200, 70 )
GUICtrlSetFont( $Translate, 40, 500 )
Global $Clear = GUICtrlCreateButton( "مسح", $WindowWidth - 200, 115, 100, 30 )
GUICtrlSetTip( $Clear , "مسح كل الإدخال" , Default, 1, 1)
Global $Menu = GUICtrlCreateMenu( "المزيد" )
Global $Load =  GUICtrlCreateMenuItem( "حمل من ملف", $Menu )
GUICtrlCreateMenuItem( "", $Menu )
Global $Table = GUICtrlCreateMenuItem( "جدول الشفرة الوراثية", $Menu)
GUICtrlCreateMenuItem( "", $Menu )
Global $About = GUICtrlCreateMenuItem( "حول البرنامج", $Menu )
Global $Exit = GUICtrlCreateMenuItem( "إغلاق البرنامج", $Menu )
Local $s = GUISetState(@SW_SHOW)
If $s = 0 Then
   MsgBox(16, "Error", "Can not show the GUI (Graphical User Interface)!" & @CR & "Program will exit.")
   Exit
EndIf
$msg = 0
;============================GUI===========================
While 1
   $msg = GUIGetMsg()
   Switch $msg
      Case $Exit
         ContinueCase
	  case $GUI_EVENT_CLOSE
	     ;MsgBox(64, "Test", "MainWindow Close Event" )
		 ExitLoop
	  case $A
		 ControlFocus( $WindowTitle, $WindowText, $Input )
         ControlSend($WindowTitle, $WindowText, $Input, "A")
	  case $T
		 ControlFocus( $WindowTitle, $WindowText, $Input )
         ControlSend($WindowTitle, $WindowText, $Input, "T")
	  case $U
		 ControlFocus( $WindowTitle, $WindowText, $Input )
         ControlSend($WindowTitle, $WindowText, $Input, "U")
	  case $C
		 ControlFocus( $WindowTitle, $WindowText, $Input )
         ControlSend($WindowTitle, $WindowText, $Input, "C")
	  case $G
		 ControlFocus( $WindowTitle, $WindowText, $Input )
         ControlSend($WindowTitle, $WindowText, $Input, "G")
      case $Bs
		 ControlFocus( $WindowTitle, $WindowText, $Input )
         ControlSend($WindowTitle, $WindowText, $Input, "{BS}")
	  case $Clear
		 GUICtrlSetData($Input, "")
	  Case $Translate
		 Local $code = GUICtrlRead($Input) ;Code
		 Local $in = GUICtrlRead($From) ;Text choice of Input
		 Local $out = GUICtrlRead($To) ;Text choice of output
		 For $i = 1 To 4
			If $in = $Option[$i] Then
			   $in = $i ;Numeric choice of input
			   For $k = 1 To 5
				  If $out = $Option[$k] Then
					 $out = $k ;Numeric choice of output
				  EndIf
			   Next
			EndIf
		 Next
		 Translate($code,$in,$out)
	  Case $From
	  If Not StringInStr( GUICtrlRead($From), "ADN" ) Then
		 GUICtrlSetState( $U, $GUI_ENABLE )
		 GUICtrlSetState( $T, $GUI_DISABLE )
		 GUICtrlSetData( $Input, StringReplace( GUICtrlRead( $Input ), "T", "U" ))
	  Else
		 GUICtrlSetState( $T, $GUI_ENABLE )
		 GUICtrlSetState( $U, $GUI_DISABLE )
		 GUICtrlSetData( $Input, StringReplace( GUICtrlRead( $Input ), "U", "T" ))
	  EndIf
      Case $Load
		 Local $FilePath = FileOpenDialog( "اختر الملف", @MyDocumentsDir, "ملف نصي (*.txt)|جميع الملفات (*.*)", 1 )
		 If Not @error Then
			Local $File = FileOpen($FilePath)
			Local $Code = FileRead($File)
			If @error = 1 Then
			   MsgBox( 16, "خطأ", "لا يمكن قراءة الملف")
			Else
			   FileClose($File)
			EndIf
			If Not StringRegExp( $Code, "([TUACG]{3})[\-\s_]?" ) Then
			   MsgBox( 16, "خطأ", "الملف ليس بتنسيق شفرة وراثية !" )
			Else
			   GUICtrlSetData( $Input, $Code )
			   If StringInStr( $Code, "U" ) And GUICtrlRead( $From ) <> $Option[4] Then
				  GUICtrlSetData( $From, $Option[3] )
				  GUICtrlSetState( $U, $GUI_ENABLE )
		          GUICtrlSetState( $T, $GUI_DISABLE )
			   ElseIf StringInStr( $Code, "T" ) And GUICtrlRead( $From ) <> $Option[1] Then
				  GUICtrlSetData( $From, $Option[2] )
				  GUICtrlSetState( $T, $GUI_ENABLE )
		          GUICtrlSetState( $U, $GUI_DISABLE )
			   EndIf
			EndIf
		 EndIf
	  Case $Input
		 If StringInStr( GUICtrlRead( $Input ), "U" ) And GUICtrlRead( $From ) <> $Option[4] Then
			GUICtrlSetData( $From, $Option[3] )
			GUICtrlSetState( $U, $GUI_ENABLE )
		    GUICtrlSetState( $T, $GUI_DISABLE )
		 ElseIf StringInStr( GUICtrlRead( $Input ), "T" ) And GUICtrlRead( $From ) <> $Option[1] Then
			GUICtrlSetData( $From, $Option[2] )
			GUICtrlSetState( $T, $GUI_ENABLE )
		    GUICtrlSetState( $U, $GUI_DISABLE )
		 EndIf
	  Case $Seperator
		 ControlFocus( $WindowTitle, $WindowText, $Input )
         ControlSend($WindowTitle, $WindowText, $Input, "-")
	  Case $Table
		 ShowTableWindow()
	  Case $About
		 About()
   EndSwitch
WEnd

Exit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func About()
   Opt("GUICoordMode", 1)
   GUICreate( "حول البرنامج", 300, 200 )
   If GUISetIcon( "E:\Hamza\Pictures\favicon.ico" ) = 0 Then MsgBox(16, "Error", "Icon Error")
   ;GUISetBkColor( 0x00EF38 )
   ;GUICtrlSetDefColor( 0x00FFF6 )
   ;GUICtrlSetDefBkColor( 0x00EF38 )
   GUISetFont( 15, 500, Default, "Arial" )
   GUICtrlCreateIcon( "E:\Hamza\Pictures\favicon.ico", -1, 126, 5, 48, 48 )
   GUICtrlCreateLabel( " مترجم الحمض النووي - الإصدار 1.0"& @CRLF & @CRLF & "لطلّاب السنة الثالثة ثانوي - علوم تجريبية" , 15, 60, Default, 80 )
   Local $L = GUICtrlCreateButton( "www.facebook.com/DNA-Translator", 30, 140, 240 )
   Local $Author = GUICtrlCreateLabel( "التصميم و البرمجة من طرف حمزة عبّاد", 70, 180 )
   GUICtrlSetFont( $Author, 9, 400, 2, "Arial Black" )
   GUICtrlSetFont( $L, 10 )
   GUICtrlSetColor( $L, 0x3E7EFF )
   GUISetState()
   While 1
	  $msg = GUIGetMsg(1)
	  Switch $msg[0]
         Case $GUI_EVENT_CLOSE
	        If $msg[1] = $MainWindow Then Exit
			;MsgBox(64, "Test", "About Close Event" )
		    ExitLoop
		 Case $L
			$r = ShellExecute( "http://www.facebook.com/DNA-Translator" )
	  EndSwitch
   WEnd
   GUIDelete()
EndFunc
#cs
1 = DNA-
2 = DNA+
3 = mRNA
4 = tRNA
5 = PP
#ce
Func Translate($Code,$From, $To)
   Local $r
   Switch $To
	  Case 1
         $r = toDNAminus($Code, $From)
      Case 2
         $r = toDNAplus($Code, $From)
      Case 3
         $r = tomRNA($Code, $From)
      Case 4
         $r = totRNA($Code, $From)
	  Case 5
		 $r = toPolypeptide($Code, $From)
   EndSwitch
   If Not StringInStr( $r, "خطأ" ) Then
	  ShowResult($r)
   Else
	  ToolTip( $r , Default, Default, "خطأ في الشفرة الوراثية", 3 )
	  Sleep( 3000 )
	  ToolTip("")
   EndIf
EndFunc
;--------------------------------------------------
Func ShowTableWindow()
   $Pos = WinGetPos( $WindowTitle )
   $Xpos = $Pos[0] + $WindowWidth + 15
   $Ypos = $Pos[1]
   $TableGUI = GUICreate( "جدول الشفرات الوراثية", 500, $WindowHeight, $Xpos , $Ypos, -1, -1 )
   If GUISetIcon( "E:\Hamza\Pictures\favicon.ico" ) = 0 Then MsgBox(16, "Error", "Icon Error")
   ;GUISetBkColor( 0x00EF38 )
   ;GUICtrlSetDefColor( 0x00FFF6 )
   ;GUICtrlSetDefBkColor( 0x00EF38 )
   GUISetFont(14)
   Opt("GUICoordMode", 0)
   ; --------------
   GUICtrlCreateLabel( "U", 10, 50, 30, 80, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "C", 0, 80, 30, 80, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "A", 0, 80, 30, 80, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "G", 0, 80, 30, 80, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   ; --------------
   Opt("GUICoordMode", 1)
   GUICtrlCreateLabel( "U", 50, 15, 80, 30, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   Opt("GUICoordMode", 0)
   GUICtrlCreateLabel( "C", 90, 0, 80, 30, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "A", 90, 0, 80, 30, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "G", 90, 0, 80, 30, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   ;---------------
   Opt("GUICoordMode", 1)
   GUICtrlCreateLabel( "U", 410, 50, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   Opt("GUICoordMode", 0)
   GUICtrlCreateLabel( "C", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "A", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "G", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )

   GUICtrlCreateLabel( "U", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "C", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "A", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "G", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )

   GUICtrlCreateLabel( "U", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "C", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "A", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "G", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )

   GUICtrlCreateLabel( "U", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "C", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "A", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "G", 0, 20, 30, 20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   ; --------------
   GUISetFont(10)
   Global $Codon[64]
   ;Col 1
   Opt("GUICoordMode", 1)
   $Codon[0] = GUICtrlCreateButton( "UUU", 50, 50, 40, 20 )
   Opt("GUICoordMode", 0)
   $Codon[1] = GUICtrlCreateButton( "UUC", 0, 20, 40, 20 )
   $Codon[2] = GUICtrlCreateButton( "UUA", 0, 20, 40, 20 )
   $Codon[3] = GUICtrlCreateButton( "UUG", 0, 20, 40, 20 )

   $Codon[4] = GUICtrlCreateButton( "CUU", 0, 20, 40, 20 )
   $Codon[5] = GUICtrlCreateButton( "CUC", 0, 20, 40, 20 )
   $Codon[6] = GUICtrlCreateButton( "CUA", 0, 20, 40, 20 )
   $Codon[7] = GUICtrlCreateButton( "CUG", 0, 20, 40, 20 )

   $Codon[8] = GUICtrlCreateButton( "AUU", 0, 20, 40, 20 )
   $Codon[9] = GUICtrlCreateButton( "AUC", 0, 20, 40, 20 )
   $Codon[10] = GUICtrlCreateButton( "AUA", 0, 20, 40, 20 )
   $Codon[11] = GUICtrlCreateButton( "AUG", 0, 20, 40, 20 )

   $Codon[12] = GUICtrlCreateButton( "GUU", 0, 20, 40, 20 )
   $Codon[13] = GUICtrlCreateButton( "GUC", 0, 20, 40, 20 )
   $Codon[14] = GUICtrlCreateButton( "GUA", 0, 20, 40, 20 )
   $Codon[15] = GUICtrlCreateButton( "GUG", 0, 20, 40, 20 )

   Opt("GUICoordMode", 1)
   GUICtrlCreateLabel( "Phe", 90, 50, 40, 2*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   Opt("GUICoordMode", 0)
   GUICtrlCreateLabel( "Leu", 0, 2*20, 40, 6*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Ile", 0, 6*20, 40, 3*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Met", 0, 3*20, 40, 1*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Val", 0, 1*20, 40, 4*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )

   ;Col 2
   Opt("GUICoordMode", 1)
   $Codon[16] = GUICtrlCreateButton( "UCU", 140, 50, 40, 20 )
   Opt("GUICoordMode", 0)
   $Codon[17] = GUICtrlCreateButton( "UCC", 0, 20, 40, 20 )
   $Codon[18] = GUICtrlCreateButton( "UCA", 0, 20, 40, 20 )
   $Codon[19] = GUICtrlCreateButton( "UCG", 0, 20, 40, 20 )

   $Codon[20] = GUICtrlCreateButton( "CCU", 0, 20, 40, 20 )
   $Codon[21] = GUICtrlCreateButton( "CCC", 0, 20, 40, 20 )
   $Codon[22] = GUICtrlCreateButton( "CCA", 0, 20, 40, 20 )
   $Codon[23] = GUICtrlCreateButton( "CCG", 0, 20, 40, 20 )

   $Codon[24] = GUICtrlCreateButton( "ACU", 0, 20, 40, 20 )
   $Codon[25] = GUICtrlCreateButton( "ACC", 0, 20, 40, 20 )
   $Codon[26] = GUICtrlCreateButton( "ACA", 0, 20, 40, 20 )
   $Codon[27] = GUICtrlCreateButton( "ACG", 0, 20, 40, 20 )

   $Codon[28] = GUICtrlCreateButton( "GCU", 0, 20, 40, 20 )
   $Codon[29] = GUICtrlCreateButton( "GCC", 0, 20, 40, 20 )
   $Codon[30] = GUICtrlCreateButton( "GCA", 0, 20, 40, 20 )
   $Codon[31] = GUICtrlCreateButton( "GCG", 0, 20, 40, 20 )

   Opt("GUICoordMode", 1)
   GUICtrlCreateLabel( "Ser", 180, 50, 40, 4*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   Opt("GUICoordMode", 0)
   GUICtrlCreateLabel( "Pro", 0, 4*20, 40, 4*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Thr", 0, 4*20, 40, 4*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Ala", 0, 4*20, 40, 4*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )

   ;Col 3
   Opt("GUICoordMode", 1)
   $Codon[32] = GUICtrlCreateButton( "UAU", 230, 50, 40, 20 )
   Opt("GUICoordMode", 0)
   $Codon[33] = GUICtrlCreateButton( "UAC", 0, 20, 40, 20 )
   $Codon[34] = GUICtrlCreateButton( "UAA", 0, 20, 40, 20 )
   $Codon[35] = GUICtrlCreateButton( "UAG", 0, 20, 40, 20 )

   $Codon[36] = GUICtrlCreateButton( "CAU", 0, 20, 40, 20 )
   $Codon[37] = GUICtrlCreateButton( "CAC", 0, 20, 40, 20 )
   $Codon[38] = GUICtrlCreateButton( "CAA", 0, 20, 40, 20 )
   $Codon[39] = GUICtrlCreateButton( "CAG", 0, 20, 40, 20 )

   $Codon[40] = GUICtrlCreateButton( "AAU", 0, 20, 40, 20 )
   $Codon[41] = GUICtrlCreateButton( "AAC", 0, 20, 40, 20 )
   $Codon[42] = GUICtrlCreateButton( "AAA", 0, 20, 40, 20 )
   $Codon[43] = GUICtrlCreateButton( "AAG", 0, 20, 40, 20 )

   $Codon[44] = GUICtrlCreateButton( "GAU", 0, 20, 40, 20 )
   $Codon[45] = GUICtrlCreateButton( "GAC", 0, 20, 40, 20 )
   $Codon[46] = GUICtrlCreateButton( "GAA", 0, 20, 40, 20 )
   $Codon[47] = GUICtrlCreateButton( "GAG", 0, 20, 40, 20 )

   Opt("GUICoordMode", 1)
   GUICtrlCreateLabel( "Tyr", 270, 50, 40, 2*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   Opt("GUICoordMode", 0)
   GUICtrlCreateLabel( "STOP", 0, 2*20, 40, 1*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "STOP", 0, 1*20, 40, 1*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "His", 0, 1*20, 40, 2*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Gln", 0, 2*20, 40, 2*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Asn", 0, 2*20, 40, 2*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Lys", 0, 2*20, 40, 2*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Asp", 0, 2*20, 40, 2*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Glu", 0, 2*20, 40, 2*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )

   ;Col 4
   Opt("GUICoordMode", 1)
   $Codon[48] = GUICtrlCreateButton( "UGU", 320, 50, 40, 20 )
   Opt("GUICoordMode", 0)
   $Codon[49] = GUICtrlCreateButton( "UGC", 0, 20, 40, 20 )
   $Codon[50] = GUICtrlCreateButton( "UGA", 0, 20, 40, 20 )
   $Codon[51] = GUICtrlCreateButton( "UGG", 0, 20, 40, 20 )

   $Codon[52] = GUICtrlCreateButton( "CGU", 0, 20, 40, 20 )
   $Codon[53] = GUICtrlCreateButton( "CGC", 0, 20, 40, 20 )
   $Codon[54] = GUICtrlCreateButton( "CGA", 0, 20, 40, 20 )
   $Codon[55] = GUICtrlCreateButton( "CGG", 0, 20, 40, 20 )

   $Codon[56] = GUICtrlCreateButton( "AGU", 0, 20, 40, 20 )
   $Codon[57] = GUICtrlCreateButton( "AGC", 0, 20, 40, 20 )
   $Codon[58] = GUICtrlCreateButton( "AGA", 0, 20, 40, 20 )
   $Codon[59] = GUICtrlCreateButton( "AGG", 0, 20, 40, 20 )

   $Codon[60] = GUICtrlCreateButton( "GGU", 0, 20, 40, 20 )
   $Codon[61] = GUICtrlCreateButton( "GGC", 0, 20, 40, 20 )
   $Codon[62] = GUICtrlCreateButton( "GGA", 0, 20, 40, 20 )
   $Codon[63] = GUICtrlCreateButton( "GGG", 0, 20, 40, 20 )

   Opt("GUICoordMode", 1)
   GUICtrlCreateLabel( "Cys", 360, 50, 40, 2*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   Opt("GUICoordMode", 0)
   GUICtrlCreateLabel( "STOP", 0, 2*20, 40, 1*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Trp", 0, 1*20, 40, 1*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Arg", 0, 1*20, 40, 4*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Ser", 0, 4*20, 40, 2*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Arg", 0, 2*20, 40, 2*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )
   GUICtrlCreateLabel( "Gly", 0, 2*20, 40, 4*20, BitOR($GUI_SS_DEFAULT_LABEL, $SS_SUNKEN, $SS_CENTER) )

   GUISetState()
   While 1
	  $msg = GUIGetMsg(1)
	  Switch $msg[0]
	     Case $Exit
            ContinueCase
		 Case $GUI_EVENT_CLOSE
			If $msg[1] = $MainWindow Then Exit
			;MsgBox(64, "Test", "Table Close Event" )
			ExitLoop
		 Case $msg = 0
		    ContinueLoop
		 case $A
		 ControlFocus( $WindowTitle, $WindowText, $Input )
         ControlSend($WindowTitle, $WindowText, $Input, "A")
	  case $T
		 ControlFocus( $WindowTitle, $WindowText, $Input )
         ControlSend($WindowTitle, $WindowText, $Input, "T")
	  case $U
		 ControlFocus( $WindowTitle, $WindowText, $Input )
         ControlSend($WindowTitle, $WindowText, $Input, "U")
	  case $C
		 ControlFocus( $WindowTitle, $WindowText, $Input )
         ControlSend($WindowTitle, $WindowText, $Input, "C")
	  case $G
		 ControlFocus( $WindowTitle, $WindowText, $Input )
         ControlSend($WindowTitle, $WindowText, $Input, "G")
      case $Bs
		 ControlFocus( $WindowTitle, $WindowText, $Input )
         ControlSend($WindowTitle, $WindowText, $Input, "{BS}")
	  case $Clear
		 GUICtrlSetData($Input, "")
	  Case $Translate
		 Local $code = GUICtrlRead($Input) ;Code
		 Local $in = GUICtrlRead($From) ;Text choice of Input
		 Local $out = GUICtrlRead($To) ;Text choice of output
		 For $i = 1 To 4
			If $in = $Option[$i] Then
			   $in = $i ;Numeric choice of input
			   For $k = 1 To 5
				  If $out = $Option[$k] Then
					 $out = $k ;Numeric choice of output
				  EndIf
			   Next
			EndIf
		 Next
		 Translate($code,$in,$out)
		 ExitLoop
	  Case $From
	  If Not StringInStr( GUICtrlRead($From), "ADN" ) Then
		 GUICtrlSetState( $U, $GUI_ENABLE )
		 GUICtrlSetState( $T, $GUI_DISABLE )
		 GUICtrlSetData( $Input, StringReplace( GUICtrlRead( $Input ), "T", "U" ))
	  Else
		 GUICtrlSetState( $T, $GUI_ENABLE )
		 GUICtrlSetState( $U, $GUI_DISABLE )
		 GUICtrlSetData( $Input, StringReplace( GUICtrlRead( $Input ), "U", "T" ))
	  EndIf
      Case $Load
		 Local $FilePath = FileOpenDialog( "اختر الملف", @MyDocumentsDir, "ملف نصي (*.txt)|جميع الملفات (*.*)", 1 )
		 If Not @error Then
			Local $File = FileOpen($FilePath)
			Local $Code = FileRead($File)
			If @error = 1 Then
			   MsgBox( 16, "خطأ", "لا يمكن قراءة الملف")
			Else
			   FileClose($File)
			EndIf
			If Not StringRegExp( $Code, "([TUACG]{3})[\-\s_]?" ) Then
			   MsgBox( 16, "خطأ", "الملف ليس بتنسيق شفرة وراثية !" )
			Else
			   GUICtrlSetData( $Input, $Code )
			   If StringInStr( $Code, "U" ) And GUICtrlRead( $From ) <> $Option[4] Then
				  GUICtrlSetData( $From, $Option[3] )
				  GUICtrlSetState( $U, $GUI_ENABLE )
		          GUICtrlSetState( $T, $GUI_DISABLE )
			   ElseIf StringInStr( $Code, "T" ) And GUICtrlRead( $From ) <> $Option[1] Then
				  GUICtrlSetData( $From, $Option[2] )
				  GUICtrlSetState( $T, $GUI_ENABLE )
		          GUICtrlSetState( $U, $GUI_DISABLE )
			   EndIf
			EndIf
		 EndIf
	  Case $Input
		 If StringInStr( GUICtrlRead( $Input ), "U" ) And GUICtrlRead( $From ) <> $Option[4] Then
			GUICtrlSetData( $From, $Option[3] )
			GUICtrlSetState( $U, $GUI_ENABLE )
		    GUICtrlSetState( $T, $GUI_DISABLE )
		 ElseIf StringInStr( GUICtrlRead( $Input ), "T" ) And GUICtrlRead( $From ) <> $Option[1] Then
			GUICtrlSetData( $From, $Option[2] )
			GUICtrlSetState( $T, $GUI_ENABLE )
		    GUICtrlSetState( $U, $GUI_DISABLE )
		 EndIf
		 Case $Seperator
		    ControlFocus( $WindowTitle, $WindowText, $Input )
            ControlSend($WindowTitle, $WindowText, $Input, "-")
		Case $About
		    About()
		 Case $msg[0] > 0
			;MsgBox(64, "Test", "Control Clicked: " & $msg[0])
			$bt = Button($msg[0])
			If IsString( $bt ) Then
			   ;MsgBox(64, "Test", "Control Received: " & $bt)
			   ControlFocus( $WindowTitle, $WindowText, $Input )
               ControlSend($WindowTitle, $WindowText, $Input, $bt)
			EndIf
	  EndSwitch
   WEnd
   GUIDelete($TableGUI)
EndFunc
;--------------------------------------------------
Func Button($b = 0)
   Local $btn = 0
   For $x = 0 To 63
	  If $Codon[$x] = $b Then
		 ;MsgBox(64, "Test", "Control Read: " & $Codon[$x])
		 $btn = GUICtrlRead($b)
		 ExitLoop
	  EndIf
   Next
   ;MsgBox(64, "Test", "$btn = " & $btn)
   Return $btn
EndFunc
;--------------------------------------------------
Func ShowResult($c)
   Opt("GUICoordMode", 1)
   GUICreate( "النتيجة", 400, 95, -1, -1, BitOR( $GUI_SS_DEFAULT_GUI, $WS_DLGFRAME), Default, $MainWindow )
   If GUISetIcon( "E:\Hamza\Pictures\favicon.ico" ) = 0 Then MsgBox(16, "Error", "Icon Error")
   ;GUISetBkColor( 0x00EF38 )
   ;GUICtrlSetDefColor( 0x00FFF6 )
   ;GUICtrlSetDefBkColor( 0x00EF38 )
   GUISetFont(15)
   GUICtrlCreateEdit( $c , 10, 10, 380, 45, BitOr( $ES_WANTRETURN, $WS_HSCROLL, $ES_READONLY ) )
   $ok = GUICtrlCreateButton( "موافق", 20, 60, 100, 30)
   $Save = GUICtrlCreateButton( "حفظ إلى ملف", 180, 60, 100, 30)
   $Copy = GUICtrlCreateButton( "نسخ", 280, 60, 100, 30 )
   GUISetState()
   While 1
	  $msg = GUIGetMsg()
	  Local $Time
	  Select
		 Case $msg = $GUI_EVENT_CLOSE Or $msg = $ok
		    ToolTip( "" )
			;MsgBox(64, "Test", "Result Close Event" )
			ExitLoop
		 Case $msg = $Save
			$FilePath = FileSaveDialog( "حفظ إلى ملف", @MyDocumentsDir, "ملف نصي (*.txt)|جميع الملفات (*.*)", 16, "DNA.txt" )
			If Not @error Then
			   $ft = FileOpen( $FilePath, 2 )
			   $File = FileWrite( $ft, $c )
			   If Not $File Then
				  MsgBox( 16, "خطأ", "لا يمكن حفظ الملف")
				  ToolTip( "لم يتم حفظ الملف", Default, Default, "حدث خطأ", 3 )
			   Else
			      FileClose( $File )
				  ToolTip( "تم حفظ الملف بنجاح", Default, Default, "تم الحفظ", 1 )
			   EndIf
			   $Time = TimerInit()
			EndIf
	     Case $msg = $Copy
			If ClipPut( $c ) Then
			   ToolTip( "تم نسخ النتيجة إلى الحافظة", Default, Default, "تم النسخ", 1 )
			Else
			   ToolTip( "لم يتم نسخ النتيجة إلى الحافظة", Default, Default, "فشل النسخ", 3 )
			EndIf
			$Time = TimerInit()
	  EndSelect
	  If TimerDiff( $Time ) >= 1500 Then ToolTip( "" )
   WEnd
   GUIDelete()
EndFunc
;===================================================
Func toDNAminus($Code, $From)
   Local $a = StringSplit($Code, "")
   Local $s = ""
   Local $e = 0 ;Error flag
   Local $i
   Switch $From
   Case 2 ; => DNA+
   For $i = 1 To $a[0]
	  $Ai = StringUpper($a[$i])
	  Select
		 Case $Ai = "T"
		 $s &= "A"
         Case $Ai = "A"
	     $s &= "T"
         Case $Ai = "C"
	     $s &= "G"
         Case $Ai = "G"
	     $s &= "C"
         Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	     $s &= $a[$i]
         Case Else
	     $e = 1
		 ExitLoop
	  EndSelect
   Next
   Case 3 ; => mRNA
      For $i = 1 To $a[0]
		 $Ai = StringUpper($a[$i])
	     Select
		    Case $Ai = "U"
	        $s &= "T"
            Case $Ai = "A" Or $Ai = "C" Or $Ai = "G"
	        $s &= $Ai
            Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	        $s &= $a[$i]
            Case Else
	        $e = 1
	        ExitLoop
		 EndSelect
	  Next
   Case 4 ; => tRNA
	  For $i = 1 To $a[0]
	  $Ai = StringUpper($a[$i])
	  Select
		 Case $Ai = "U"
	     $s &= "A"
         Case $Ai = "A"
	     $s &= "T"
         Case $Ai = "C"
	     $s &= "G"
         Case $Ai = "G"
	     $s &= "C"
         Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	     $s &= $a[$i]
         Case Else ; => DNA-
	     $e = 1
	     ExitLoop
	  EndSelect
	  Next
   Case Else
	  For $i = 1  To $a[0]
		 $Ai = StringUpper($a[$i])
         Select
	        Case $Ai = "A" Or $Ai = "C" Or $Ai = "G" Or $Ai = "T"
		    $s &= $Ai
			Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	        $s &= $a[$i]
            Case Else
		    $e = 1
		    ExitLoop
         EndSelect
	  Next
   EndSwitch
If $e = 0 Then
   Return $s
Else
   Return "يوجد خطأ في الشفرة الوراثية في المحرف رقم " & $i & ". " & "تحقق من إدخالك."
EndIf
EndFunc
Func toDNAplus($Code, $From)
   Local $a = StringSplit($Code, "")
   Local $s = ""
   Local $e = 0 ;Error flag
   Local $i
   Switch $From
	  Case 1 ; => DNA-
         For $i = 1 To $a[0]
			$Ai = StringUpper($a[$i])
			Select
               Case $Ai = "T"
	           $s &= "A"
               Case $Ai = "A"
	           $s &= "T"
               Case $Ai = "C"
	           $s &= "G"
               Case $Ai = "G"
	           $s &= "C"
               Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	           $s &= $a[$i]
               Case Else
	           $e = 1
	           ExitLoop
			EndSelect
		 Next
	  Case 3 ; => mRNA
		 For $i = 1 To $a[0]
			$Ai = StringUpper($a[$i])
			Select
			   Case $Ai = "U"
	           $s &= "A"
               Case $Ai = "A"
	           $s &= "T"
               Case $Ai = "C"
	           $s &= "G"
               Case $Ai = "G"
	           $s &= "C"
               Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	           $s &= $a[$i]
               Case Else
			   $e = 1
	           ExitLoop
	        EndSelect
		 Next
	  Case 4 ; => tRNA
		 For $i = 1 To $a[0]
			$Ai = StringUpper($a[$i])
	        Select
               Case $Ai = "U"
	           $s &= "T"
               Case $Ai = "A" Or $Ai = "C" Or $Ai = "G"
	           $s &= $Ai
               Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	           $s &= $a[$i]
               Case Else
	           $e = 1
	           ExitLoop
	        EndSelect
         Next
      Case Else ; => DNA+
		 For $i = 1 To $a[0]
			$Ai = StringUpper($a[$i])
			Select
	           Case $Ai = "A" Or $Ai = "C" Or $Ai = "G" Or $Ai = "T"
		       $s &= $Ai
			   Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	           $s &= $a[$i]
               Case Else
		       $e = 1
		       ExitLoop
            EndSelect
         Next
   EndSwitch
If $e = 0 Then
   Return $s
Else
   Return "يوجد خطأ في الشفرة الوراثية في المحرف رقم " & $i & ". " & "تحقق من إدخالك."
EndIf
EndFunc

Func tomRNA($Code, $From, $ForPP = False)
   Local $a = StringSplit($Code, "")
   Local $s = ""
   Local $e = 0 ;Error flag
   Local $i
   Switch $From
   Case 2 ; => DNA+
   For $i = 1 To $a[0]
	  $Ai = StringUpper($a[$i])
	  Select
		 Case $Ai = "T"
		 $s &= "A"
         Case $Ai = "A"
	     $s &= "U"
         Case $Ai = "C"
	     $s &= "G"
         Case $Ai = "G"
	     $s &= "C"
         Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	     $s &= $a[$i]
         Case Else
	     $e = 1
		 ExitLoop
	  EndSelect
   Next
   Case 1 ; => DNA-
      For $i = 1 To $a[0]
		 $Ai = StringUpper($a[$i])
	     Select
		    Case $Ai = "T"
	        $s &= "U"
            Case $Ai = "A" Or $Ai = "C" Or $Ai = "G"
	        $s &= $Ai
            Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	        $s &= $a[$i]
            Case Else
	        $e = 1
	        ExitLoop
		 EndSelect
	  Next
   Case 4 ; => tRNA
	  For $i = 1 To $a[0]
		 $Ai = StringUpper($a[$i])
	  Select
		 Case $Ai = "U"
	     $s &= "A"
         Case $Ai = "A"
	     $s &= "U"
         Case $Ai = "C"
	     $s &= "G"
         Case $Ai = "G"
	     $s &= "C"
         Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	     $s &= $a[$i]
         Case Else
	     $e = 1
	     ExitLoop
	  EndSelect
	  Next
   Case Else ; => mRNA
	  For $i = 1  To $a[0]
		 $Ai = StringUpper($a[$i])
         Select
	        Case $Ai = "A" Or $Ai = "C" Or $Ai = "G" Or $Ai = "U"
		    $s &= $Ai
			Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	        $s &= $a[$i]
            Case Else
		    $e = 1
		    ExitLoop
         EndSelect
	  Next
   EndSwitch
If $e = 0 And Not $ForPP Then
   Return $s
ElseIf $e = 0 And $ForPP Then
   Return StringRegExp( $s, "([TUACG]{3})[\-\s_]?", 3 )
ElseIf $e <> 0 And $ForPP Then
   Return $i
Else
   Return "يوجد خطأ في الشفرة الوراثية في المحرف رقم " & $i & ". " & "تحقق من إدخالك."
EndIf
EndFunc
Func totRNA($Code, $From)
   Local $a = StringSplit($Code, "")
   Local $s = ""
   Local $e = 0 ;Error flag
   Local $i
   Switch $From
	  Case 1 ; => DNA-
         For $i = 1 To $a[0]
			$Ai = StringUpper($a[$i])
			Select
               Case $Ai = "T"
	           $s &= "A"
               Case $Ai = "A"
	           $s &= "U"
               Case $Ai = "C"
	           $s &= "G"
               Case $Ai = "G"
	           $s &= "C"
               Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	           $s &= $a[$i]
               Case Else
	           $e = 1
	           ExitLoop
			EndSelect
		 Next
	  Case 3 ; => mRNA
		 For $i = 1 To $a[0]
			$Ai = StringUpper($a[$i])
			Select
			   Case $Ai = "U"
	           $s &= "A"
               Case $Ai = "A"
	           $s &= "U"
               Case $Ai = "C"
	           $s &= "G"
               Case $Ai = "G"
	           $s &= "C"
               Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	           $s &= $a[$i]
               Case Else
			   $e = 1
	           ExitLoop
	        EndSelect
		 Next
	  Case 2 ; => DNA+
		 For $i = 1 To $a[0]
			$Ai = StringUpper($a[$i])
	        Select
               Case $Ai = "T"
	           $s &= "U"
               Case $Ai = "A" Or $Ai = "C" Or $Ai = "G"
	           $s &= $Ai
               Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	           $s &= $a[$i]
               Case Else
	           $e = 1
	           ExitLoop
	        EndSelect
         Next
      Case Else ; => tRNA
		 For $i = 1 To $a[0]
			$Ai = StringUpper($a[$i])
			Select
	           Case $Ai = "A" Or $Ai = "C" Or $Ai = "G" Or $Ai = "U"
		       $s &= $Ai
			   Case $Ai = "-" Or $Ai = "_" Or $Ai = " "
	           $s &= $a[$i]
               Case Else
		       $e = 1
		       ExitLoop
            EndSelect
         Next
   EndSwitch
If $e = 0 Then
   Return $s
Else
   Return "يوجد خطأ في الشفرة الوراثية في المحرف رقم " & $i & ". " & "تحقق من إدخالك."
EndIf
EndFunc
Func toPolypeptide($Code, $From)
   $Code = tomRNA($Code, $From, True)
   If IsNumber($Code) Then
	  Return "يوجد خطأ في الشفرة الوراثية في المحرف رقم " & $Code & ". " & "تحقق من إدخالك."
   ElseIf IsString($Code) And StringInStr( $Code, "خطأ" ) Then
      Return $Code
   EndIf
   Local $e = 0
   Local $i
   Local $s = ""
   Local $a = $Code
   $Code = 0
   Local $aLength = UBound($a)
   For $i = 0 To $aLength - 1
	  Select
		 Case $a[$i] = "UUU" Or $a[$i] = "UUC"
			$s &= "Phe-"
		 Case $a[$i] = "UUA" Or $a[$i] = "UUG" Or $a[$i] = "CUU" Or $a[$i] = "CUC" Or $a[$i] = "CUA" Or $a[$i] = "CUG"
			$s &= "Leu-"
		 Case $a[$i] = "AUU" Or $a[$i] = "AUC" Or $a[$i] = "AUA"
			$s &= "Ile-"
		 Case $a[$i] = "AUG"
			$s &= "Met-"
		 Case $a[$i] = "GUU" Or $a[$i] = "GUC" Or $a[$i] = "GUA" Or $a[$i] = "GUG"
			$s &= "Val-"
		 Case $a[$i] = "UCU" Or $a[$i] = "UCC" Or $a[$i] = "UCA" Or $a[$i] = "UCG" Or $a[$i] = "AGU" Or $a[$i] = "AGC"
			$s &= "Ser-"
		 Case $a[$i] = "CCU" Or $a[$i] = "CCC" Or $a[$i] = "CCA" Or $a[$i] = "CCG"
			$s &= "Pro-"
		 Case $a[$i] = "ACU" Or $a[$i] = "ACC" Or $a[$i] = "ACA" Or $a[$i] = "ACG"
			$s &= "Thr-"
		 Case $a[$i] = "GCU" Or $a[$i] = "GCC" Or $a[$i] = "GCA" Or $a[$i] = "GCG"
			$s &= "Ala-"
		 Case $a[$i] = "UAU" Or $a[$i] = "UAC"
			$s &= "Tyr-"
		 Case $a[$i] = "CAU" Or $a[$i] = "CAC"
			$s &= "His-"
		 Case $a[$i] = "CAA" Or $a[$i] = "CAG"
			$s &= "Gln-"
		 Case $a[$i] = "AAU" Or $a[$i] = "AAC"
			$s &= "Asn-"
		 Case $a[$i] = "AAA" Or $a[$i] = "AAG"
			$s &= "Lys-"
		 Case $a[$i] = "GAU" Or $a[$i] = "GAC"
			$s &= "Asp-"
		 Case $a[$i] = "GAA" Or $a[$i] = "GAG"
			$s &= "Glu-"
		 Case $a[$i] = "UGU" Or $a[$i] = "UGC"
			$s &= "Cys-"
		 Case $a[$i] = "UGG"
			$s &= "Trp-"
		 Case $a[$i] = "CGU" Or $a[$i] = "CGC" Or $a[$i] = "CGA" Or $a[$i] = "CGG" Or $a[$i] = "AGA" Or $a[$i] = "AGG"
			$s &= "Arg-"
		 Case $a[$i] = "GGU" Or $a[$i] = "GGC" Or $a[$i] = "GGA" Or $a[$i] = "GGG"
			$s &= "Gly-"
		 Case $a[$i] = "UAA" Or $a[$i] = "UAG" Or $a[$i] = "UGA"
			$s &= "STOP-"
		 Case Else
			$e = 1
			ExitLoop
	  EndSelect
   Next
   If $e = 1 Then
	  Return "يوجد خطأ في الشفرة الوراثية في المحرف رقم " & $i & ". " & "تحقق من إدخالك."
   Else
   $s = StringTrimRight( $s, 1 )
   Return $s
   EndIf
EndFunc
