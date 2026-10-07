param([string]$Path)

if (-not (Test-Path -LiteralPath $Path)) { exit 0 }

Add-Type -AssemblyName presentationCore
$player = New-Object System.Windows.Media.MediaPlayer
$player.Open([uri](Resolve-Path -LiteralPath $Path).Path)

$deadline = (Get-Date).AddSeconds(2)
while (-not $player.NaturalDuration.HasTimeSpan -and (Get-Date) -lt $deadline) {
    Start-Sleep -Milliseconds 50
}

$player.Play()
$ms = 3000
if ($player.NaturalDuration.HasTimeSpan) { $ms = [int]$player.NaturalDuration.TimeSpan.TotalMilliseconds }
Start-Sleep -Milliseconds ($ms + 200)
