{
  lib,
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  environment.systemPackages = [
  # Add your stable apps here (exemple: pkgs.btop)

  pkgs.vim

  #pkgs.prusa-slicer
  #pkgs.google-chrome
  #pkgs.freecad
  #pkgs.keepass
 
  pkgs.sbctl # Secureboot
  pkgs.git
  #pkgs.vscode
  #pkgs.rclone
  #pkgs.vlc
  pkgs.unrar
  pkgs.google-drive-ocamlfuse
  #pkgs.age
  #pkgs.chezmoi
  # Add your unstable apps here (exemple: pkgs-unstable.btop)

  pkgs-unstable.calibre

  ];
  glf.gaming.enable = lib.mkForce true;

 # --- OPTIONS DE DÉSACTIVATION (décommenter pour désactiver) / DISABLE OPTIONS (uncomment to disable) ---
# Après modification, appliquer avec : `glf-update` / After editing, apply with: `glf-update`

# Désactiver Firefox / Disable Firefox
  # glf.firefox.enable = lib.mkForce false;

# Désactiver le pack gaming (manettes, Steam, Lutris, Faugus, Heroic, Oversteer/Wine, Piper, etc.) / Disable gaming pack (controllers, Steam, Lutris, Faugus, Heroic, Oversteer/Wine, Piper, etc.)
  # glf.gaming.enable = lib.mkForce false;

# Désactiver le pilote NVIDIA (utile en cas de passage vers une carte AMD) / Disable NVIDIA driver (useful when switching to an AMD GPU)
  # glf.nvidia.enable = lib.mkForce false;

# Désactiver la compatibilité et les outils d'impression / Disable printing compatibility and tools
  # glf.printing.enable = lib.mkForce false;

# ⚠️ Désactiver les mises à jour automatiques (attention : risque pour la sécurité) / ⚠️ Disable automatic updates (warning: security risk)
  # glf.update.enable = lib.mkForce false;


  # Add your custom configuration here ↓
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
 };

  # Optional: Add your user to the "docker" group to run docker without sudo
  users.users.julien.extraGroups = [ "docker" ];

nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };
services.beesd.filesystems = {
    root = {
      spec = "UUID=356d68fb-c4a2-4bc7-8426-37696e8683bb";
      hashTableSizeMB = 512;
      verbosity = "crit";
      extraOptions = [ "--loadavg-target" "2.0" ];
    };
  };
}
