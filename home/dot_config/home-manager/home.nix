{ config, pkgs, lib, ... }:

{
  imports = [
    ./ghostty.nix
    ./ollama.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "julien";
  home.homeDirectory = "/home/julien";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  #home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  #];
  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.jetbrains-mono

    # Shell tools
    zsh
    tmux
    starship
    #zellij
    direnv
    fzf
    vhs
    sops
    fastfetch
    oath-toolkit
    #mariadb.client
    slidev-cli
    gum
    neovim
    age
    chezmoi
    git
    direnv
    lsd
    bat
    prettyping
    rclone

    # DevOps
    kubectl
    kubecolor
    kubectx
    kubent
    k9s
    #hubble
    #fluxcd
    #scaleway-cli
    goaccess
    k6
    clusterctl
    kubernetes-helm

    # Network tools
    nmap
    ipcalc
    fping
    #openvpn
    testssl

    # System utilities
    ncdu
    fastfetch
    tree

    # Search and text processing
    ripgrep
    ack
    jq
    yq
    silver-searcher

    # Development tools
    git-crypt
    pre-commit
    #ollama-cuda
    #automake
    #autoconf
    

    # Programming languages
    #jdk21
    #python3
    #python3Packages.pip
    #yarn
    #ruby
    #go
    #php83

    # Container tools
    #podman
    #podman-compose
    #buildah

    # Cloud and infrastructure tools
    # TODO: use direnv to load these tools only in relevant projects
    #opentofu
    #terraform
    #terraform-ls
    #terragrunt
    #packer
    #kubernetes-helm
    #tfsec
    #terraform-docs

    # Security tools
    #pass

    # Virtualization
    #virt-manager
    #vagrant

    # Multimedia
    vlc
    #deezer-enhanced
    calibre


    # Terminal emulator
    #kitty

    # Latex
    #texlive.combined.scheme-full
    #texlivePackages.latexmk

    # Task management
    taskwarrior2
    #btop

    #Nix
    #colmena # peut être a basculer dans direnv ?
    

    # OpenStack client
    #python3Packages.python-openstackclient

    # Other utilities
    #cups
    #cmake
    #pkg-config
    #python3Packages.virtualenv
    #firefox
    #chromium
    
    google-chrome
    #hugo
    #obsidian
    prusa-slicer
    keepass
    freecad
    vscode

  ];
  
  nixpkgs.config = {
    cudaCapabilities = [ "8.9" ];
    cudaForwardCompat = false;
    allowUnfreePredicate = pkg:
      let
        name = lib.getName pkg;
        licenses = lib.toList (pkg.meta.license or [ ]);
        isCudaEula = builtins.any (license: (license.shortName or "") == "CUDA EULA") licenses;
      in
      builtins.elem name [
        "google-chrome"
        "vscode"
      ] || isCudaEula;
  };
  

  # Direnv integration
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "lsd";
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "lsd";
    };
  };


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/julien/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
