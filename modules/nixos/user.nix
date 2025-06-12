{ user-name, user-info, ... }: {
  users.groups.nix-editor = {};
  system.tmpfiles.rules = [
    "d /etc/nixos 0775 root nix-editor _ _"
  ];
  users.users.${user-name} = {
    isNormalUser = true;
    description = user-info;
    extraGroups = [ "networkmanager" "wheel" "nix-editor"];
  };
}
