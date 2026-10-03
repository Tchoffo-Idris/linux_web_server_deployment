# Linux Web Server Deployment

## 1. Overview

This document describes the deployment of a static website on Ubuntu Server using Nginx.

The deployment includes:

* Installing Nginx
* Creating a website document root
* Deploying website content
* Configuring an Nginx server block
* Enabling the website
* Testing the Nginx configuration
* Configuring UFW
* Verifying the running service

## 2. Install Nginx

First, update the package information and install Nginx:

```bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y nginx
```

The package update ensures the system has current package information and available updates before installing the web server.

Verify the installation:

```bash
nginx -v
sudo systemctl status nginx
```

Nginx should show as:

```text
active (running)
```

## 3. Test the Default Nginx Installation

Before creating the custom website, test Nginx locally:

```bash
curl -I http://localhost
curl http://localhost | head -n 20
```

Testing locally confirms that Nginx itself is working before introducing the custom website configuration.

## 4. Create the Website Document Root

Create a dedicated directory for the website:

```bash
sudo mkdir -p /var/www/mysite/html
```

Set ownership and permissions:

```bash
sudo chown -R $USER:$USER /var/www/mysite/html
sudo chmod -R 755 /var/www/mysite
```

The separate document root keeps the website organized and makes it easier to manage multiple websites later.

## 5. Deploy Website Content

Create the main HTML page:

```bash
nano /var/www/mysite/html/index.html
```

The page should contain recognizable content so that it can be distinguished from the default Nginx page.

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

## 6. Configure the Nginx Server Block

Create the server block:

```bash
sudo nano /etc/nginx/sites-available/mysite
```

Example configuration:

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

The server block tells Nginx which hostname it should respond to and which directory contains the website files.

## 7. Enable the Website

Create a symbolic link to enable the server block:

```bash
sudo ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/mysite
```

The default site can be disabled if necessary:

```bash
sudo unlink /etc/nginx/sites-enabled/default
```

## 8. Test Before Reloading

Always test the configuration before applying it:

```bash
sudo nginx -t
```

The configuration should report that the syntax is OK and the test was successful.

If the test fails, the configuration should be corrected before reloading Nginx.

## 9. Reload Nginx

Apply the configuration:

```bash
sudo systemctl reload nginx
```

A reload is used instead of a restart because it applies the new configuration without unnecessarily stopping the running service.

## 10. Configure Hostname Resolution

On the client machine, add the server IP and hostname to the hosts file:

```text
SERVER_IP    mysite.local
```

On Windows, the hosts file is located at:

```text
C:\Windows\System32\drivers\etc\hosts
```

On Linux and macOS:

```text
/etc/hosts
```

The hosts entry allows the test hostname to resolve to the lab server without requiring a public DNS service.

## 11. Configure UFW

Check the firewall:

```bash
sudo ufw status verbose
```

Ensure SSH access is allowed:

```bash
sudo ufw allow OpenSSH
```

Allow HTTP traffic:

```bash
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
```

Enable UFW if required:

```bash
sudo ufw enable
```

Verify the rules:

```bash
sudo ufw status numbered
sudo ufw status verbose
```

The firewall should allow the required SSH and web traffic while keeping unnecessary ports restricted.

## 12. Final Deployment Verification

Run the following checks:

```bash
nginx -v
sudo nginx -t
sudo systemctl status nginx
sudo systemctl is-enabled nginx
sudo ufw status verbose
curl -I http://mysite.local
```

A successful deployment should have:

* Nginx installed
* The website deployed
* The server block enabled
* A valid Nginx configuration
* Nginx active and enabled
* Required firewall rules configured
* The website reachable through the test hostname
