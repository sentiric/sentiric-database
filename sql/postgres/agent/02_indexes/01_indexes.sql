CREATE INDEX IF NOT EXISTS idx_saga_transactions_status ON saga_transactions(status);
CREATE INDEX IF NOT EXISTS idx_announcements_tenant_id ON announcements(tenant_id);