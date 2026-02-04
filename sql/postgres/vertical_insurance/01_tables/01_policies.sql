CREATE TABLE IF NOT EXISTS insurance_policies (
    policy_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL,
    user_id UUID,
    policy_type VARCHAR(50) NOT NULL,
    start_date DATE,
    coverage_amount NUMERIC(15, 2)
);

COMMENT ON TABLE insurance_policies IS 'Sigorta politikası kayıtları.';

CREATE INDEX IF NOT EXISTS idx_insurance_policies_tenant_id ON insurance_policies(tenant_id);
