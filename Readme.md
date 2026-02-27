# Dotfiles Management with Chezmoi

This repository contains the configuration files and scripts managed by [Chezmoi](https://www.chezmoi.io/). It helps in maintaining and synchronizing dotfiles across multiple machines.

## Installation

To set up your environment using these dotfiles, follow the steps below:

1. **Install Chezmoi**:
    ```sh
    sh -c "$(curl -fsLS get.chezmoi.io)"
    echo PATH=$HOME/bin:$PATH >> ~/.bashrc
    source ~/.bashrc 
    ```

2. **Clone the Repository and Apply Dotfiles**:
    ```sh
    chezmoi init --apply julien-noblet ; chezmoi apply
    ```


## Structure

- `.chezmoidata/`: Contains data files used by Chezmoi templates.
- `dot_config/nvim/`: Neovim configuration files.
- `private_dot_ssh/`: SSH keys and configurations.
- `run_onchange_*`: Scripts that run on changes to specific files.

## Usage

- **Update Dotfiles**:
  ```sh
  chezmoi update
  ```

- **Add New Files**:
  ```sh
  chezmoi add <file>
  ```

- **Edit Configuration**:
  Edit the files directly in the repository and apply changes using:
  ```sh
  chezmoi apply
  ```

