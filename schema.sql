CREATE TABLE IF NOT EXISTS organizations (
 id BIGSERIAL PRIMARY KEY,
 name TEXT NOT NULL,
 type TEXT,
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS users (
 id BIGSERIAL PRIMARY KEY,
 username TEXT UNIQUE NOT NULL,
 role TEXT NOT NULL,
 password_hash TEXT,
 organization_id BIGINT REFERENCES organizations(id) ON DELETE SET NULL,
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS assessments (
 id BIGSERIAL PRIMARY KEY,
 organization_id BIGINT REFERENCES organizations(id) ON DELETE CASCADE,
 title TEXT NOT NULL,
 status TEXT NOT NULL DEFAULT 'draft',
 score NUMERIC(6,2),
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS risks (
 id BIGSERIAL PRIMARY KEY,
 organization_id BIGINT REFERENCES organizations(id) ON DELETE CASCADE,
 title TEXT NOT NULL,
 likelihood NUMERIC(5,2),
 impact NUMERIC(5,2),
 risk_score NUMERIC(8,2),
 status TEXT NOT NULL DEFAULT 'open',
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS evidence (
 id BIGSERIAL PRIMARY KEY,
 assessment_id BIGINT REFERENCES assessments(id) ON DELETE CASCADE,
 title TEXT NOT NULL,
 file_url TEXT,
 status TEXT NOT NULL DEFAULT 'pending',
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_users_org ON users(organization_id);
CREATE INDEX IF NOT EXISTS idx_assessments_org ON assessments(organization_id);
CREATE INDEX IF NOT EXISTS idx_risks_org ON risks(organization_id);
