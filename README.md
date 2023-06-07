 For more information see the blog post: https://s1.ai/MOVEit
 
 This is a simple script to scan IIS logs for potential exploitation of MOVEit. It iterates through the path
    passed in the command line and scans all files ending in ".log" for strings associated with the exploit. 
    The script will copy all lines that match the patterns to ".\results.log". 

    Usage:
    SentinelIISScanner.ps1 <path_to_iis_logs>

    Example:
    SentinelIISScanner.ps1 C:\inetpub\logs\LogFiles
