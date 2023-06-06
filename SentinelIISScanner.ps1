<#

    Sentinel IIS Scanner
    ====================

    This is a simple script to scan IIS logs for potential exploitation of MOVEit. It iterates through the path
    passed in the command line and scans all files ending in ".log" for strings associated with the exploit. 
    The script will copy all lines that match the patterns to ".\results.log". 

    Usage:
    SentinelIISScanner.ps1 <path_to_iis_logs>

    Example:
    SentinelIISScanner.ps1 C:\inetpub\logs\LogFiles
#>


Write-Output "[*] Starting SentinelIISScanner.ps1"

if ($args.Length -ne 1){

    Write-Output "[-] Invalid command line provided. Please provide full path to dir to scan.`n[*] Example: SentinelScanIIS.ps1 C:\inetpub\logs\LogFiles"
    Exit
}

$logs_dir = $args[0]
$results_log = "results.log"

if (-not ($logs_dir|Test-Path)){
    Write-Output "[-] Invalid path '$logs_dir' provided for scanning. Exiting..."
    Exit
}

Write-Output "[*] Scanning $logs_dir"
Write-Output "[*] Results will be written to .\$results_log"

Get-ChildItem -Path $logs_dir -Recurse -File -Filter "*.log" -ErrorAction SilentlyContinue -Force |
        ForEach-Object {
            Write-Output "[*] Scanning $_"
            Select-String -Path $_.FullName -Pattern "POST /moveitisapi/(moveitisapi|MOVEitFilt)\.dll action=m2 .{0,600} 200 " | Out-File -Append $results_log -Encoding ascii
            Select-String -Path $_.FullName -Pattern "POST /guestaccess\.aspx .{0,600} 200 " | Out-File -Append $results_log -Encoding ascii
            Select-String -Path $_.FullName -Pattern "GET /human2\.aspx .{0,600} 200 " | Out-File -Append $results_log -Encoding ascii
        }

Write-Output "[*] Done."