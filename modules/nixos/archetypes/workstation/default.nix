{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib
with lib.${namespace};
let 
  cfg = config.${namespace}.arechetypes.workstation;
in
{
   options.${namespace}.arcetypes.workstation = with types; {
     enable = mkBoolOpt false "Whether or not to enable the workstation archetype.";
   };

   config = mkIf cfg.enable {
     nixgehtmehr = {
        suites = {
         common = enabled
        };
     };
   };
}
