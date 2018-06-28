# This script creates users from a csv file

Enter-PSSession -ComputerName <dc.local> -Credential <DOMAIN\user.name>

Import-Module ActiveDirectory

$Users = Import-Csv -Delimiter "," -Path "C:\Users.csv"
foreach ($Linha in $Users)
{  
    $Password = $Linha.Password
    $Detailedname = $Linha.Firstname + " - " + $Linha.SecName
    $UserFirstname = $Linha.Firstname
    $SAM =  $Linha.Login
    $OU = "OU=Users,OU=DPTO,OU=ENV,DC=EMP,DC=LOCAL" 
    New-ADUser -Name $Detailedname -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $Detailedname -GivenName $Linha.Firstname -Surname $Linha.SecName -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU -Description $Linha.Description
    
}
