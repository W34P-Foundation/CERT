# AMY-CERT - Community Emergency Response Team

A static HTML website for AMY-CERT volunteer registration and emergency preparedness resources, hosted on GitHub Pages with Cloudflare integration.

🌐 **Website**: [amycert.org](https://amycert.org)

## Overview

AMY-CERT (Community Emergency Response Team) is a volunteer organization that trains community members in basic disaster response skills. This repository contains the static website for volunteer registration, training information, and emergency preparedness resources.

## Features

- ✅ Mobile-responsive navigation menu
- ✅ Volunteer registration form with validation
- ✅ Contact form
- ✅ Emergency resources section
- ✅ Training information
- ✅ Custom footer
- ✅ Cloudflare D1 database integration for volunteer signups
- ✅ GitHub Pages deployment
- ✅ Security best practices

## Project Structure

```
CERT/
├── index.html              # Main homepage
├── volunteer-form.html     # Volunteer registration form
├── contact.html            # Contact page
├── CNAME                   # Custom domain configuration
├── _config.yml             # Site configuration
├── .env.example            # Environment variables template
├── SECURITY.md             # Security policy
├── styles/
│   └── main.css           # Custom CSS styles
├── assets/
│   └── images/            # Image assets
├── database/
│   ├── README.md          # Database documentation
│   └── volunteer_schema.sql # Cloudflare D1 schema
├── config/
│   └── wrangler.toml      # Cloudflare Workers configuration
└── .github/
    └── workflows/
        └── deploy.yml     # GitHub Pages deployment workflow
```

## Getting Started

### Prerequisites

- Git
- A Cloudflare account (for database and DNS)
- GitHub account

### Local Development

1. Clone the repository:
   ```bash
   git clone https://github.com/W34P-Foundation/CERT.git
   cd CERT
   ```

2. Open `index.html` in your browser or use a local server:
   ```bash
   # Using Python
   python -m http.server 8000
   
   # Using Node.js
   npx serve
   ```

3. Visit `http://localhost:8000` in your browser.

### Cloudflare D1 Database Setup

1. Install Wrangler CLI:
   ```bash
   npm install -g wrangler
   ```

2. Create the D1 database:
   ```bash
   npx wrangler d1 create amycert-db
   ```

3. Apply the database schema:
   ```bash
   npx wrangler d1 execute amycert-db --file=./database/volunteer_schema.sql
   ```

4. Update `config/wrangler.toml` with your database ID.

### Cloudflare DNS Setup

1. Log into Cloudflare Dashboard
2. Add amycert.org domain
3. Configure DNS records:
   - `A` record pointing to GitHub Pages IPs
   - `CNAME` record for `www` subdomain
4. Enable Full SSL/TLS encryption

## Deployment

The site automatically deploys to GitHub Pages when changes are pushed to the `main` branch. The deployment workflow is defined in `.github/workflows/deploy.yml`.

### Manual Deployment

Push changes to the `main` branch:
```bash
git add .
git commit -m "Your commit message"
git push origin main
```

## Security

Please review our [Security Policy](SECURITY.md) for information about:
- Reporting vulnerabilities
- Security best practices
- Security headers implementation

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is open source and available under the MIT License.

## Contact

- **Website**: [amycert.org](https://amycert.org)
- **Email**: info@amycert.org
- **Volunteer Inquiries**: volunteers@amycert.org

---

Built with ❤️ for community safety
