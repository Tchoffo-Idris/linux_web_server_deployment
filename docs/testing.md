# Linux Web Server Testing

## 1. Testing Objective

The purpose of testing is to confirm that the Nginx web server, website configuration, firewall, hostname resolution, and logging are working as expected.

Testing is performed after deployment so that problems can be identified before considering the server ready.

## 2. Nginx Installation Test

### Test

```bash
nginx -v
```

### Expected Result

The installed Nginx version should be displayed.

### Purpose

This confirms that Nginx is installed and available on the system.

---

## 3. Nginx Service Test

### Test

```bash
sudo systemctl status nginx
sudo systemctl is-active nginx
sudo systemctl is-enabled nginx
```

### Expected Result

The service should be:

```text
active
```

and:

```text
enabled
```

### Purpose

`active` confirms that Nginx is currently running.

`enabled` confirms that Nginx is configured to start automatically after a reboot.

---

## 4. Configuration Syntax Test

### Test

```bash
sudo nginx -t
```

### Expected Result

The output should confirm that the configuration syntax is OK and the test was successful.

### Purpose

This prevents an invalid configuration from being applied to the running web server.

---

## 5. Website Content Test

### Test

```bash
curl http://mysite.local
```

Alternatively, open the following address in a browser:

```text
http://mysite.local
```

### Expected Result

The custom website page should be displayed instead of the default Nginx page.

### Purpose

This confirms that the request is reaching the intended server block and document root.

---

## 6. HTTP Response Test

### Test

```bash
curl -I http://mysite.local
```

### Expected Result

The response should contain a successful HTTP status such as:

```text
HTTP/1.1 200 OK
```

### Purpose

This confirms that Nginx is successfully responding to the HTTP request.

---

## 7. Firewall Test

### Test

```bash
sudo ufw status numbered
```

### Expected Result

The required SSH and web traffic rules should be present.

### Purpose

This confirms that the firewall is allowing the traffic required by the server while restricting unnecessary access.

---

## 8. Listening Port Test

### Test

```bash
sudo ss -tulpn | grep nginx
```

### Expected Result

Nginx should be listening on the expected web port.

### Purpose

This verifies that the Nginx process is listening for web traffic.

---

## 9. Access Log Test

### Test

First request the website, then run:

```bash
sudo tail -n 20 /var/log/nginx/mysite.access.log
```

### Expected Result

A new log entry should appear for the website request.

### Purpose

This confirms that Nginx received and processed the request.

---

## 10. Error Log Test

### Test

Request a page that does not exist:

```text
http://mysite.local/page-that-does-not-exist
```

Then inspect the error log:

```bash
sudo tail -n 50 /var/log/nginx/mysite.error.log
```

### Expected Result

The request should produce an appropriate error response and relevant log information.

### Purpose

This confirms that error information can be inspected when troubleshooting the website.

---

## 11. Final Test Summary

| Test            | Command                       | Expected Result             |
| --------------- | ----------------------------- | --------------------------- |
| Nginx version   | `nginx -v`                    | Version displayed           |
| Service status  | `systemctl status nginx`      | Active                      |
| Service startup | `systemctl is-enabled nginx`  | Enabled                     |
| Configuration   | `nginx -t`                    | Syntax successful           |
| Website         | `curl http://mysite.local`    | Custom page returned        |
| HTTP response   | `curl -I http://mysite.local` | Successful response         |
| Firewall        | `ufw status numbered`         | Required rules present      |
| Listening ports | `ss -tulpn`                   | Expected web port listening |
| Access log      | `tail` access log             | Request recorded            |
| Error log       | `tail` error log              | Error information available |

## 12. Final Verification

The deployment can be considered successfully tested when the website is reachable, Nginx is active and enabled, the configuration passes `nginx -t`, the required firewall rules are present, and real requests appear in the access logs.
