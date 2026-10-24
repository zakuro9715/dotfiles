{ config, pkgs, lib, ... }:

let
  dotfiles = "~/src/github.com/zakuro9715/dotfiles";
in
{
  home.username = "zakuro";
  home.homeDirectory = "/home/zakuro";

  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    git
    tmux
    ghq
    ripgrep
    delta
    watchexec
    vim
    zsh
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  home.activation= {
    symlink = lib.hm.dag.entryAfter ["writeBoundary"] "run cd ${dotfiles} && ${pkgs.zsh}/bin/zsh scripts/install-symlinks.zsh";
  };

  programs.home-manager.enable = true;
}
