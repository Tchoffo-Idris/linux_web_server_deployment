# Linux Web Server Architecture

## 1. Overview

This project uses an Ubuntu Server virtual machine to host a static website using Nginx.

The architecture is designed to show how a request moves from a client browser through the server's firewall and Nginx before reaching the website files.

The main components are:

* Client computer and web browser
* VirtualBox
* Ubuntu Server
* UFW firewall
* Nginx web server
* Nginx server block
* Website document root

## 2. Architecture Diagram

```text
                    Client Computer
                          |
                       Browser
                          |
                     HTTP Request
                          |
                          v
                    +-----------+
                    |    UFW    |
                    | Firewall  |
                    +-----------+
                          |
                       Port 80
                          |
                          v
                    +-----------+
                    |   Nginx   |
                    | Web Server |
                    +-----------+
                          |
                   Server Block
                   mysite.local
                          |
                          v
              /var/www/mysite/html
                          |
                          v
                    index.html
```

## 3. Components

### Client

The client is the computer running the web browser used to request the website.

The browser sends a request to the configured hostname, such as:

```text
http://mysite.local
```

### VirtualBox

VirtualBox provides the virtual machine environment where the Ubuntu Server runs.

The server is kept inside a lab environment so that the web server, firewall, and networking configuration can be tested safely.

### Ubuntu Server

Ubuntu Server provides the operating system for the web server.

It manages the Nginx service, website files, firewall configuration, logs, and other system resources.

### UFW

UFW acts as the firewall layer.

It controls which network traffic is allowed to reach the server. SSH access is kept available for administration, while the required web traffic is allowed for the website.

Unnecessary ports and services remain restricted because the server should only expose what is required.

### Nginx

Nginx receives HTTP requests and determines which website should respond.

The Nginx service is managed through systemd and listens for web traffic on the configured port.

### Server Block

The Nginx server block connects the hostname to the website configuration.

For this project, the hostname is:

```text
mysite.local
```

The document root is:

```text
/var/www/mysite/html
```

This allows Nginx to serve the website files from the correct directory.

### Website Document Root

The website files are stored under:

```text
/var/www/mysite/html
```

The main page is:

```text
/var/www/mysite/html/index.html
```

Keeping the website in its own document root makes the server easier to organize and allows additional websites to be hosted later.

## 4. Request Flow

When a user opens the website, the request follows this basic path:

1. The browser requests `mysite.local`.
2. The client resolves the hostname to the server's IP address using the configured hosts entry.
3. The request reaches the Ubuntu Server.
4. UFW checks whether the required web traffic is allowed.
5. Nginx receives the HTTP request.
6. Nginx uses the matching server block for `mysite.local`.
7. The server block points Nginx to `/var/www/mysite/html`.
8. Nginx returns the requested website content to the browser.
9. The request is recorded in the Nginx access log.

## 5. Service Management

Nginx is managed using systemd.

The following commands are used to verify the service:

```bash
sudo systemctl status nginx
sudo systemctl is-enabled nginx
sudo systemctl is-active nginx
```

The service should be active and enabled so that it is running and configured to start after a system reboot.

## 6. Security Considerations

The firewall is configured to allow only the traffic required by the server.

SSH access must remain available for remote administration, while HTTP traffic is allowed for the website.

HTTPS can be added later when TLS is configured.

The lab should not expose unnecessary services or ports because reducing the exposed attack surface is an important part of server administration.
