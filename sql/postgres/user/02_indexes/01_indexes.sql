CREATE INDEX IF NOT EXISTS idx_users_tenant_id ON users(tenant_id);
CREATE INDEX IF NOT EXISTS idx_contacts_value ON contacts(contact_value);
CREATE INDEX IF NOT EXISTS idx_sip_credentials_username ON sip_credentials(sip_username);