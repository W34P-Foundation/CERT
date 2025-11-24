# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability within AMY-CERT, please send an email to security@amycert.org.

### What to include in your report:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Any suggested fixes (optional)

### What to expect:
- **Acknowledgment**: Within 48 hours
- **Initial Assessment**: Within 5 business days
- **Resolution Timeline**: Based on severity
  - Critical: Within 24 hours
  - High: Within 7 days
  - Medium: Within 30 days
  - Low: Within 90 days

### Security Best Practices

This repository follows these security practices:

1. **No Secrets in Code**: Environment variables are used for all sensitive data
2. **HTTPS Only**: All communications are encrypted
3. **Input Validation**: All user inputs are validated and sanitized
4. **SQL Injection Prevention**: Parameterized queries are used throughout
5. **CORS Configuration**: Restricted to amycert.org domain
6. **Content Security Policy**: Implemented to prevent XSS attacks
7. **Rate Limiting**: API endpoints are rate-limited

## Security Headers

The following security headers are implemented:

```
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
Referrer-Policy: strict-origin-when-cross-origin
Content-Security-Policy: default-src 'self'; script-src 'self' 'unsafe-inline' https://cdn.tailwindcss.com https://cdn.jsdelivr.net https://cdnjs.cloudflare.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com https://cdnjs.cloudflare.com; font-src 'self' https://fonts.gstatic.com https://cdnjs.cloudflare.com; img-src 'self' data: https:;
```

## Responsible Disclosure

We ask that you:
- Do not publicly disclose the vulnerability until it has been resolved
- Do not access or modify user data without permission
- Act in good faith to avoid privacy violations and destruction of data

Thank you for helping keep AMY-CERT secure!
