* Copy and paste `/etc/nixos/hardware-configuration.nix` at `./nixos/hardware-configuration.nix`
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


* Clean
```
nix-env --list-generations

nix-collect-garbage  --delete-old

nix-collect-garbage  --delete-generations 1 2 3

# recommeneded to sometimes run as sudo to collect additional garbage
sudo nix-collect-garbage -d

# As a separation of concerns - you will need to run this command to clean out boot
sudo /run/current-system/bin/switch-to-configuration boot
``