# My Workstation Setup

An Ansible playbook collection to automatically provision Ubuntu or Debian systems with preferred development tools, dotfiles, and configurations.

This repository contains three playbooks:
- **`playbook.yml`**: For desktop/workstation setup
- **`home-server.yml`**: For home server deployment
- **`minimal-ec2-ubuntu-server.yml`**: For minimal EC2 Ubuntu server/dev setup

All playbooks are designed to be **idempotent** (safe to run multiple times) and work on both **Ubuntu** and **Debian**.

## 📁 Repository Structure

```
my-workstation-setup/
├── playbook.yml                   # Desktop/Workstation setup
├── home-server.yml                # Home server setup
├── minimal-ec2-ubuntu-server.yml  # Minimal EC2 Ubuntu setup
├── config/                        # Configuration files
│   ├── nginx-default.conf
│   └── project-template.conf
├── scripts/                       # Executable scripts
│   └── server-info.sh
├── docs/                          # Documentation
│   └── project-setup.md
├── dotfiles/                      # User configuration files
│   ├── .zshrc
│   ├── .gitconfig
│   └── .tmux.conf
├── .github/workflows/             # CI/CD testing
│   └── test.yml
└── .ansible-lint                  # Linting configuration
```

---

## 🚀 Quick Start

Follow these steps on a fresh, minimal installation of Ubuntu Desktop or Debian.

### 1. Install Prerequisites

The only package you need to install manually is `ansible`. Git is typically pre-installed.

```bash
sudo apt update
sudo apt install ansible -y
```

### 2. Clone This Repository

```bash
git clone git@github.com:your-username/my-workstation-setup.git
cd my-workstation-setup
```

### 3. Run the Playbook

**For Desktop/Workstation:**
```bash
ansible-playbook playbook.yml --ask-become-pass
```

**For Home Server:**
```bash
ansible-playbook home-server.yml --ask-become-pass
```

> You will be prompted to enter a Portainer admin password before the playbook runs. This is never stored in the repository.

**For Minimal EC2:**
```bash
ansible-playbook minimal-ec2-ubuntu-server.yml --ask-become-pass
```

That's it. Grab a coffee — when it's done, your system will be ready.

---

## 🛠️ What's Included?

### 🖥️ Desktop/Workstation Playbook (`playbook.yml`)

#### Core & Shell

- **Zsh**: A powerful, modern shell
- **Oh My Zsh**: Installed via `git clone` (no piped install scripts)
- **Zsh Plugins**: `zsh-autosuggestions`, `zsh-syntax-highlighting`, `you-should-use`
- **build-essential**: C/C++ compilers and tools (`make`, `gcc`, etc.)
- **Git**: Version control system

#### Terminal Utilities

- **htop**: Interactive process viewer
- **tmux**: Terminal multiplexer for persistent sessions
- **micro**: Modern terminal-based text editor
- **curl** & **wget**: File download utilities
- **vim**: Powerful text editor

#### Development Environment

- **Docker Engine**: Full `docker-ce` package from the official repository
- **Docker Compose**: `docker compose` plugin (modern, integrated)
- **User added to `docker` group**: Run Docker without `sudo`

---

### 🏠 Home Server Playbook (`home-server.yml`)

#### Web Server & Development

- **Nginx**: High-performance web server with reverse proxy capabilities
- **Node.js & npm**: Node.js 18.x via the NodeSource apt repository (GPG-verified, no piped scripts)
- **Docker**: Container platform with official CE packages
- **Portainer**: Web-based Docker management UI at `https://your-server-ip:9443`

#### Networking & Security

- **UFW Firewall**: Essential ports open — SSH (22), HTTP (80), HTTPS (443), WireGuard (51820)
- **WireGuard**: Modern VPN for secure remote access
- **DNS Utilities**: `dnsutils` for DNS troubleshooting
- **Network Analysis**: `net-tools`, `nmap` for network monitoring

#### System Monitoring & Management

- **Process Monitoring**: `htop`, `iotop`, `nethogs` for real-time system monitoring
- **Log Management**: `logrotate` for automated log rotation
- **Process Control**: `supervisor` for managing background processes
- **Backup Tools**: `rsync` for file synchronisation and backups

#### Server Features

- **Auto-start Services**: All essential services enabled at boot
- **Security Hardened**: Firewall enabled with minimal open ports
- **Portainer Password Prompt**: Admin password is asked at run time — never hardcoded or committed
- **Information Script**: `server-info.sh` shows quick system status and access URLs
- **Flexible Docker**: Portainer lets you deploy databases, Redis, and any services per project

---

### ☁️ Minimal EC2 Ubuntu Server Playbook (`minimal-ec2-ubuntu-server.yml`)

Intended for **fresh Ubuntu EC2 instances** where you want a lean environment with an SSH key ready for GitHub.

- **Core tools**: `git`, `vim`, `nginx`
- **Node.js 18.x & npm**: Installed via GPG-verified NodeSource apt repository
- **Docker**: `docker.io` + `docker-compose-plugin` (modern plugin, not legacy standalone)
- **User added to `docker` group**: Run Docker without `sudo` (log out/in required)
- **SSH key for GitHub**:
  - Ensures `~/.ssh` exists with correct permissions
  - Generates an Ed25519 keypair at `~/.ssh/id_ed25519` (only if not already present)
  - Prints the public key at the end so you can copy it straight to GitHub

```bash
ansible-playbook minimal-ec2-ubuntu-server.yml --ask-become-pass
```

---

## ⚙️ Configuration Architecture

### 📁 File Organization

#### **`config/`** — Configuration Files
- `nginx-default.conf`: System Nginx configuration with reverse proxy
- `project-template.conf`: Template for project-specific Nginx configs

#### **`scripts/`** — Executable Scripts
- `server-info.sh`: System status and access URL display

#### **`docs/`** — Documentation
- `project-setup.md`: Complete guide for setting up projects with hybrid Nginx + Docker

#### **`dotfiles/`** — User Configuration
- `.zshrc`: Cross-platform Zsh configuration with Oh My Zsh and plugins
- `.gitconfig`: Git user settings and preferences
- `.tmux.conf`: Tmux terminal multiplexer settings

### 🔄 How It Works

1. **Ansible Playbooks**: Handle package installation, service management, and file copying
2. **Configuration Files**: Stored in `config/` in their native formats for easy editing
3. **Scripts**: Can be run independently for system management
4. **Documentation**: Comprehensive guides in `docs/`

---

## ❗ Important Notes

### For Desktop/Workstation Setup
- **Log out after setup**: Required for Docker group changes to take effect
- **Default Shell**: Your default shell is changed to `/usr/bin/zsh` — active on next terminal open

### For Home Server Setup
- **Log out after setup**: Required for Docker group changes to take effect
- **Portainer password**: You will be prompted to set this when running the playbook — it is never stored in the repo
- **Portainer Access**: `https://your-server-ip:9443`
- **Firewall**: UFW enabled with SSH (22), HTTP (80), HTTPS (443), WireGuard (51820)
- **WireGuard**: Requires additional config after setup (`wg-quick up wg0`)
- **Web Root**: Place websites in `/var/www/html/` for Nginx to serve them

### General Notes
- **Idempotency**: All playbooks are safe to run multiple times
- **OS Support**: Designed for `amd64` systems running **Ubuntu** or **Debian**
- **Node.js**: Installed from the NodeSource apt repository using a verified GPG key — no piped shell scripts
- **Oh My Zsh**: Installed via `git clone` — no piped shell scripts
- **CI/CD Testing**: GitHub Actions runs syntax checks and linting across Ubuntu 20.04/22.04 and Debian 11/12

---

## 🔧 Customization

### Modifying Configurations

Edit files in the `config/` directory:
- `config/nginx-default.conf`: Modify system Nginx settings
- `config/project-template.conf`: Update project Nginx template

### User Dotfiles

Edit files in `dotfiles/` to customise your shell environment:
- `.zshrc`: Cross-platform Zsh with Oh My Zsh, plugins, aliases, and env vars
- `.gitconfig`: Replace the placeholder name and email with your own
- `.tmux.conf`: Tmux settings

#### Zsh Configuration Features
- Cross-platform: detects macOS vs Linux and adjusts PATH accordingly
- 100,000 history entries with smart deduplication
- Autosuggestions, syntax highlighting, and command recommendations
- Optional NVM, Conda, and local env configs load gracefully if present

### Adding New Packages

Add packages to the appropriate task in the relevant playbook:
- System packages: add to the "Install Prerequisite Packages" or "Install Core CLI Tools" task
- Docker services: add a `docker_container` task alongside Portainer

### Adding Zsh Plugins

1. Add the `git` clone task to `playbook.yml`:
```yaml
- name: Install new-zsh-plugin
  become: no
  ansible.builtin.git:
    repo: https://github.com/user/new-zsh-plugin.git
    dest: "/home/{{ username }}/.oh-my-zsh/custom/plugins/new-zsh-plugin"
    depth: 1
```

2. Add the plugin name to `dotfiles/.zshrc`:
```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use new-zsh-plugin)
```

### Testing Changes

```bash
# Syntax check
ansible-playbook playbook.yml --syntax-check

# Dry run
ansible-playbook playbook.yml --check --ask-become-pass
```

---

## 🗺️ Roadmap

Planned additions to the home server playbook:

| Feature | Purpose |
|---|---|
| **Tailscale** | Secure remote access from anywhere — SSH into your server without port forwarding |
| **Uptime Kuma** | Self-hosted uptime monitoring with alerts (Telegram, Slack, email) |
| **Netdata** | Real-time system metrics dashboard |

Each will be added as a separate PR.
