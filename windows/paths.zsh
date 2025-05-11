basedir="$(cd $(dirname $0); pwd)"
terminalSettingsPath() {
  echo /mnt/c/Users/z/AppData/Local/Packages/Microsoft.WindowsTerminal_*/LocalState/settings.json
}

terminalSettingsBackupPath() {
  echo "$basedir/settings/windows_terminal.json"
}

