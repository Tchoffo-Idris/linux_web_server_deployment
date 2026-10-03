# Linux Web Server Deployment with Nginx

![Linux](https://img.shields.io/badge/Linux-Ubuntu-orange)
![Nginx](https://img.shields.io/badge/Web%20Server-Nginx-green)
![VirtualBox](https://img.shields.io/badge/Lab-VirtualBox-blue)
![UFW](https://img.shields.io/badge/Firewall-UFW-red)
![Status](https://img.shields.io/badge/Project-Completed-brightgreen)

A hands-on Linux server administration project focused on deploying and managing a static website on **Ubuntu Server using Nginx**.

The project covers the complete process from installing the web server to deploying website content, configuring a virtual host, controlling network access with UFW, verifying the service with systemd, inspecting logs, testing the deployment, troubleshooting problems, and documenting the final environment.

---

## Table of Contents

* [Project Overview](#project-overview)
* [Project Objectives](#project-objectives)
* [What Was Built](#what-was-built)
* [Why This Project](#why-this-project)
* [Technologies and Tools](#technologies-and-tools)
* [Lab Environment](#lab-environment)
* [Architecture](#architecture)
* [Request Flow](#request-flow)
* [Project Structure](#project-structure)
* [Implementation](#implementation)

  * [1. Install Nginx](#1-install-nginx)
  * [2. Verify Nginx](#2-verify-nginx)
  * [3. Create the Website Document Root](#3-create-the-website-document-root)
  * [4. Deploy Website Content](#4-deploy-website-content)
  * [5. Configure the Server Block](#5-configure-the-server-block)
  * [6. Enable the Website](#6-enable-the-website)
  * [7. Test the Nginx Configuration](#7-test-the-nginx-configuration)
  * [8. Configure Hostname Resolution](#8-configure-hostname-resolution)
  * [9. Configure UFW](#9-configure-ufw)
  * [10. Verify the Running Service](#10-verify-the-running-service)
  * [11. Inspect Logs](#11-inspect-logs)
* [Testing](#testing)
* [Troubleshooting](#troubleshooting)
* [Security Considerations](#security-considerations)
* [Documentation](#documentation)
* [Screenshots and Evidence](#screenshots-and-evidence)
* [Lessons Learned](#lessons-learned)
* [Challenges](#challenges)
* [Future Improvements](#future-improvements)
* [What This Project Demonstrates](#what-this-project-demonstrates)
* [Final Verification Checklist](#final-verification-checklist)
* [Repository Structure](#repository-structure)
* [Conclusion](#conclusion)

---

# Project Overview

This project demonstrates the deployment of a static website on an **Ubuntu Server virtual machine** using **Nginx**.

The objective was to build a small but realistic web server environment rather than simply install Nginx and display its default page.

The completed environment includes:

* Ubuntu Server running inside VirtualBox
* Nginx web server
* A dedicated website document root
* A custom static HTML website
* An Nginx server block / virtual host
* Hostname-based access using `mysite.local`
* UFW firewall rules
* systemd service management
* Nginx access and error logs
* Configuration validation
* Website connectivity testing
* Troubleshooting documentation
* Architecture documentation
* Screenshots and project evidence

The project follows the basic flow:

```text
Browser
   |
   v
Hostname Resolution
   |
   v
Ubuntu Server
   |
   v
UFW Firewall
   |
   v
Nginx
   |
   v
Server Block
   |
   v
Website Document Root
   |
   v
index.html
```

The project manual describes the goal as a Linux server running Nginx that serves a real website through a named virtual host, exposes only the required ports, and allows service health and traffic to be verified through systemd and logs.

---

# Project Objectives

The main objective was to gain practical experience administering a Linux web server.

The project focused on the following areas:

### Web Server Administration

* Install Nginx on Ubuntu Server
* Start and manage the Nginx service
* Verify the installed version
* Understand the Nginx directory structure
* Deploy static website content
* Configure a dedicated document root
* Create and enable a server block
* Understand hostname-based virtual hosting

### Linux Administration

* Manage services using systemd
* Work with Linux directories and permissions
* Manage configuration files
* Validate service configuration
* Inspect listening network sockets
* Read and interpret service logs

### Network and Security Administration

* Configure UFW
* Allow required SSH access
* Allow HTTP traffic
* Verify firewall rules
* Check listening ports
* Restrict unnecessary network exposure

### Troubleshooting

* Identify web server problems
* Check Nginx service status
* Validate configuration syntax
* Inspect access logs
* Inspect error logs
* Use systemd journal logs
* Test hostname resolution
* Verify website reachability

### Documentation

* Document the architecture
* Document deployment procedures
* Record testing procedures
* Document troubleshooting
* Capture screenshots as evidence
* Organize the project for GitHub

---

# What Was Built

The final lab environment contains an Ubuntu Server virtual machine running Nginx.

The website is stored in:

```text
/var/www/mysite/html
```

The main website file is:

```text
/var/www/mysite/html/index.html
```

The Nginx server block is stored in:

```text
/etc/nginx/sites-available/mysite
```

and enabled through:

```text
/etc/nginx/sites-enabled/mysite
```

The test hostname used by the project is:

```text
mysite.local
```

The website is served over HTTP on:

```text
Port 80
```

Nginx has separate access and error logs for the site:

```text
/var/log/nginx/mysite.access.log
/var/log/nginx/mysite.error.log
```

---

# Why This Project

Installing a web server is only one part of web server administration.

A working server also needs to be:

* Properly configured
* Reachable through the correct network path
* Protected by appropriate firewall rules
* Monitored through logs
* Managed as a system service
* Tested after configuration changes
* Troubleshootable when something goes wrong

This project was designed to practice those areas together.

The goal was therefore not simply to make a website load, but to understand what happens from the moment a browser makes a request until Nginx returns the website content.

---

# Technologies and Tools

| Technology / Tool | Purpose                             |
| ----------------- | ----------------------------------- |
| Ubuntu Server     | Linux operating system              |
| Nginx             | Web server                          |
| VirtualBox        | Virtual machine environment         |
| UFW               | Firewall management                 |
| systemd           | Service management                  |
| Bash              | Command-line administration         |
| HTML              | Static website content              |
| Git               | Version control                     |
| GitHub            | Project documentation and portfolio |
| `curl`            | HTTP testing                        |
| `ss`              | Listening socket inspection         |
| `journalctl`      | Service log inspection              |

---

# Lab Environment

The project was designed for a virtualized Linux environment.

### Suggested environment

```text
VM Name: Ubuntu-Linux-Admin-Lab
Operating System: Ubuntu Server
CPU: 2 cores
RAM: 2 GB minimum
Disk: 20 GB minimum
Virtualization: VirtualBox
Network: NAT
Web Server: Nginx
Firewall: UFW
```

The project is intended for a lab environment rather than a public production server.

VirtualBox provides the isolated environment where the server configuration, firewall rules, networking, and web server can be tested without directly changing a production system.

---

# Architecture

The architecture consists of several layers working together.

```text
                         Client Computer
                               |
                               v
                            Browser
                               |
                               v
                       mysite.local
                               |
                               v
                    +-------------------+
                    |   Ubuntu Server   |
                    |                   |
                    |       UFW         |
                    |    Firewall       |
                    |        |          |
                    |        v          |
                    |      Nginx        |
                    |        |          |
                    |        v          |
                    |  Server Block     |
                    |  mysite.local     |
                    |        |          |
                    |        v          |
                    | /var/www/mysite/  |
                    |       html/       |
                    |        |          |
                    |        v          |
                    |   index.html      |
                    +-------------------+
```

The complete architecture is documented in:

```text
docs/architecture.md
```

---

# Request Flow

The request flow can be summarized as:

```text
Browser
   ↓
mysite.local
   ↓
Hostname Resolution
   ↓
Ubuntu Server
   ↓
UFW
   ↓
Nginx
   ↓
Matching Server Block
   ↓
/var/www/mysite/html
   ↓
index.html
   ↓
HTTP Response
   ↓
Browser
```

## Step 1 — Browser Request

The user enters:

```text
http://mysite.local
```

into the browser.

The browser needs to determine which server should receive the request.

## Step 2 — Hostname Resolution

The lab uses a hosts file entry to associate the hostname with the server's IP address.

Example:

```text
SERVER_IP    mysite.local
```

This makes it possible to test name-based virtual hosting without registering a public domain or configuring a public DNS service.

## Step 3 — Firewall

The request reaches the Ubuntu Server.

UFW checks whether the required web traffic is permitted.

HTTP traffic is allowed because the website is being served over port 80.

SSH access is also kept available for server administration.

## Step 4 — Nginx

Nginx receives the HTTP request.

It checks the hostname in the request and compares it with the configured `server_name`.

## Step 5 — Server Block

The matching server block contains:

```nginx
server_name mysite.local;
```

and:

```nginx
root /var/www/mysite/html;
```

This tells Nginx where the website content is located.

## Step 6 — Website Content

Nginx looks for the requested resource in:

```text
/var/www/mysite/html
```

For the main page, it serves:

```text
index.html
```

## Step 7 — Response

Nginx returns the website content to the browser.

The request is also recorded in the access log.

---

# Project Structure

The repository is organized to separate documentation, configuration examples, website files, scripts, screenshots, and architecture diagrams.

```text
linux_web_server_deployment/
├── README.md
├── LICENSE
├── configs/
│   ├── mysite.nginx.conf
│   └── ufw-rule.txt
├── diagrams/
├── docs/
│   ├── architecture.md
│   ├── deployment-checklist.md
│   ├── testing.md
│   └── troubleshooting.md
├── screenshots/
│   ├── 01-nginx-installed.png
│   ├── 02-default-page.png
│   ├── 03-site-deploy.png
│   ├── 04-server-block-config.png
│   ├── 05-server-block-config-test.png
│   ├── 06-ufw-rules.png
│   ├── 07-verifying-service.png
│   └── 08-access-logs.png
├── scripts/
│   └── verify-webserver.sh
└── site/
    └── index.html
```

---

# Implementation

## 1. Install Nginx

The system package information was updated before installing Nginx:

```bash
sudo apt update
sudo apt upgrade -y
```

Nginx was then installed:

```bash
sudo apt install -y nginx
```

The reason for updating the package information first is to make sure the system has current package metadata and available updates before installing the web server.

---

# 2. Verify Nginx

The installed version can be checked with:

```bash
nginx -v
```

The service can then be checked with:

```bash
sudo systemctl status nginx
```

A successful installation should show Nginx as:

```text
active (running)
```

This confirms that the web server is installed and currently running.

---

# 3. Create the Website Document Root

A separate directory was created for the website:

```bash
sudo mkdir -p /var/www/mysite/html
```

Ownership was configured:

```bash
sudo chown -R $USER:$USER /var/www/mysite/html
```

Permissions were configured:

```bash
sudo chmod -R 755 /var/www/mysite
```

The dedicated document root provides a clean structure and makes it easier to manage multiple websites on the same server.

---

# 4. Deploy Website Content

The main HTML page was created at:

```text
/var/www/mysite/html/index.html
```

Example:

```html
<!DOCTYPE html>
<html>
<head>
    <title>My Lab Website</title>
</head>
<body>
    <h1>It works — deployed with Nginx</h1>
    <p>Served from /var/www/mysite/html</p>
</body>
</html>
```

A custom page is useful because it makes it clear when the Nginx server is serving the deployed website instead of the default Nginx page.

---

# 5. Configure the Server Block

The Nginx configuration was created in:

```text
/etc/nginx/sites-available/mysite
```

Example:

```nginx
server {
    listen 80;
    listen [::]:80;

    server_name mysite.local www.mysite.local;

    root /var/www/mysite/html;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }

    access_log /var/log/nginx/mysite.access.log;
    error_log /var/log/nginx/mysite.error.log;
}
```

The server block connects the hostname with the website directory.

The important settings are:

### `listen`

```nginx
listen 80;
```

This tells Nginx to listen for HTTP traffic on port 80.

### `server_name`

```nginx
server_name mysite.local www.mysite.local;
```

This identifies the hostname that the server block should respond to.

### `root`

```nginx
root /var/www/mysite/html;
```

This identifies the directory containing the website files.

### `index`

```nginx
index index.html index.htm;
```

This identifies the default files Nginx can serve when a directory is requested.

### Logs

```nginx
access_log /var/log/nginx/mysite.access.log;
error_log /var/log/nginx/mysite.error.log;
```

Separate logs make it easier to monitor requests and investigate problems.

---

# 6. Enable the Website

The server block was enabled using a symbolic link:

```bash
sudo ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/mysite
```

The default site can be disabled if required:

```bash
sudo unlink /etc/nginx/sites-enabled/default
```

On Ubuntu/Debian-based Nginx installations, configurations in `sites-enabled` are used by Nginx.

---

# 7. Test the Nginx Configuration

Before reloading the service, the configuration should be tested:

```bash
sudo nginx -t
```

The configuration should report successful syntax validation.

This step is important because an invalid configuration can prevent Nginx from reloading correctly.

Only after the configuration passes the test should it be reloaded:

```bash
sudo systemctl reload nginx
```

A reload applies configuration changes without unnecessarily stopping the running service.

---

# 8. Configure Hostname Resolution

The client machine needs to know where `mysite.local` should point.

A hosts file entry can be added:

```text
SERVER_IP    mysite.local
```

### Windows

```text
C:\Windows\System32\drivers\etc\hosts
```

### Linux / macOS

```text
/etc/hosts
```

The hostname can then be tested:

```bash
curl http://mysite.local
```

or opened in a browser:

```text
http://mysite.local
```

---

# 9. Configure UFW

The firewall status was checked first:

```bash
sudo ufw status verbose
```

SSH access should remain available:

```bash
sudo ufw allow OpenSSH
```

HTTP traffic can be allowed using the Nginx application profile:

```bash
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
```

UFW can then be enabled:

```bash
sudo ufw enable
```

Finally, the rules can be verified:

```bash
sudo ufw status numbered
sudo ufw status verbose
```

The reason for allowing only the required traffic is to avoid exposing unnecessary services and ports.

If HTTPS is configured later, the Nginx Full profile can be used to allow both HTTP and HTTPS.

---

# 10. Verify the Running Service

The Nginx service can be checked with:

```bash
sudo systemctl status nginx
```

The service state can also be checked directly:

```bash
sudo systemctl is-active nginx
```

To verify that it starts automatically after reboot:

```bash
sudo systemctl is-enabled nginx
```

The expected states are:

```text
active
enabled
```

This provides stronger verification than simply checking whether the website loads at the current moment.

---

# 11. Inspect Logs

Nginx provides useful information through its access and error logs.

## Access Log

```bash
sudo tail -n 20 /var/log/nginx/mysite.access.log
```

The access log records requests received by the website.

For example, refreshing the website should create a new entry.

## Error Log

```bash
sudo tail -n 50 /var/log/nginx/mysite.error.log
```

The error log can help identify problems when requests fail.

## systemd Journal

Nginx service logs can also be viewed with:

```bash
sudo journalctl -u nginx --no-pager -n 50
```

---

# Testing

Testing was performed at multiple levels rather than relying only on whether the webpage loaded.

## Nginx Installation

```bash
nginx -v
```

Expected result:

```text
Nginx version displayed
```

## Service Status

```bash
sudo systemctl status nginx
```

Expected result:

```text
active (running)
```

## Configuration Validation

```bash
sudo nginx -t
```

Expected result:

```text
Syntax is OK
Test is successful
```

## Website Test

```bash
curl http://mysite.local
```

Expected result:

The custom HTML page is returned.

## HTTP Response

```bash
curl -I http://mysite.local
```

Expected result:

```text
HTTP/1.1 200 OK
```

## Firewall Test

```bash
sudo ufw status numbered
```

Expected result:

The required SSH and web rules are present.

## Listening Port Test

```bash
sudo ss -tulpn | grep nginx
```

Expected result:

Nginx is listening on the expected web port.

## Access Log Test

```bash
sudo tail -n 20 /var/log/nginx/mysite.access.log
```

Expected result:

The website request appears in the log.

## Error Log Test

A non-existent page can be requested:

```text
http://mysite.local/page-that-does-not-exist
```

The error information can then be checked in the logs.

More detailed testing procedures are available in:

```text
docs/testing.md
```

---

# Troubleshooting

A web server can fail for several different reasons, so troubleshooting was treated as part of the project rather than an afterthought.

The troubleshooting process follows:

```text
Symptom
   ↓
Investigation
   ↓
Root Cause
   ↓
Fix
   ↓
Verification
```

Common areas checked include:

* Nginx service status
* Nginx configuration syntax
* Server block configuration
* Enabled sites
* Hostname resolution
* Website document root
* File permissions
* UFW rules
* Listening ports
* Access logs
* Error logs
* systemd journal

For example, if the website does not load, the first step is not to randomly change configuration.

Instead, checks can be performed systematically:

```bash
sudo systemctl status nginx
sudo nginx -t
sudo ufw status verbose
sudo ss -tulpn | grep nginx
```

The Nginx logs can then provide additional evidence:

```bash
sudo tail -n 50 /var/log/nginx/mysite.access.log
sudo tail -n 50 /var/log/nginx/mysite.error.log
```

Detailed troubleshooting procedures are documented in:

```text
docs/troubleshooting.md
```

---

# Security Considerations

Security was considered throughout the deployment.

## UFW Firewall

UFW was used to control incoming traffic.

The server should allow only the traffic required for its intended role.

For this project, that includes:

* SSH for administration
* HTTP for the website

HTTPS can be added when TLS is configured.

## SSH Access

SSH access must remain available before enabling UFW on a remotely accessed server.

This is important because enabling a firewall without first allowing the administrative connection can result in losing access to the server.

## Configuration Validation

Nginx configuration changes should be tested with:

```bash
sudo nginx -t
```

before reloading the service.

This reduces the chance of applying a broken configuration.

## Sensitive Information

Private information should never be committed to the repository.

Examples include:

```text
Private keys
Passwords
API tokens
Environment variables containing secrets
Private certificates
Sensitive network information
```

The repository `.gitignore` is used to help prevent accidental commits of sensitive or unnecessary files.

---

# Documentation

The project includes separate documentation files so that the repository is easier to understand and maintain.

## `docs/architecture.md`

Explains:

* The lab architecture
* Main components
* Request flow
* Nginx
* UFW
* Server blocks
* Website document root
* Service management
* Security considerations

## `docs/deployment.md`

Documents:

* Nginx installation
* Website deployment
* Document root creation
* Server block configuration
* Site enabling
* Hostname configuration
* UFW configuration
* Final deployment verification

## `docs/testing.md`

Documents:

* Installation testing
* Service testing
* Configuration testing
* Website testing
* HTTP response testing
* Firewall testing
* Listening port testing
* Access log testing
* Error log testing

## `docs/troubleshooting.md`

Documents the troubleshooting process and common problems involving:

* Nginx
* Server blocks
* Hostname resolution
* UFW
* Website files
* Logs
* Service status

---

# Screenshots and Evidence

The project uses screenshots to provide evidence that the deployment was actually performed and tested.

Recommended evidence includes:

### `01-nginx-installed.png`

Shows:

```bash
nginx -v
```

and/or the successful Nginx installation.

### `02-default-page.png`

Shows the default Nginx page before deploying the custom website.

### `03-site-deployed.png`

Shows the custom website successfully loading.

### `04-server-block-config.png`

Shows the Nginx server block configuration.

### `05-ufw-rules.png`

Shows the configured UFW rules.

### `06-systemctl-status.png`

Shows the Nginx service as active and enabled.

### `07-access-log.png`

Shows a real request appearing in the Nginx access log.

### `08-error-log.png`

Shows error information generated during testing.

### `09-final-verification.png`

Shows the final collection of verification results.

Sensitive information such as private keys, passwords, or unnecessary network information should be removed or cropped before publishing screenshots.

---

# Lessons Learned

## 1. A web server is more than the webpage

The project showed that making a webpage load is only one part of web server administration.

A reliable deployment also requires:

```text
Configuration
Security
Service Management
Monitoring
Testing
Troubleshooting
Documentation
```

## 2. Configuration should be tested before being applied

Using:

```bash
sudo nginx -t
```

before reloading Nginx provides a simple way to catch configuration problems early.

This is especially important because a configuration error can prevent the service from reloading successfully.

## 3. Logs provide evidence

Instead of guessing what happened, access and error logs provide useful evidence.

The access log shows requests reaching the server, while the error log can help identify problems.

## 4. Firewalls need to be configured carefully

A firewall should not simply block everything.

The server needs to allow the traffic required for its role while restricting unnecessary access.

## 5. Service status matters

A website may work during one session but fail after a reboot if the service is not enabled.

Checking both:

```bash
sudo systemctl is-active nginx
sudo systemctl is-enabled nginx
```

provides a better understanding of the service's current and persistent state.

## 6. Troubleshooting should be systematic

When something fails, changing several settings at once makes it difficult to identify the actual cause.

A better approach is:

```text
Observe
→ Gather Evidence
→ Identify Cause
→ Make One Change
→ Test Again
```

---

# Challenges

Some of the areas that require the most attention during this type of deployment include:

### Understanding the Server Block

The server block is important because it determines how Nginx responds to a particular hostname.

Understanding the relationship between:

```text
server_name
        ↓
root
        ↓
website files
```

makes the configuration much easier to troubleshoot.

### Firewall and Remote Access

Firewall changes need to be handled carefully because SSH access may be required throughout the project.

This is why SSH should be explicitly allowed before enabling UFW when working through a remote connection.

### Troubleshooting Instead of Guessing

A working website can sometimes hide configuration problems.

Testing individual components and checking logs provides stronger evidence than simply opening the webpage and assuming the server is correctly configured.

---

# Future Improvements

The current project focuses on HTTP and a static website.

Possible future improvements include:

## HTTPS / TLS

Configure HTTPS so the website can be accessed securely over port 443.

This could include obtaining and configuring a TLS certificate.

## DNS

Replace the local hosts file with a proper DNS configuration for a more realistic environment.

## Multiple Websites

Configure additional server blocks to host multiple websites from the same Nginx server.

## Reverse Proxy

Use Nginx as a reverse proxy in front of an application server such as Django.

## Automation

Expand the verification script to check:

* Nginx status
* Configuration validity
* Listening ports
* Firewall status
* Website HTTP response

The project manual recommends learning the manual process first before automating configuration changes because a poorly designed automation script could take a service down.

## Monitoring

Add more structured monitoring for:

* CPU
* Memory
* Disk
* Network traffic
* Nginx requests
* Error rates

---

# What This Project Demonstrates

This project demonstrates practical experience with:

### Linux Administration

* Ubuntu Server
* Command-line administration
* File permissions
* Directory management
* Service management

### Web Server Administration

* Nginx installation
* Static website deployment
* Server blocks
* Document roots
* HTTP testing
* Configuration validation

### Network Administration

* Hostname resolution
* HTTP traffic
* Listening ports
* Network connectivity testing
* `curl`
* `ss`

### Security

* UFW firewall
* SSH access control
* Port management
* Reducing unnecessary network exposure

### Troubleshooting

* Service diagnostics
* Configuration validation
* Access log analysis
* Error log analysis
* systemd journal inspection
* Structured troubleshooting

### Documentation

* Architecture documentation
* Deployment documentation
* Testing documentation
* Troubleshooting documentation
* Screenshots
* GitHub project organization

---

# Final Verification Checklist

The project should not be considered complete until the following checks have been performed.

## Nginx

* [x] Nginx installed
* [x] Nginx version verified
* [x] Nginx service running
* [x] Nginx service enabled
* [x] Nginx configuration tested

## Website

* [x] Website document root created
* [x] Website content deployed
* [x] Custom HTML page created
* [x] Server block configured
* [x] Server block enabled
* [x] Website reachable through test hostname

## Firewall

* [x] UFW status checked
* [x] SSH access allowed
* [x] HTTP traffic allowed
* [x] Firewall rules verified
* [x] Unnecessary ports restricted

## Logging

* [x] Access log inspected
* [x] Error log inspected
* [x] systemd journal inspected
* [x] Real website request verified in logs

## Testing

* [x] Nginx configuration tested
* [x] HTTP response tested
* [x] Listening ports checked
* [x] Website tested from client
* [x] Error handling tested

## Documentation

* [x] Architecture documented
* [x] Deployment documented
* [x] Testing documented
* [x] Troubleshooting documented
* [x] Screenshots captured
* [x] Repository structure created

---

# Repository Structure

The final GitHub repository is organized as follows:

```text
linux_web_server_deployment/
├── README.md
├── LICENSE
├── configs/
│   ├── mysite.nginx.conf
│   └── ufw-rule.txt
├── diagrams/
├── docs/
│   ├── architecture.md
│   ├── deployment-checklist.md
│   ├── testing.md
│   └── troubleshooting.md
├── screenshots/
│   ├── 01-nginx-installed.png
│   ├── 02-default-page.png
│   ├── 03-site-deploy.png
│   ├── 04-server-block-config.png
│   ├── 05-server-block-config-test.png
│   ├── 06-ufw-rules.png
│   ├── 07-verifying-service.png
│   └── 08-access-logs.png
├── scripts/
│   └── verify-webserver.sh
└── site/
    └── index.html
```

---

# Conclusion

This project provided practical experience with deploying and administering a Linux web server using Nginx.

The work went beyond installing a web server by covering the complete deployment process:

```text
Install
   ↓
Configure
   ↓
Deploy
   ↓
Secure
   ↓
Test
   ↓
Monitor
   ↓
Troubleshoot
   ↓
Document
```

The final environment demonstrates how a browser request can travel through hostname resolution and the firewall before reaching Nginx, where the appropriate server block determines which website content should be returned.

The project also reinforced an important Linux administration principle:

> A service should not only work — it should be configured correctly, secured appropriately, tested, monitored, and documented.

This project forms part of my Linux administration portfolio and provides practical evidence of my work with **Ubuntu Server, Nginx, UFW, systemd, networking, troubleshooting, and web server administration**.

---

## Project Status

**Completed — Linux Web Server Deployment**

**Environment:** Ubuntu Server / VirtualBox

**Web Server:** Nginx

**Firewall:** UFW

**Protocol:** HTTP

**Test Hostname:** `mysite.local`

**Portfolio Area:** Linux Administration / Systems Administration / Web Server Administration
