CREATE TABLE IF NOT EXISTS health_services (
    id SERIAL PRIMARY KEY,
    tenant_id VARCHAR(255) NOT NULL,
    service_name VARCHAR(255) NOT NULL,
    price NUMERIC(10, 2),
    requires_prepayment BOOLEAN DEFAULT FALSE
);

COMMENT ON TABLE health_services IS 'Sağlık hizmeti kayıtları.';

CREATE INDEX IF NOT EXISTS idx_health_services_tenant_id ON health_services(tenant_id);
