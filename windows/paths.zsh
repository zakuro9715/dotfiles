basedir="$(cd $(dirname $0); pwd)"
appdata="/mnt/c/Users/z/AppData"
winpackages="$appdata/Local/Packages"
terminalSettingsPath() {
  echo $winpackages/Microsoft.WindowsTerminal_*/LocalState/settings.json
}

terminalSettingsBackupPath() {
  echo "$basedir/settings/windows_terminal.json"
}

vscodeSettingsPath() {
  echo $appdata/Roaming/Code/User/settings.json
}
vscodeSettingsBackupPath() {
  echo "$basedir/settings/vscode.json"
}
