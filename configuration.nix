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

   # Enable Android Debug Bridge
  programs.adb.enable = true;
	
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
    windowManager.i3.enable = true;
  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us"; variant = ""; }; # Enable CUPS to print documents.
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
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" ];
    packages = [
     pkgs.firefox-beta
     pkgs.chromium
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
     pkgs.loupe
     pkgs.kdenlive
     pkgs.gimp
     pkgs.swaybg
     pkgs.zip
     pkgs.unrar
     pkgs.tree
     pkgs.trash-cli
     pkgs.nautilus
     pkgs.yazi
     pkgs.android-tools
     pkgs.android-udev-rules
     unstable.android-studio
     pkgs.flutter
     pkgs.libpulseaudio
     pkgs.arandr
    pkgs.libnss-mysql


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
 


  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [

       i3status  
       i3lock    
       dmenu     

      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libxcb
        

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
        gnumake
        nss

        procps
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };


  # dyanmic linking
 programs.nix-ld = {
  enable = true;
  libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    glibc
    openssl
    util-linux
    xorg.libX11
    pkgs.libpulseaudio
    pkgs.libpng
    pkgs.libnss-mysql
    pkgs.nss
  ];
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
  services.openssh.enable = true;

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.11"; 
}
