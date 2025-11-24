# AMY-CERT Volunteer Registration Database

## Overview
This database schema supports the AMY-CERT volunteer registration system using Cloudflare D1, a serverless SQL database.

## Database Structure

### Core Tables

#### `volunteers`
Stores information about volunteer applicants including contact details, skills, and availability.

#### `emergency_contacts`
Emergency contact information for each volunteer.

#### `volunteer_interests`
Tracks the areas of interest selected by each volunteer.

#### `volunteer_availability`
Stores availability preferences for each volunteer.

#### `contact_submissions`
Tracks contact form submissions from the website.

### Support Tables

#### `audit_log`
Maintains audit trail of all database changes.

## Setup Instructions

### Cloudflare D1 Setup

1. **Create Database**
   ```bash
   npx wrangler d1 create amycert-db
   ```

2. **Apply Schema**
   ```bash
   npx wrangler d1 execute amycert-db --file=./database/volunteer_schema.sql
   ```

3. **Configure wrangler.toml**
   ```toml
   [[d1_databases]]
   binding = "DB"
   database_name = "amycert-db"
   database_id = "<your-database-id>"
   ```

## Security Features

- All passwords and sensitive data should be encrypted
- Input validation on all form fields
- SQL injection prevention through parameterized queries
- HTTPS required for all API endpoints
- CORS configuration for amycert.org domain only

## File Size Limits

- No file uploads currently (can be added for certifications later)

## API Endpoints

The Cloudflare Workers API provides the following endpoints:

- `POST /api/volunteer` - Submit volunteer registration
- `POST /api/contact` - Submit contact form
- `GET /api/health` - Health check endpoint

## Data Retention

- Volunteer data is retained for the duration of active volunteering
- Contact form submissions are retained for 1 year
- Audit logs are retained for 2 years

## Backup

- Cloudflare D1 provides automatic backups
- Manual exports can be performed through Wrangler CLI

## Support

For technical questions about the database schema, contact the development team.
