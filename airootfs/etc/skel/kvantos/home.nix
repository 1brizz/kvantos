{ config, pkgs, ... }:

{
  home.username = "@USER@";
  home.homeDirectory = "@HOME@";
  home.stateVersion = "24.11";

  # Профиль обучения программированию (KvantOS).
  home.packages = with pkgs; [
    vscodium
    rustup
    jupyterlab
    git
  ];

  programs.git = {
    enable = true;
    userName = "@USER@";
    # userEmail = "you@example.com";
  };

  programs.home-manager.enable = true;
}
