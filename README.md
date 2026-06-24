# Dot Snowflakes _(dot-snowflakes)_

> Dotfiles and system configs that are unapologetically unique

[![GitHub last commit](https://img.shields.io/github/last-commit/sgillespie/dot-snowflakes)]()
[![Built with Nix](https://img.shields.io/badge/Built_With-Nix-5277C3.svg?logo=nixos&labelColor=73C3D5)](https://www.nixos.org/)
[![License: MIT](https://img.shields.io/github/license/sgillespie/dot-snowflakes)](LICENSE)

This project contains my home and host configurations. It is built as a Nix
[flake-parts](https://flake.parts) project, organized into the following directories:

 * `dotfiles/`: User-specific configuration files intended to be copied to $HOME
 * `home-configurations/`: [Home Manager](https://github.com/nix-community/home-manager)
   configurations
 * `hosts/`: Top-level configuration for each host
 * `etc/`: `/etc` configuration files for non-Nix hosts, tracked by [etckeeper](https://etckeeper.branchable.com)
 * `per-system`: Development tools for working in this project

In addition, there are [Just](https://just.systems) recipes for most tasks.

## Features

 * **Based on flake-parts**: Extensible, composable flake modules
 * **Multi-OS**: Targets a mixture of NixOS and Arch Linux hosts
 * **Lightweight configuration management**: Separate per-OS system and home configurations
   * NixOS: NixOS modules + Home Manager
   * Arch Linux: Pacman package lists + Etckeeper + Home Manager
 * **Task runner**: `just` recipes included for common operations

## Quickstart

In order to use this project, you will need:

 * [Nix](https://nixos.org/download/)
 * [direnv](https://direnv.net/) (optional)


If using direnv, approve and load the environment:

    direnv allow

Otherwise, enter the development shell:

    nix develop .

Initialize the `etc/` submodule:

    just etc-update

## Usage

To view available Just recipes, run the default recipe:

    just

    Available recipes:
        [home-manager]
        hm-apply             # applies home-manager configurations
        hm-build             # builds home-manager configurations

        [pacman]
        pacman-pkglist       # generates Arch Linux pacman package list
        pacman-pkglist-apply # installs/syncs packages in the Arch Linux pacman package list

        [gpg-agent]
        gpgagent-reload      # reloads the gpg-agent config
        gpgagent-updatetty   # refresh the gpg-agent pinentry startuptty

### Home Manager Configurations

To apply the Home Manager configuration, run the `hm-apply` recipe:

    just hm-apply

If this updates `gpg-agent.conf`, you might also want to reload gpg-agent:

    just gpgagent-reload

### Arch Linux Package Lists

After installing packages in [Arch Linux](https://archlinux.org) with `pacman`, be sure 
to update the package list:

    just pacman-pkglist

This will write all the installed packages to `pkglist.txt` `pkglist-foreign.txt`. Review
these before committing.

Install the packages in `pkglist.txt`:

    just pacman-pkglist-apply

Note this will only install the native packages. The foreign package list is only for
review.

## License

This project is licensed under the **MIT license**. See [LICENSE](LICENSE.md) for more
information.

## Acknowledgements

This project was either built on, or greatly inspired by the following awesome projects:

 * [Nix](https://nixos.org)
 * [Home Manager](https://github.com/nix-community/home-manager)
 * [Flake Parts](https://flake.parts)
 * [Arch Linux](https://archlinux.org)
 * [Just](https://just.systems)
 * [Jörg Thalheim's dotfiles](https://github.com/Mic92/dotfiles)
