{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.user;
  defaultIconFileName = "profile.png";
  defaultIcon = pkgs.stdenvNoCC.mkDerivation {
    name = "default-icon";
    src = ./. + "/${defaultIconFileName}";

    dontUnpack = true;

    installPhase = ''
      cp $src $out
    '';

    passthru = {
      fileName = defaultIconFileName;
    };
  };
  propagatedIcon =
    pkgs.runCommandNoCC "propagated-icon"
      {
        passthru = {
          fileName = cfg.icon.fileName;
        };
      }
      ''
        local target="$out/share/nixgehtmehr-share/user/${cfg.name}"
        mkdir -p "$target"

        cp ${cfg.icon} "$target/${cfg.icon.fileName}"
      '';
in
{
  options.${namespace}.user = with types; {
    name = mkOpt str "denk" "The name to use for the user account.";
    fullName = mkOpt str "Denis Keksel" "The full name of the user.";
    email = mkOpt str "kexsel@yandex.ru" "The email of the user.";
    initialPassword =
      mkOpt str "Ppfwq"
        "The initial password to use when the user is first created.";
    icon = mkOpt (nullOr package) defaultIcon "The profile picture to use for the user.";
    prompt-init = mkBoolOpt true "Whether or not to show an initial message when opening a new shell.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { } (mdDoc "Extra options passed to `users.users.<name>`.");
    home.file = mkOpt types.attrs { } "A set of files to be managed by home-manager `home.file`";
    home.configFile = mkOpt attrs { } "An set of files to be managed by home-manager xdg.configFile";
    home.extraOptions = mkOpt attrs { } "Extra options passed to home-manager";
  };

  config = {
    environment.systemPackages = with pkgs; [
      cowsay
      fortune
      lolcat
      propagatedIcon
    ];

    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      histFile = "$XDG_CACHE_HOME/zsh.history";
    };


    users.users.${cfg.name} = {
      isNormalUser = true;

      inherit (cfg) name initialPassword;

      home = "/home/${cfg.name}";
      group = "users";
      shell = pkgs.zsh;
      uid = 1000;

      home-manager = {
        useGlobalPkgs = true;
        backupFileExtension = "backup";
      };

      snowfallorg.users.${cfg.name} = {
        home.config = {
          home.stateVersion = config.system.stateVersion;
          home.file = mkAliasDefinitions options.${namespace}.user.home.file;
          xdg.enable = true;
          xdg.configFile = mkAliasDefinitions options.${namespace}.user.home.configFile;
        } // cfg.home.extraOptions;
      };

    };
  };
}
