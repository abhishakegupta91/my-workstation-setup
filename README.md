# My Workstation Setup

An Ansible playbook to automatically provision a new Ubuntu or Debian workstation with my preferred development tools, dotfiles, and configurations.

This repository automates the tedious process of setting up a new development machine. By running a single Ansible playbook, you can install all necessary software, configure the shell, set up Docker, and deploy personal dotfiles, all in one go. It's designed to be **idempotent** (safe to run multiple times) and work on both **Ubuntu** and **Debian**.

---

## 🚀 Quick Start: Usage

Follow these steps on a fresh, minimal installation of Ubuntu Desktop or Debian.

### 1. Install Prerequisites
The only package you need to install manually is `ansible` (to run the playbook). Git is typically pre-installed on most systems.

```bash
sudo apt update
sudo apt install ansible -y
```

### 2\. Clone This Repository

Clone this repo to your home directory and `cd` into it.

```bash
# Make sure to use your own username and repo name
git clone [https://github.com/YOUR-USERNAME/my-workstation-setup.git](https://github.com/YOUR-USERNAME/my-workstation-setup.git)
cd my-workstation-setup
```

### 3\. Run the Playbook

Execute the main Ansible playbook. It will prompt for your `sudo` password (`--ask-become-pass`) to install system-wide packages.

```bash
ansible-playbook playbook.yml --ask-become-pass
```

That's it\! The playbook will now run, installing and configuring everything. Grab a coffee, and when it's done, your new workstation will be ready.

-----

## 🛠️ What's Included?

This playbook will install and configure the following:

### Core & Shell

  * **Zsh**: A powerful, modern shell.
  * **Oh My Zsh**: A framework for managing Zsh configuration (installed natively with custom plugins).
  * **Zsh Plugins**: Includes `zsh-autosuggestions`, `zsh-syntax-highlighting`, and `you-should-use`.
  * **build-essential**: Essential C/C++ compilers and tools (`make`, `gcc`, etc.).
  * **Git**: Version control system.

### Terminal Utilities

  * **htop**: An interactive process viewer.
  * **tmux**: A terminal multiplexer (for persistent sessions).
  * **micro**: A modern and intuitive terminal-based text editor.
  * **curl** & **wget**: Utilities for downloading files.
  * **vim**: A powerful text editor.

### Development Environment

  * **Docker Engine**: The full Docker `docker-ce` package.
  * **Docker Compose**: The `docker compose` plugin.
  * **User added to `docker` group**: Allows running `docker` without `sudo`.

-----

## ⚙️ Dotfile Configuration

This playbook automatically manages your personal configuration files (dotfiles).

  * It copies all files from the `dotfiles/` directory in this repo to your home directory (`~/`).
  * **Existing files are backed up**: If you already have a `.zshrc`, it will be renamed to `.zshrc.BAK-TIMESTAMP` before being replaced.
  * The `playbook.yml` is pre-configured to copy:
      * `.zshrc`
      * `.gitconfig`
      * `.tmux.conf`

To add more dotfiles, simply add the file to the `dotfiles/` folder and list it in the `loop:` section of the "Copy dotfiles" task in `playbook.yml`.

-----

## ❗️ Important Notes

  * **⚠️ LOG OUT TO USE DOCKER**: After the playbook finishes, you **must log out and log back in** to your computer. This is required for the user group changes to take effect, allowing you to run `docker` commands without `sudo`.
  * **Default Shell**: The playbook automatically changes your user's default shell to `/usr/bin/zsh`. The change will be active the next time you open a terminal.
  * **Idempotency**: This playbook is designed to be idempotent. You can safely run it multiple times. It will check the state of the system and only make changes if something is missing or not configured correctly.
  * **OS Support**: This playbook is designed for `amd64` (64-bit Intel/AMD) systems and automatically detects whether it's on **Ubuntu** or **Debian** to install the correct Docker repositories.
  * **Version Pinning**: Docker packages are pinned to specific versions to ensure consistent installations across different environments.
  * **CI/CD Testing**: Includes GitHub Actions workflows for syntax checking and linting across multiple Ubuntu and Debian versions.

-----

## 🔧 Customization

### Modifying Dotfiles
Edit the files in the `dotfiles/` directory to customize your shell environment:
- `.zshrc`: Cross-platform Zsh configuration with Oh My Zsh, plugins, aliases, and environment variables
- `.gitconfig`: Git user settings and preferences  
- `.tmux.conf`: Tmux terminal multiplexer settings

**Note**: Replace the placeholder values in `.gitconfig` with your actual name and email.

#### Zsh Configuration Features
- **Cross-platform compatibility**: Automatically detects macOS vs Linux and adjusts paths accordingly
- **Enhanced plugins**: Autosuggestions, syntax highlighting, and command recommendations
- **Optimized history**: 100,000 history entries with smart deduplication
- **Development aliases**: Quick shortcuts for Git, Docker, and common commands
- **Optional tool support**: NVM, Conda, and local environment configurations load gracefully if present

### Adding New Packages
To install additional packages, add them to the appropriate task in `playbook.yml`:
- System packages: Add to the "Install Prerequisite Packages" or "Install Core CLI Tools" tasks
- Docker packages: Add to the "Install Docker Engine" task (consider version pinning)

### Adding Zsh Plugins
To add new Oh My Zsh plugins:
1. Add the plugin installation to the "Install Oh My Zsh plugins" task in `playbook.yml`
2. Add the plugin name to the `plugins=` array in `dotfiles/.zshrc`

Example for adding a new plugin:
```yaml
# In playbook.yml
- name: Install new-zsh-plugin
  shell: |
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/new-zsh-plugin" ]; then
      git clone https://github.com/user/new-zsh-plugin "$HOME/.oh-my-zsh/custom/plugins/new-zsh-plugin"
    fi
```

```bash
# In .zshrc
plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use new-zsh-plugin)
```

### Testing Changes
The repository includes automated testing via GitHub Actions. You can also test locally:
```bash
# Syntax check
ansible-playbook playbook.yml --syntax-check

# Dry run (check mode)
ansible-playbook playbook.yml --check --ask-become-pass
```

<!-- end list -->