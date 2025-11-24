-- AMY-CERT Volunteer Registration Schema
-- For use with Cloudflare D1 (SQLite-compatible)
-- Created: 2025

-- =====================================================
-- VOLUNTEERS TABLE
-- Core table storing volunteer information
-- =====================================================
CREATE TABLE IF NOT EXISTS volunteers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone_number TEXT NOT NULL,
    street_address TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    zip_code TEXT NOT NULL,
    tshirt_size TEXT,
    skills_certifications TEXT,
    availability_notes TEXT,
    how_heard TEXT,
    motivation TEXT,
    -- Boolean values: 0 = false, 1 = true (SQLite convention)
    code_of_conduct_accepted INTEGER NOT NULL DEFAULT 0 CHECK (code_of_conduct_accepted IN (0, 1)),
    terms_accepted INTEGER NOT NULL DEFAULT 0 CHECK (terms_accepted IN (0, 1)),
    status TEXT NOT NULL DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create index for email lookups
CREATE INDEX IF NOT EXISTS idx_volunteers_email ON volunteers(email);

-- Create index for status filtering
CREATE INDEX IF NOT EXISTS idx_volunteers_status ON volunteers(status);

-- =====================================================
-- EMERGENCY CONTACTS TABLE
-- Stores emergency contact information for volunteers
-- =====================================================
CREATE TABLE IF NOT EXISTS emergency_contacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    volunteer_id INTEGER NOT NULL,
    contact_name TEXT NOT NULL,
    relationship TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    email TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (volunteer_id) REFERENCES volunteers(id) ON DELETE CASCADE
);

-- Create index for volunteer lookups
CREATE INDEX IF NOT EXISTS idx_emergency_contacts_volunteer ON emergency_contacts(volunteer_id);

-- =====================================================
-- VOLUNTEER INTERESTS TABLE
-- Tracks areas of interest for each volunteer
-- =====================================================
CREATE TABLE IF NOT EXISTS volunteer_interests (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    volunteer_id INTEGER NOT NULL,
    interest TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (volunteer_id) REFERENCES volunteers(id) ON DELETE CASCADE
);

-- Create index for volunteer lookups
CREATE INDEX IF NOT EXISTS idx_volunteer_interests_volunteer ON volunteer_interests(volunteer_id);

-- =====================================================
-- VOLUNTEER AVAILABILITY TABLE
-- Stores availability preferences
-- =====================================================
CREATE TABLE IF NOT EXISTS volunteer_availability (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    volunteer_id INTEGER NOT NULL,
    availability_slot TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (volunteer_id) REFERENCES volunteers(id) ON DELETE CASCADE
);

-- Create index for volunteer lookups
CREATE INDEX IF NOT EXISTS idx_volunteer_availability_volunteer ON volunteer_availability(volunteer_id);

-- =====================================================
-- CONTACT SUBMISSIONS TABLE
-- Stores contact form submissions
-- =====================================================
CREATE TABLE IF NOT EXISTS contact_submissions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    subject TEXT NOT NULL,
    message TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'new',
    ip_address TEXT,
    user_agent TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    responded_at DATETIME
);

-- Create index for status filtering
CREATE INDEX IF NOT EXISTS idx_contact_submissions_status ON contact_submissions(status);

-- =====================================================
-- AUDIT LOG TABLE
-- Maintains audit trail of all changes
-- =====================================================
CREATE TABLE IF NOT EXISTS audit_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    table_name TEXT NOT NULL,
    record_id INTEGER NOT NULL,
    action TEXT NOT NULL,
    old_values TEXT,
    new_values TEXT,
    ip_address TEXT,
    user_agent TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create index for table/record lookups
CREATE INDEX IF NOT EXISTS idx_audit_log_table_record ON audit_log(table_name, record_id);

-- =====================================================
-- VIEWS
-- =====================================================

-- View: Active Volunteers
CREATE VIEW IF NOT EXISTS active_volunteers AS
SELECT 
    v.id,
    v.first_name,
    v.last_name,
    v.email,
    v.phone_number,
    v.city,
    v.state,
    v.status,
    v.created_at,
    ec.contact_name as emergency_contact_name,
    ec.phone_number as emergency_contact_phone
FROM volunteers v
LEFT JOIN emergency_contacts ec ON v.id = ec.volunteer_id
WHERE v.status IN ('approved', 'active');

-- View: Registration Summary (daily counts)
CREATE VIEW IF NOT EXISTS registration_summary AS
SELECT 
    DATE(created_at) as registration_date,
    COUNT(*) as total_registrations,
    SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) as pending_count,
    SUM(CASE WHEN status = 'approved' THEN 1 ELSE 0 END) as approved_count,
    SUM(CASE WHEN status = 'rejected' THEN 1 ELSE 0 END) as rejected_count
FROM volunteers
GROUP BY DATE(created_at)
ORDER BY registration_date DESC;

-- =====================================================
-- TRIGGERS
-- =====================================================

-- Trigger: Update timestamp on volunteer update
CREATE TRIGGER IF NOT EXISTS update_volunteer_timestamp 
AFTER UPDATE ON volunteers
FOR EACH ROW
BEGIN
    UPDATE volunteers SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;
