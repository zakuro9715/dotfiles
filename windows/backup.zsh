basedir="$(cd $(dirname $0); pwd)"
source "$basedir/paths.zsh"
cp "$(terminalSettingsPath)" "$(terminalSettingsBackupPath)"
