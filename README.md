# My Workstation Setup

An Ansible playbook collection to automatically provision Ubuntu or Debian systems with preferred development tools, dotfiles, and configurations.

This repository contains two playbooks:
- **`playbook.yml`**: For desktop/workstation setup
- **`server.yml`**: For home server deployment

Both playbooks are designed to be **idempotent** (safe to run multiple times) and work on both **Ubuntu** and **Debian**.

## 📁 Repository Structure

```
my-workstation-setup/
├── playbook.yml          # Desktop/Workstation setup
├── server.yml             # Home server setup  
├── config/                # Configuration files
│   ├── nginx-default.conf
│   └── project-template.conf
├── scripts/               # Executable scripts
│   └── server-info.sh
├── docs/                  # Documentation
│   └── project-setup.md
├── dotfiles/              # User configuration files
│   ├── .zshrc
│   ├── .gitconfig
│   └── .tmux.conf
├── .github/workflows/     # CI/CD testing
│   └── test.yml
└── .ansible-lint          # Linting configuration
```

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
git clone [https://github.com/codams-org/my-workstation-setup.git](https://github.com/codams-org/my-workstation-setup.git)
cd my-workstation-setup
```

### 3\. Run the Playbook

**For Desktop/Workstation:**
```bash
ansible-playbook playbook.yml --ask-become-pass
```

**For Home Server:**
```bash
ansible-playbook server.yml --ask-become-pass
```

That's it\! The playbook will now run, installing and configuring everything. Grab a coffee, and when it's done, your system will be ready.

-----

## 🛠️ What's Included?

### 🖥️ Desktop/Workstation Playbook (`playbook.yml`)

This playbook installs and configures the following for development environments:

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

### 🏠 Home Server Playbook (`server.yml`)

This playbook configures a complete home server environment for web hosting and development:

### Web Server & Development

  * **Nginx**: High-performance web server with reverse proxy capabilities.
  * **Node.js & npm**: Latest Node.js 18.x for JavaScript applications.
  * **Docker**: Container platform with version-pinned packages.
  * **Portainer**: Web-based Docker management interface (HTTPS:9443) for deploying databases and services as needed.

### Networking & Security

  * **UFW Firewall**: Simplified firewall management with essential ports open.
  * **WireGuard**: Modern VPN for secure remote access.
  * **DNS Utilities**: `dnsutils` for DNS troubleshooting and management.
  * **Network Analysis**: `net-tools` and `nmap` for network monitoring and discovery.

### System Monitoring & Management

  * **Process Monitoring**: `htop`, `iotop`, `nethogs` for real-time system monitoring.
  * **Log Management**: `logrotate` for automated log file rotation.
  * **Process Control**: `supervisor` for managing background processes.
  * **Backup Tools**: `rsync` for file synchronization and backups.
  * **System Utilities**: `curl`, `wget` for web requests and file downloads.

### Server Features

  * **Auto-start Services**: All essential services enabled and started automatically.
  * **Security Hardened**: Firewall enabled with minimal open ports.
  * **Information Script**: `server-info.sh` provides quick system status and access URLs.
  * **Flexible Docker**: Portainer allows deploying databases, Redis, and any services as needed per project.
  * **Clean Architecture**: Configuration files, scripts, and documentation organized in separate directories.

-----

## ⚙️ Configuration Architecture

### 📁 File Organization

This repository follows Ansible best practices with clean separation of concerns:

#### **`config/`** - Configuration Files
- `nginx-default.conf`: System Nginx configuration with reverse proxy
- `project-template.conf`: Template for project-specific Nginx configurations

#### **`scripts/`** - Executable Scripts  
- `server-info.sh`: System status and information display script

#### **`docs/`** - Documentation
- `project-setup.md`: Complete guide for setting up projects with hybrid Nginx + Docker

#### **`dotfiles/`** - User Configuration
- `.zshrc`: Cross-platform Zsh configuration with Oh My Zsh and plugins
- `.gitconfig`: Git user settings and preferences
- `.tmux.conf`: Tmux terminal multiplexer settings

### 🔄 How It Works

1. **Ansible Playbooks**: Handle package installation, service management, and file copying
2. **Configuration Files**: Stored separately in their native formats for easy editing
3. **Scripts**: Executable files that can be run independently for system management
4. **Documentation**: Comprehensive guides for setup and customization

This approach makes the repository:
- ✅ **Maintainable**: Easy to modify configurations without Ansible knowledge
- ✅ **Readable**: Clear file organization with logical separation
- ✅ **Reusable**: Components can be used in other projects
- ✅ **Version-friendly**: Individual files can be tracked and modified separately

-----

## ❗️ Important Notes

### For Desktop/Workstation Setup
  * **⚠️ LOG OUT TO USE DOCKER**: After the playbook finishes, you **must log out and log back in** to your computer. This is required for the user group changes to take effect, allowing you to run `docker` commands without `sudo`.
  * **Default Shell**: The playbook automatically changes your user's default shell to `/usr/bin/zsh`. The change will be active the next time you open a terminal.

### For Home Server Setup
  * **⚠️ LOG OUT TO USE DOCKER**: After the playbook finishes, you **must log out and log back in** to use Docker commands without `sudo`.
  * **Portainer Access**: Access Portainer web UI at `https://your-server-ip:9443` after setup.
  * **Firewall**: UFW is enabled with SSH (22), HTTP (80), HTTPS (443), and WireGuard (51820) ports open.
  * **WireGuard**: Requires additional configuration after setup (`wg-quick up wg0`).
  * **Web Root**: Place your websites in `/var/www/html/` for Nginx to serve them.

### General Notes
  * **Idempotency**: Both playbooks are designed to be idempotent. You can safely run them multiple times.
  * **OS Support**: Designed for `amd64` (64-bit Intel/AMD) systems running **Ubuntu** or **Debian**.
  * **Docker Installation**: Installs latest available Docker version from official repository.
  * **CI/CD Testing**: Includes GitHub Actions workflows for syntax checking and linting.
  * **Locale Configuration**: Playbooks automatically configure UTF-8 locale to prevent encoding issues.

-----

## 🔧 Customization

### Modifying Configurations

#### **System Configurations**
Edit files in the `config/` directory:
- `config/nginx-default.conf`: Modify system Nginx settings
- `config/project-template.conf`: Update project template

#### **Scripts**
Modify files in the `scripts/` directory:
- `scripts/server-info.sh`: Customize system information display

#### **Documentation** 
Update guides in the `docs/` directory:
- `docs/project-setup.md`: Modify project setup instructions

#### **User Dotfiles**
Edit files in the `dotfiles/` directory to customize your shell environment:
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

### Adding New Components

#### **New Configuration Files**
1. Add your config file to `config/` directory
2. Update `server.yml` or `playbook.yml` to copy it:
```yaml
- name: Copy additional configuration
  ansible.builtin.copy:
    src: config/your-config.conf
    dest: /etc/your-service/your-config.conf
    mode: '0644'
```

#### **New Scripts**
1. Add your script to `scripts/` directory
2. Update playbook to copy with executable permissions:
```yaml
- name: Copy custom script
  ansible.builtin.copy:
    src: scripts/your-script.sh
    dest: "/usr/local/bin/your-script.sh"
    mode: '0755'
```

#### **New Packages**
To install additional packages, add them to the appropriate task in playbooks:
- System packages: Add to "Install Prerequisite Packages" or "Install Core CLI Tools" tasks
- Docker packages: Add to "Install Docker Engine" task (consider version pinning)

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