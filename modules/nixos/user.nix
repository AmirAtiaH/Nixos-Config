{ user-name, user-info, ... }: {
  users.users.${user-name} = {
    isNormalUser = true;
    description = user-info;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}