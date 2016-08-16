function Get-Uptime {
    <#
    .SYNOPSIS 
        Get machine uptime
    .DESCRIPTION
        Get machine uptime using WMI query
    .PARAMETER Path
        Path to file
    .EXAMPLE
        Get-Uptime

        Shows uptime of a localhost
    .EXAMPLE
       Get-Uptime -ComputerName remoteserver -Credential [pscredential]$cred

        Shows uptime of a remoteserver
    .INPUTS 
    .OUTPUTS 
    .NOTES 
    .LINK 
    .COMPONENT 
    .ROLE 
    .FUNCTIONALITY
    #>
    
    [CmdletBinding()]

    param (
        [parameter (ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
        [Alias('Host')]
        [string[]]$ComputerName = 'localhost',
        [pscredential]$credential
    )
    
    BEGIN {
        $a = @()
    }
    
    PROCESS { 
        $uptime = (Get-WmiObject -Class win32_operatingsystem -ComputerName $ComputerName -Credential $credential).ConvertToDateTime((Get-WmiObject -Class win32_operatingsystem -ComputerName $ComputerName -Credential $credential).LastBootUpTime)
        $a += New-Object psobject -Property @{ComputerName = $ComputerName; Uptime = $uptime}
    }
    END {
        Write-Output $a
    }
}