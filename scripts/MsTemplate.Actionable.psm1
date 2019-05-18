#!/usr/bin/pwsh

Function Test-PomMissing {
    if (-not $env:POMODORO_REPOS) {
        Write-Host "Please set the $env:POMODORO_REPOS to the location of this repo."
        return $true
    }   
}

Function Use-PomDirectory {
    if (Test-PomMissing) { RETURN }
    Set-Location "$env:POMODORO_REPOS/PersonalTracker.Api"
}

Function Start-PmsTemplate.Actionable {
    param(
        # [Parameter(
        #     Mandatory=$true, 
        #     HelpMessage="Starts IdentiyManagement microservices.",
        #     ParameterSetName="Individual")]
        # [ValidateSet(
        #     "pomodoro-pgsql",
        #     "pomodoro-idserver",
        #     "pomodoro-identity", 
        #     "pomodoro-resource", 
        #     "pomodoro-privilege", 
        #     "pomodoro-reverse-proxy",
        #     "watch-pomo-rapi",
        #     "pomo-ping-rapi",
        #     "pomodoro-client"
        # )] 
        # [string]$Container,
        [Parameter(
            Mandatory=$false, 
            HelpMessage="Use 'dotnet run'")]
        [switch]$Runs
    )

    if (Test-PomMissing) { RETURN }

    Write-Host "Starting pms-template.actionable..."

    if ($Runs) {
        # Cannot attach a debugger, but can have the app auto reload during development.
        # https://github.com/dotnet/dotnet-docker/blob/master/samples/dotnetapp/dotnet-docker-dev-in-container.md
        docker run `
            --name pms-template.actionable `
            --rm -it `
            -p 8080:8080 `
            --network pomodoro-net `
            --entrypoint "/bin/bash" `
            -v $env:POMODORO_REPOS/Template.Actionable/Template.Actionable/src/:/app/Template.Actionable/Template.Actionable/src/ `
            -v $env:POMODORO_REPOS/Template.Actionable/Template.Actionable/secrets/:/app/Template.Actionable/Template.Actionable/secrets/ `
            -v $env:POMODORO_REPOS/Template.Actionable/Template.Actionable.Domain/src/:/app/Template.Actionable/Template.Actionable.Domain/src/ `
            -v $env:POMODORO_REPOS/Template.Actionable/Template.Actionable.Domain.DAL/src/:/app/Template.Actionable/Template.Actionable.Domain.DAL/src/ `
            -v $env:POMODORO_REPOS/Template.Actionable/Template.Actionable.UnitTests/src/:/app/Template.Actionable/Template.Actionable.UnitTests/src/ `
            pms-template.actionable
#            pms-template.actionable "run" "--project" "Template.Actionable"
    } else {
        # Cannot attach a debugger, but can have the app auto reload during development.
        # https://github.com/dotnet/dotnet-docker/blob/master/samples/dotnetapp/dotnet-docker-dev-in-container.md
        docker run `
        --name pms-template.actionable `
        --rm -it `
        -p 2005:8080 `
        --network pomodoro-net `
        -v $env:POMODORO_REPOS/Template.Actionable/Template.Actionable/src/:/app/Template.Actionable/Template.Actionable/src/ `
        -v $env:POMODORO_REPOS/Template.Actionable/Template.Actionable/secrets/:/app/Template.Actionable/Template.Actionable/secrets/ `
        -v $env:POMODORO_REPOS/Template.Actionable/Template.Actionable.Domain/src/:/app/Template.Actionable/Template.Actionable.Domain/src/ `
        -v $env:POMODORO_REPOS/Template.Actionable/Template.Actionable.Domain.DAL/src/:/app/Template.Actionable/Template.Actionable.Domain.DAL/src/ `
        -v $env:POMODORO_REPOS/Template.Actionable/Template.Actionable.UnitTests/src/:/app/Template.Actionable/Template.Actionable.UnitTests/src/ `
        pms-template.actionable

    }
}
Function Build-PmsTemplate.Actionable {
    <#
    .SYNOPSIS
        Builds the docker container related to the pomodor project.
    .DESCRIPTION
        Builds the docker container related to the pomodor project.
    .PARAMETER Image
        One of the valid images for the pomodoro project
    .EXAMPLE
    .NOTES
        Author: Phillip Scott Givens
    #>    
    param(
        [Parameter(Mandatory=$false)]
        [ValidateSet(
            "docker", 
            "microk8s.docker",
            "azure"
            )] 
        [string]$Docker="docker"
    )

    if (Test-PomMissing) { RETURN }
    if ($Docker) {
        Set-Alias dkr $Docker -Option Private
    }

    $buildpath = "$env:POMODORO_REPOS/Template.Actionable"
    dkr build `
        -t pms-template.actionable `
        -f "$buildpath/watch.Dockerfile" `
        "$buildpath/.."
}

Function Update-PmsTemplate.Actionable {
    if (Test-PomMissing) { RETURN }

    $MyPSModulePath = "{0}/.local/share/powershell/Modules" -f (ls -d ~)
    mkdir -p $MyPSModulePath/MsTemplate.Actionable

    Write-Host ("Linking {0}/Template.Actionable/scripts/MsTemplate.Actionable.psm1 to {1}/MsTemplate.Actionable/" -f $env:POMODORO_REPOS,  $MyPSModulePath)
    ln -s $env:POMODORO_REPOS/Template.Actionable/scripts/MsTemplate.Actionable.psm1  $MyPSModulePath/MsTemplate.Actionable/MsTemplate.Actionable.psm1

    Write-Host "Force import-module PomodorEnv"
    Import-Module -Force MsTemplate.Actionable -Global

}



Export-ModuleMember -Function Build-PmsTemplate.Actionable
Export-ModuleMember -Function Start-PmsTemplate.Actionable
Export-ModuleMember -Function Update-PmsTemplate.Actionable