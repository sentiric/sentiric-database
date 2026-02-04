CREATE TABLE IF NOT EXISTS finance_accounts (
    account_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL,
    user_id UUID,
    balance NUMERIC(10, 2)
);

COMMENT ON TABLE finance_accounts IS 'Finansal hesap kayıtları.';

CREATE INDEX IF NOT EXISTS idx_finance_tenant_id ON finance_accounts(tenant_id);