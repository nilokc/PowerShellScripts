$path = "D:\Share\Allgemein" #define path to the shared folder
Tree $path /A
$reportpath ="C:\Users\nokcu\Desktop\tree\allgemein.csv" #define path to export permissions report
#script scans for directories under shared folder and gets acl(permissions) for all of them
dir -Recurse $path | where { $_.PsIsContainer -eq "TRUE" } | % { $path1 = $_.fullname; Get-Acl $_.Fullname | % { $_.access | Add-Member -MemberType NoteProperty '.\Application Data' -Value $path1 -passthru }} | Export-Csv $reportpath