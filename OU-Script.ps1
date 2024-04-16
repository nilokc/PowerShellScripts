#Find accounts that have been inactive for at least 90 days
$StalePCs = Search-AdAccount -AccountInactive -computersonly -Timespan 90.00:00:00 -searchbase "OU=server,DC=TypeYourDomain,DC=local" | 
where-object {($_.name -notlike "*type your 'not' search filter*") -or ($_.operatingsystem -like "*server*") }|
select-object SamAccountName,lastlogondate,enabled,objectclass,DistinguishedName
$pcsfound = 0

NOT: Path i bulup ona gore tasiyor

Foreach ($item in $stalepcs)
{
 #Find and remove each Computer based on the computername from the array built above. 
 $SAM = $item.SamAccountName
 $PathName= $item.DistinguishedName
 Echo $PathName
 Move-ADObject -Identity $($PathName) -TargetPath "OU=legacy server objects,DC=TypeYourDomain,DC=local"

 #Get-ADComputer -identity $SAM | remove-adobject -Recursive -confirm:$false -whatif
 #Increase Count for each cycle
 $Script:pcsfound++
}

"$pcsfound computer objects have been found" 
Pause
$stalepcs | export-csv -path c:\temp\nameof the document.csv
 