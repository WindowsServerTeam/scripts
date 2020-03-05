
$serverlist = get-content .\serverlist.txt

if(test-path -path .\Query_failed.txt) { cmd /c "del /q /s Query_failed.txt" 2>&1 2 > $null }
if(test-path -path .\Query_Succeeded.txt) { cmd /c "del /q /s Query_Succeeded.txt" 2>&1 2 > $null }


foreach ($server in $serverlist) {

"`n$server...`n"

Try {

test-connection $server -count 1 -erroraction Stop | out-null

}
catch { 

$ErrorMessage =$_.exception.message

"$ErrorMessage"

Echo "$server, Not reachable, $Errormessage" >> .\Query_failed.txt 

Continue }

if(!(reg query \\$server\HKLM\software)) { 

"$server, No access" >> .\Query_failed.txt 

Continue}

else { "$server" >> .\Query_Succeeded.txt }

}



"Script execution completed!`n"


Echo " "

Exit
