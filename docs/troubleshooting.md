# Linux Web Server Troubleshooting

## 1. Purpose

Troubleshooting is an important part of web server administration because a website can fail for several different reasons.

A problem may come from the Nginx configuration, website files, firewall, hostname resolution, service status, permissions, or networking.

The troubleshooting process used in this project follows a simple approach:

```text
Symptom → Investigation → Root Cause → Fix → Verification
```

## 2. Nginx Service Not Running

### Symptom

The website does not respond and Nginx may not be running.

### Investigation

Check the service:

```bash
sudo systemctl status nginx
```

Check whether it is active:

```bash
sudo systemctl is-active nginx
```

### Possible Cause

Nginx may have stopped or failed to start because of a configuration or system problem.

### Fix

If the configuration is valid, start Nginx:

```bash
sudo systemctl start nginx
```

Then verify:

```bash
sudo systemctl status nginx
```

### Verification

The service should show:

```text
active (running)
```

---

## 3. Nginx Configuration Error

### Symptom

Nginx fails to reload after a configuration change.

### Investigation

Run:

```bash
sudo nginx -t
```

### Possible Cause

There may be a syntax error or incorrect directive in the server block.

### Fix

Open the configuration:

```bash
sudo nano /etc/nginx/sites-available/mysite
```

Correct the configuration and test it again:

```bash
sudo nginx -t
```

### Verification

Only reload Nginx after the configuration test succeeds:

```bash
sudo systemctl reload nginx
```

---

## 4. Website Shows the Default Nginx Page

### Symptom

The browser displays the default Nginx page instead of the custom website.

### Investigation

Check that the custom server block exists:

```bash
ls -l /etc/nginx/sites-enabled/
```

Check the server block configuration:

```bash
sudo nano /etc/nginx/sites-available/mysite
```

### Possible Causes

Possible causes include:

* The custom server block is not enabled.
* The default site is still being selected.
* The hostname does not match the configured `server_name`.
* The request is reaching the wrong server.

### Fix

Enable the custom server block:

```bash
sudo ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/mysite
```

If necessary, remove the default site:

```bash
sudo unlink /etc/nginx/sites-enabled/default
```

Test and reload:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

### Verification

Open:

```text
http://mysite.local
```

The custom website should now appear.

---

## 5. Hostname Does Not Resolve

### Symptom

The browser cannot find `mysite.local`.

### Investigation

Check the client machine's hosts file.

The entry should contain:

```text
SERVER_IP    mysite.local
```

### Possible Cause

The hostname is not mapped to the Ubuntu Server's IP address.

### Fix

Add the correct server IP and hostname to the hosts file.

On Windows:

```text
C:\Windows\System32\drivers\etc\hosts
```

On Linux/macOS:

```text
/etc/hosts
```

### Verification

Test the website again:

```bash
curl http://mysite.local
```

---

## 6. Firewall Blocking Web Traffic

### Symptom

Nginx is running locally, but the website cannot be reached from another machine.

### Investigation

Check UFW:

```bash
sudo ufw status verbose
```

Check whether the web application profile is available:

```bash
sudo ufw app list
```

### Possible Cause

HTTP traffic may not be allowed through UFW.

### Fix

Allow HTTP traffic:

```bash
sudo ufw allow 'Nginx HTTP'
```

Make sure SSH remains allowed:

```bash
sudo ufw allow OpenSSH
```

### Verification

Check the rules:

```bash
sudo ufw status numbered
```

Then test the website from the client machine.

---

## 7. Website Returns 404

### Symptom

The server responds, but the requested page cannot be found.

### Investigation

Check the document root:

```bash
ls -la /var/www/mysite/html
```

Check that the main page exists:

```bash
ls -l /var/www/mysite/html/index.html
```

### Possible Cause

The requested file may not exist or the server block may point to the wrong document root.

### Fix

Verify the `root` directive:

```nginx
root /var/www/mysite/html;
```

Make sure the required website files exist in that directory.

### Verification

Request the page again:

```bash
curl http://mysite.local
```

---

## 8. Checking Logs

When the cause of a problem is unclear, inspect the Nginx logs.

### Access Log

```bash
sudo tail -n 50 /var/log/nginx/mysite.access.log
```

The access log shows requests received by the website.

### Error Log

```bash
sudo tail -n 50 /var/log/nginx/mysite.error.log
```

The error log provides information about problems encountered while processing requests.

### systemd Logs

```bash
sudo journalctl -u nginx --no-pager -n 50
```

These logs can provide additional information about the Nginx service itself.

---

## 9. Troubleshooting Record

For the final project documentation, record at least one genuine problem using the following format:

### Problem

Describe what was not working.

### Investigation

List the commands or checks used to identify the cause.

### Root Cause

Explain what caused the problem.

### Fix

Describe what was changed.

### Verification

Explain how the fix was tested and how the successful result was confirmed.

Example structure:

```text
Problem:
The custom website was not being displayed.

Investigation:
Checked the Nginx service, server block, enabled sites, and configuration syntax.

Root Cause:
The custom server block was not correctly enabled.

Fix:
Enabled the server block and reloaded Nginx after running nginx -t.

Verification:
The custom hostname displayed the expected website and the request appeared in the Nginx access log.
```

## 10. Troubleshooting Principle

The main lesson from this project is to avoid changing multiple things at once.

Start with the symptom, gather evidence, identify the likely cause, make one controlled change, and test again.

This makes it easier to understand what caused the problem and provides a clear record of how it was resolved.
