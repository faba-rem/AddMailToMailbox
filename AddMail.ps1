<#
.SYNOPSIS
    Add mail address to mailbox

.DESCRIPTION
    Skript to add new mail address to an exchange online mailbox

.PARAMETER MailBox
    defines mailbox where mail address should be added

.PARAMETER Mail
    defines new mailadress

.NOTES
    Version:        1.0
    Author:         Fabian Remmel
    Creation Date:  15.11.2017

.EXAMPLE
    .\AddMail.ps1 -MailBox Test -Mail test@test.de

#>

param(
    [string]$MailBox,
    [string]$Mail
)

#Get Admin Credentials
$UserCredential = Get-Credential
#Exchange Online Remot Powershell Session
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

#Get Mailadresses from mailbox
$tmp = (get-mailbox $MailBox).emailaddresses
#Adds mailadress
$tmp.add($Mail)
#Add to Mailbox
set-mailbox $MailBox -Emailaddresses $tmp

#Close PS Session
Remove-PSSession $Session
