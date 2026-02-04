CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255),
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    user_type VARCHAR(50) NOT NULL,
    preferred_language_code VARCHAR(10),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE users IS 'Sistemi kullanan gerçek kişiler (Yöneticiler, Ajanlar, Müşteriler).';
COMMENT ON COLUMN users.id IS 'Kullanıcının platform genelindeki benzersiz UUID''si.';
COMMENT ON COLUMN users.tenant_id IS 'Kullanıcının ait olduğu organizasyon.';
COMMENT ON COLUMN users.user_type IS 'Rolü: "admin", "agent", "supervisor" veya "caller" (müşteri).';
COMMENT ON COLUMN users.preferred_language_code IS 'Kullanıcının tercih ettiği ISO dil kodu (örn: "tr", "en").';