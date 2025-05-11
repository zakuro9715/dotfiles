basedir="$(cd $(dirname $0); pwd)"
appdata="/mnt/c/Users/z/AppData"
winpackages="$appdata/Local/Packages"
terminalSettingsPath() {
  echo $winpackages/Microsoft.WindowsTerminal_*/LocalState/settings.json
}

terminalSettingsBackupPath() {
  echo "$basedir/settings/windows_terminal.json"
}

vscode="$appdata/Roaming/Code/User"
vscodeSettingsPath() {
  echo $vscode/settings.json
}
vscodeSettingsBackupPath() {
  echo "$basedir/settings/vscode.json"
}
vscodeKeybindingsPath() {
  echo $vscode/keybindings.json
}
vscodeKeybindingsBackupPath() {
  echo "$basedir/settings/vscode-keybinding.json"
}
vscodeTasksPath() {
  echo $vscode/tasks.json
}
vscodeTasksBackupPath() {
  echo "$basedir/settings/vscode-tasks.json"
}
