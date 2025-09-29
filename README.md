# 🖥️ Home Server

**My home server for studying, testing, and code samples.**  
This repository contains the configuration of my personal home server, designed to make it easy to add, remove, and manage containers.  

It also serves as a playground for learning about server management, automation, and publishing code samples through a public domain using **Cloudflare Tunnels** with **CI/CD integration**.

## 🚀 Features
- 💻 Code samples and experiments
- 🧪 Sandbox for studying server administration and DevOps practices
- 📦 Containerized services for easy deployment and removal
- 🌐 Public domain access via Cloudflare Tunnels
- 🔄 CI/CD workflows for automation and testing
- 📊 Grafana dashboards for monitoring and observability 

## 📂 Structure
```
├── .github/
  └── workflows/          # CI/CD pipelines
├── commands/             # Make commands
├── docker/               # Docker-related files and configurations
├── docs/                 # Documentation files
├── tests/                # Automated tests
├── .gitignore            # Git ignore rules
├── LICENSE               # License file
├── Makefile              # Build/automation commands
├── rsync-filter.txt      # Rsync filters for syncing files
└── README.md             # Project documentation
```

## 🔧 Requirements
- GNU Make
- Docker & Docker Compose  
- GitHub Actions (for CI/CD)  
- Cloudflare Tunnel configured with your domain  

## Learning Goals
This repository is also a personal study space to:

- Practice container orchestration
- Explore automation and infrastructure-as-code
- Test code samples in real environments
- Learn and apply DevOps principles
- Build observability skills with Grafana monitoring

## Roadmap
- [ ] Add server for half-horizons project
- [ ] Add stress testing tools like Jmeter
- [ ] Add documentation about the tools and containers used in this repository
