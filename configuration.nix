# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  services.flatpak.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Program
  programs.starship = {
    enable = true;
  };
	
  fonts.packages = [
    pkgs.nerdfonts
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-emoji
    pkgs.liberation_ttf
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.mplus-outline-fonts.githubRelease
    pkgs.dina-font
    pkgs.proggyfonts
    pkgs.jetbrains-mono
  ];
   programs.zsh.enable = true;


  # Enable the X11 windowing system.
  programs.hyprland.enable = true;


  services.xserver = {
    enable = true;
    displayManager = {
      # defaultSession = "sway";
      # autoLogin = true;
        gdm = {
	  enable = true;
	  wayland = true;
	};
    };
  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.crux = {
    isNormalUser = true;
    description = "crux";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = [
     pkgs.firefox-beta
     pkgs.networkmanagerapplet
     pkgs.font-awesome
     pkgs.nerdfonts
     pkgs.pavucontrol
     pkgs.blueman
     pkgs.bluez
     pkgs.bluez-tools
     pkgs.lazygit
     pkgs.cargo 
     pkgs.bat 
     pkgs.nodejs
     pkgs.pamixer
     pkgs.discord
     pkgs.docker
     pkgs.silicon
     pkgs.starship
     pkgs.btop
     pkgs.neofetch
     pkgs.ngrok
     pkgs.extundelete
     pkgs.microsoft-edge
     pkgs.obs-studio
     pkgs.yarn
     pkgs.pnpm 
     pkgs.bun
     pkgs.nemo
     pkgs.grim
     pkgs.slurp
     pkgs.slack
     pkgs.clang-tools
     pkgs.lsd


      unstable.zed-editor
      unstable.zoxide
      unstable.postman
      unstable.brave
      unstable.nodePackages.npm
      unstable.go
      unstable.gopls
      unstable.glab
      unstable.vscode
      unstable.alacritty
      unstable.neovim
      unstable.helix
    ];
  };

  nix.settings.trusted-users = [
    "root"
    "crux"
  ];
  users.defaultUserShell = pkgs.zsh;
 


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
# List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    	vim
        git
        clang
        ripgrep
        wl-clipboard
        xclip
        dunst
        libnotify       
        waybar
        rofi
        polybar
        brightnessctl
        wofi
        rsyslog
        openssl.dev
        nginx
        alacritty
        kitty
        zellij
        tmux
        zsh
        curl 
        wget
        jq
        python3
 # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
