$scriptPath = Split-Path $MyInvocation.MyCommand.Path
$basedir = Split-Path $scriptPath

$winhome = Join-Path $basedir winhome

function Create-Symlink($target, $link) {
  if ($link.EndsWith('.symlink')) {
    $target = Get-Content $target
    $link = $link.TrimEnd('.symlink')
  }
  echo "Creating $link"
  echo $target $link
  New-Item -Force -Type SymbolicLink "$link" -Value "$target"
}

ls $winhome | % {
  $link = Join-Path $HOME ".$_"
  $target = Join-Path $winhome $_
  Create-Symlink $target $link
}

Read-Host -Prompt "Press Enter to exit"
