# This script creates users from a csv file

Enter-PSSession -ComputerName <dc.local> -Credential <DOMAIN\user.name>

Import-Module ActiveDirectory

$Users = Import-Csv -Delimiter "," -Path "C:\Users.csv"
foreach ($Line in $Users)
{  
    $Password = $Line.Password
    $Detailedname = $Line.Firstname + " - " + $Linha.SecName
    $UserFirstname = $Line.Firstname
    $SAM =  $Line.Login
    $OU = "OU=Users,OU=DPTO,OU=ENV,DC=EMP,DC=LOCAL" 
    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $Line.Firstname -Surname $Line.SecName -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU -Description $Line.Description
    
}
