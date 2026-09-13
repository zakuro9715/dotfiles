# Dotfiles

## Files

- install.sh: First installation script for minimal environment.
- bootstrap.zsh: Main setup script.
- home: Directory contaesining configuration files for $HOME
    - home/foorc will be placed in $HOME/.foorc
- scripts: Miscellaneous scripts
    - scripts/create_symlinks.zsh: Creates symlinks for home/* in $HOME
- installers: Directory containing installation scripts for various tools and applications.
- deps.zsh: Dependency list used by installers
- tests: Test files
    - tests/run: run test. thin wrapper of bats


## Call tree

```
install.sh -> bootstrap.zsh -> scripts/install_symlinks.zsh
                            -> installers/*
```

## Development

- .sh should be POSIX compliant.
- scripts should be written in zsh.

## Testing

- Bats for script test.
- Test file placed in tests/ directory.

## Lint

- Use ShellCheck for shell scripts.
- Scripts must pass ShellCheck with no errors or warnings.
- zsh scripts don't need to pass ShellCheck for now, but should be written in a clean and readable style.
