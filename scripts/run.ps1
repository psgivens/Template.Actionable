#!/usr/bin/pwsh


$domain = "http://localhost:8080"

# Function Invoke-ErrorRequest {
#     param(
#         [Parameter(Mandatory=$true)]
#         [string]$Uri
#     )
#     $response = try { 
#         (Invoke-WebRequest -Uri $Uri ).BaseResponse
#     } catch [System.Net.WebException] { 
#         Write-Verbose "An exception was caught: $($_.Exception.Message)"
#         $_.Exception.Response 
# 
#         #then convert the status code enum to int by doing this
#         $statusCodeInt = $response.BaseResponse.StatusCode
#     } 
#     $statusCodeInt
# }


$contextHeaders = @{
    user_id='5d5299ef-16b8-4bbd-9e44-017cdf454d4c'
    transaction_id='1745e060-1ac2-4796-8e60-cc8313dba6c5'
}

# # bad request
# $err = Invoke-ErrorRequest `
#   -Uri $domain 
# $err


# Default route
Invoke-WebRequest `
  -Method GET `
  -Uri $domain `
  -Headers $contextHeaders 
    

# Default route
$widgets = Invoke-RestMethod `
  -Method GET `
  -Uri $domain/widgets `
  -Headers $contextHeaders 
$widgets | measure | %{ if ($_.Count -le 1) { Write-Error "no widgets found." } }


# Default route
$widget = Invoke-RestMethod `
  -Method GET `
  -Uri $domain/widgets/one@three.com `
  -Headers $contextHeaders 
if ($widget -eq $null) { Write-Error "no widget found." } 


$joseph = @{ 
    email='joseph@smith.com'
    first_name='joseph'
    last_name='smith'
}
$ret = Invoke-RestMethod `
  -Method Post `
  -Uri $domain/widgets `
  -Headers $contextHeaders 
if ($widget -eq $null) { Write-Error "no widget found." } 


