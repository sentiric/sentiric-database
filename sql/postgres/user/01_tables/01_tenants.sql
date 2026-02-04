CREATE TABLE IF NOT EXISTS tenants (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE tenants IS 'Platformu kullanan müşteri organizasyonları veya sistem tanımları.';
COMMENT ON COLUMN tenants.id IS 'Kiracı için benzersiz string kimlik (örn: "sentiric_demo", "acme_corp").';
COMMENT ON COLUMN tenants.is_active IS 'Kiracının sisteme erişim durumu. False ise tüm servisler reddeder.';