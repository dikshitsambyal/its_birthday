param(
  [Parameter(Mandatory = $true)]
  [string]$BuildPath,

  [Parameter(Mandatory = $true)]
  [string]$DeployPath
)

$ErrorActionPreference = "Stop"

$resolvedBuildPath = (Resolve-Path -LiteralPath $BuildPath).Path
$resolvedDeployPath = [System.IO.Path]::GetFullPath($DeployPath)
$deployRoot = [System.IO.Path]::GetPathRoot($resolvedDeployPath)

if ($resolvedDeployPath.TrimEnd('\') -eq $deployRoot.TrimEnd('\')) {
  throw "Refusing to deploy to drive root '$resolvedDeployPath'. Set a specific app folder instead."
}

if (-not (Test-Path -LiteralPath $resolvedDeployPath)) {
  New-Item -ItemType Directory -Force -Path $resolvedDeployPath | Out-Null
}

robocopy $resolvedBuildPath $resolvedDeployPath /MIR /NFL /NDL /NJH /NJS /NP
$robocopyExitCode = $LASTEXITCODE

if ($robocopyExitCode -ge 8) {
  throw "Deployment copy failed with robocopy exit code $robocopyExitCode."
}

Write-Host "Deployed $resolvedBuildPath to $resolvedDeployPath"
