CREATE TABLE IF NOT EXISTS legal_cases (
    case_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL,
    client_user_id UUID,
    case_status VARCHAR(50)
);

COMMENT ON TABLE legal_cases IS 'Hukuki dava kayıtları.';

CREATE INDEX IF NOT EXISTS idx_legal_tenant_id ON legal_cases(tenant_id);
