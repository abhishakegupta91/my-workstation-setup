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

Follow these steps on a fresh, minimal installation of Ubuntu or Debian.

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
sudo ansible-playbook home-server.yml
```

> Run with `sudo` directly — using `--ask-become-pass` alongside `vars_prompt` (the Portainer password) causes a sudo timeout on local connections. Running as `sudo` avoids the conflict. You will still be prompted to set the Portainer admin password, which is never stored in the repository.

**For Minimal EC2:**
```bash
ansible-playbook minimal-ec2-ubuntu-server.yml --ask-become-pass
```

That's it. Grab a coffee — when it's done, your system will be ready.

---

## 🛠️ What's Included?

### 🖥️ Desktop/Workstation Playbook (`playbook.yml`)

#### Core & Shell

- **[Zsh](https://www.zsh.org/)**: A powerful, modern shell
- **[Oh My Zsh](https://ohmyz.sh/)**: Installed via `git clone` (no piped install scripts)
- **Zsh Plugins**: [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), [you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use)
- **build-essential**: C/C++ compilers and tools (`make`, `gcc`, etc.)
- **Git**: Version control system

#### Terminal Utilities

- **[htop](https://htop.dev/)**: Interactive process viewer
- **[tmux](https://github.com/tmux/tmux)**: Terminal multiplexer for persistent sessions
- **[micro](https://micro-editor.github.io/)**: Modern terminal-based text editor
- **curl** & **wget**: File download utilities
- **vim**: Powerful text editor

#### Development Environment

- **[Docker Engine](https://docs.docker.com/engine/)**: Full `docker-ce` package from the official repository
- **Docker Compose**: `docker compose` plugin (modern, integrated)
- **User added to `docker` group**: Run Docker without `sudo`

---

### 🏠 Home Server Playbook (`home-server.yml`)

#### Prerequisites

Before running this playbook, make sure you have:

- **[Tailscale account](https://tailscale.com/)** (free) — required to authenticate the device after install. Sign up before running the playbook.
- **Docker CE repository** added to apt — the playbook installs `docker-ce` from the official Docker repo, not `docker.io`. If it's a fresh machine this is handled automatically.

#### Web Server & Development

- **[Nginx](https://nginx.org/)**: High-performance web server with reverse proxy capabilities
- **[Node.js](https://nodejs.org/) 18.x & npm**: Installed via GPG-verified [NodeSource](https://github.com/nodesource/distributions) apt repository
- **[Docker CE](https://docs.docker.com/engine/install/ubuntu/)**: Container platform with official CE packages
- **[Portainer](https://www.portainer.io/)**: Web-based Docker management UI

  | Access | URL |
  |---|---|
  | Portainer HTTPS | `https://your-server-ip:9443` |

  > On first visit, create your admin account using the password you set when the playbook ran.

#### Monitoring & Observability

- **[Uptime Kuma](https://github.com/louislam/uptime-kuma)**: Self-hosted uptime monitoring with alerts (Telegram, Slack, email, and more)

  | Access | URL |
  |---|---|
  | Uptime Kuma | `http://your-server-ip:3001` |

  > On first visit, create an admin account. Then add monitors for your services — HTTP, TCP, DNS, ping, etc.

  **Prerequisites**: Docker must be installed and running (handled by the playbook). No external account needed.

- **[Netdata](https://www.netdata.cloud/)**: Real-time system metrics dashboard — CPU, memory, disk, network, and more

  | Access | URL |
  |---|---|
  | Netdata | `http://your-server-ip:19999` |

  > No login required by default. Accessible on your local network immediately after install. Installed from the [official Netdata repository](https://packagecloud.io/netdata/netdata) for up-to-date packages.

  **Prerequisites**: None — installs directly via apt.

#### Networking & Security

- **[UFW Firewall](https://help.ubuntu.com/community/UFW)**: Ports open after setup:

  | Port | Service |
  |---|---|
  | 22 | SSH |
  | 80 | HTTP |
  | 443 | HTTPS |
  | 3001 | Uptime Kuma |
  | 9443 | Portainer |
  | 19999 | Netdata |
  | 51820 | WireGuard |

- **[Tailscale](https://tailscale.com/)**: Zero-config mesh VPN — SSH into your server from anywhere without touching router port forwarding

  **Prerequisites**: [Create a free Tailscale account](https://login.tailscale.com/start) before running the playbook.

  **After the playbook runs**, authenticate the device:
  ```bash
  sudo tailscale up
  ```
  Then approve the device at [https://login.tailscale.com](https://login.tailscale.com). Once approved, you can SSH from anywhere using the Tailscale IP or device name — no port forwarding needed.

- **[WireGuard](https://www.wireguard.com/)**: Modern VPN — requires manual configuration after install (`wg-quick up wg0`)

- **DNS Utilities**: `dnsutils` for DNS troubleshooting
- **Network Analysis**: `net-tools`, `nmap`

#### System Monitoring & Management

- **Process Monitoring**: `htop`, `iotop`, `nethogs` for real-time system monitoring
- **Log Management**: `logrotate` for automated log rotation
- **Process Control**: `supervisor` for managing background processes
- **Backup Tools**: `rsync` for file synchronisation and backups

---

### ☁️ Minimal EC2 Ubuntu Server Playbook (`minimal-ec2-ubuntu-server.yml`)

Intended for **fresh Ubuntu EC2 instances** where you want a lean environment with an SSH key ready for GitHub.

- **Core tools**: `git`, `vim`, `nginx`
- **[Node.js](https://nodejs.org/) 18.x & npm**: Installed via GPG-verified [NodeSource](https://github.com/nodesource/distributions) apt repository
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
- `.gitconfig`: Git user settings and preferences (replace placeholder name and email)
- `.tmux.conf`: Tmux terminal multiplexer settings

---

## ❗ Important Notes

### For Desktop/Workstation Setup
- **Log out after setup**: Required for Docker group changes to take effect
- **Default Shell**: Your default shell is changed to `/usr/bin/zsh` — active on next terminal open

### For Home Server Setup
- **Log out after setup**: Required for Docker group changes to take effect
- **Portainer password**: You will be prompted to set this when running the playbook — it is never stored in the repo
- **Tailscale**: Install creates the `tailscaled` service but does **not** authenticate automatically. Run `sudo tailscale up` after the playbook completes and approve at [https://login.tailscale.com](https://login.tailscale.com)
- **Netdata is open by default**: No authentication is required to view the dashboard. It is accessible to anyone on the same network. If your server is publicly exposed, consider [adding basic auth via Nginx](https://learn.netdata.cloud/docs/netdata-agent/configuration/securing-netdata-agents)
- **Uptime Kuma first-run**: The dashboard is open until you create an admin account — do this immediately after setup
- **WireGuard**: Requires additional config after setup (`wg-quick up wg0`) — Tailscale is the easier alternative for most personal use cases

### General Notes
- **Idempotency**: All playbooks are safe to run multiple times
- **OS Support**: Designed for `amd64` systems running **Ubuntu** or **Debian**
- **Node.js**: Installed from the NodeSource apt repository using a verified GPG key — no piped shell scripts
- **Oh My Zsh**: Installed via `git clone` — no piped shell scripts
- **CI/CD Testing**: GitHub Actions runs syntax checks and linting across Ubuntu 20.04/22.04 and Debian 11/12

---

## 🔧 Customization

### Adding New Packages

Add packages to the appropriate task in the relevant playbook:
- System packages: add to the "Install Basic Utilities" task
- Docker services: add a `docker_container` task alongside Portainer and Uptime Kuma

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
