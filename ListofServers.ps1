$source = "OU=Server,DC=NAme_of_DC,DC=local"
$servers = Get-ADComputer -SearchBase $source -Filter * -Properties * | select -Property DistinguishedName,DNSHostName,Enabled,Name,ObjectClass,ObjectGUID,SamAccountName,SID
$servers | Export-csv C:\Add path of document.csv -NoTypeInformation