{ inputs, config, pkgs, lib, ... }:
##############################################################################################################################
##############################################################################################################################
############                        DONT'T EDIT THIS FILE             ########################################################
##############################################################################################################################
##############################################################################################################################

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [ # Include the results of the hardware scan + GLF modules
      ./hardware-configuration.nix
      ./customConfig 

    ];

  glf.environment.type = "gnome";
  glf.environment.edition = "standard";

  glf.nvidia_config = {
    enable = true;
    laptop = true;
    # NVIDIA Corporation AD106M [GeForce RTX 4070 Max-Q / Mobile] (rev a1)
    nvidiaBusId = "PCI:1:0:0";
    # Advanced Micro Devices, Inc. [AMD/ATI] Phoenix1 (rev c2)
    amdgpuBusId = "PCI:5:0:0";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  #boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "victus"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Configure keymap in X11
  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.julien = {
    isNormalUser = true;
    description = "julien";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" "disk" "input" "render" "video" ];
  };

  
  system.stateVersion = "25.11"; # DO NOT TOUCH 
}
