' ============================================
' Cisco Secure Client VPN Auto-Connect
' Save this as: ConnectVPN.vbs
' ============================================

Option Explicit

' ========== CONFIGURATION - MODIFY THESE ==========
Const VPN_HOST = "your-vpn.company.com"
Const VPN_GROUP = "YourGroup"
Const VPN_USERNAME = "your.username"
' ==================================================

Const VPNCLI_PATH = "C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe"

Dim fso, shell, scriptDir, credentialFile, password

' Initialize objects
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

' Get script directory
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
credentialFile = fso.BuildPath(scriptDir, "vpn_credential.dat")

' ============================================
' MAIN PROGRAM
' ============================================

' Check if vpncli.exe exists
If Not fso.FileExists(VPNCLI_PATH) Then
    MsgBox "ERROR: vpncli.exe not found at:" & vbCrLf & VPNCLI_PATH & vbCrLf & vbCrLf & "Please verify Cisco Secure Client installation", vbCritical, "VPN Auto-Connect"
    WScript.Quit 1
End If

' Check current VPN status
If IsConnected() Then
    MsgBox "Already connected to VPN!", vbInformation, "VPN Auto-Connect"
    WScript.Quit 0
End If

' Try to load saved password
password = LoadPassword()

If password = "" Then
    ' First time setup - request password
    password = InputBox("Enter your VPN password:", "VPN Auto-Connect - First Time Setup")
    
    If password = "" Then
        MsgBox "Password cannot be empty. Exiting.", vbExclamation, "VPN Auto-Connect"
        WScript.Quit 1
    End If
    
    ' Try to connect
    If ConnectVPN(password) Then
        ' Ask if user wants to save password
        Dim saveResponse
        saveResponse = MsgBox("Connection successful!" & vbCrLf & vbCrLf & "Do you want to save the password for future use?", vbYesNo + vbQuestion, "VPN Auto-Connect")
        
        If saveResponse = vbYes Then
            SavePassword password
            MsgBox "Password saved securely. Next time you can connect with just one click!", vbInformation, "VPN Auto-Connect"
        Else
            MsgBox "Password not saved. You will need to enter it again next time.", vbInformation, "VPN Auto-Connect"
        End If
    Else
        MsgBox "Connection failed. Please check your credentials and try again.", vbCritical, "VPN Auto-Connect"
        WScript.Quit 1
    End If
Else
    ' Try to connect with saved password
    If Not ConnectVPN(password) Then
        ' Saved password failed
        Dim retryResponse
        retryResponse = MsgBox("Connection failed with saved password." & vbCrLf & vbCrLf & "Do you want to enter a new password?", vbYesNo + vbQuestion, "VPN Auto-Connect")
        
        If retryResponse = vbYes Then
            ' Delete old credential file
            If fso.FileExists(credentialFile) Then
                fso.DeleteFile credentialFile
            End If
            
            ' Request new password
            password = InputBox("Enter your new VPN password:", "VPN Auto-Connect")
            
            If password <> "" Then
                If ConnectVPN(password) Then
                    SavePassword password
                    MsgBox "Connection successful! New password saved.", vbInformation, "VPN Auto-Connect"
                Else
                    MsgBox "Connection failed. Please try again.", vbCritical, "VPN Auto-Connect"
                    WScript.Quit 1
                End If
            End If
        End If
    Else
        MsgBox "VPN connected successfully!", vbInformation, "VPN Auto-Connect"
    End If
End If

WScript.Quit 0

' ============================================
' FUNCTIONS
' ============================================

Function IsConnected()
    On Error Resume Next
    Dim exec, output
    Set exec = shell.Exec("""" & VPNCLI_PATH & """ state")
    output = exec.StdOut.ReadAll()
    IsConnected = InStr(output, "state: Connected") > 0
    On Error Goto 0
End Function

Function ConnectVPN(pass)
    On Error Resume Next
    
    Dim responseFile, tempFolder, exec, output
    
    ' Create temporary response file
    tempFolder = shell.ExpandEnvironmentStrings("%TEMP%")
    responseFile = fso.BuildPath(tempFolder, "vpn_response_" & GetRandomNumber() & ".txt")
    
    ' Write response file
    Dim ts
    Set ts = fso.CreateTextFile(responseFile, True)
    ts.WriteLine "connect " & VPN_HOST
    ts.WriteLine VPN_GROUP
    ts.WriteLine VPN_USERNAME
    ts.WriteLine pass
    ts.WriteLine "y"
    ts.Close
    
    ' Execute vpncli with response file
    Dim cmd
    cmd = "cmd /c type """ & responseFile & """ | """ & VPNCLI_PATH & """ -s"
    Set exec = shell.Exec(cmd)
    
    ' Wait for completion (with timeout)
    Dim timeout
    timeout = 0
    Do While exec.Status = 0 And timeout < 30
        WScript.Sleep 1000
        timeout = timeout + 1
    Loop
    
    ' Clean up response file
    If fso.FileExists(responseFile) Then
        fso.DeleteFile responseFile
    End If
    
    ' Check if connected
    WScript.Sleep 2000
    ConnectVPN = IsConnected()
    
    On Error Goto 0
End Function

Function SavePassword(pass)
    On Error Resume Next
    
    ' Use simple XOR obfuscation (better than plaintext)
    Dim encrypted
    encrypted = XORString(pass)
    
    ' Save to file
    Dim ts
    Set ts = fso.CreateTextFile(credentialFile, True)
    ts.WriteLine encrypted
    ts.Close
    
    On Error Goto 0
End Function

Function LoadPassword()
    On Error Resume Next
    
    If Not fso.FileExists(credentialFile) Then
        LoadPassword = ""
        Exit Function
    End If
    
    ' Read encrypted password
    Dim ts, encrypted
    Set ts = fso.OpenTextFile(credentialFile, 1)
    encrypted = ts.ReadLine()
    ts.Close
    
    ' Decrypt using XOR
    LoadPassword = XORString(encrypted)
    
    On Error Goto 0
End Function

Function XORString(text)
    On Error Resume Next
    
    Dim result, i, charCode, xorKey
    result = ""
    xorKey = 73 ' Simple XOR key
    
    For i = 1 To Len(text)
        charCode = Asc(Mid(text, i, 1))
        result = result & Chr(charCode Xor xorKey)
    Next
    
    XORString = result
    
    On Error Goto 0
End Function

Function GetRandomNumber()
    Randomize
    GetRandomNumber = Int((99999 - 10000 + 1) * Rnd + 10000)
End Function