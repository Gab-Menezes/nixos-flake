* Copy and paste sops key at `/home/nixos/.config/sops/age/keys.txt`
    * IDK exactly if `/run/secrets.d/age-keys.txt` needs to be managed manually
* `sudo nixos-rebuild switch --flake .#nixos`
    * Rebuilds nix system and make it available
* `sudo nixos-rebuild boot --flake .#nixos`
    * Rebuilds nix system and make it available on the next boot
* `sudo nix flake update`
    * Update the flake dependencies
* `sudo nix-channel --update`
    * Update all channels
* `sudo nix-collect-garnage --delete-older-than <n>d`
    * Delete 
* `nix-shell` or `nix shell`
    * Creates a temporary shell with this pkgs
    * `-p <pkgs>` or `nixpkgs#<pkgs>`
    * `--pure`
    * `--run <cmd>` or `-c <cmd>`
* `systemctl --user <enable|start> auto-fix-vscode-server.service`
    * Fixes vscode-remote
* `nix registry add self /home/nixos/dev/nixos-flake`
    * Add this folder as a registry for templates