CREATE TABLE IF NOT EXISTS outbound_routes (
    id SERIAL PRIMARY KEY,
    tenant_id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    number_pattern VARCHAR(50) NOT NULL,
    sip_trunk_id INT NOT NULL REFERENCES sip_trunks(id),
    caller_id VARCHAR(50) NOT NULL,
    priority INT NOT NULL DEFAULT 10,
    is_active BOOLEAN DEFAULT TRUE,
    UNIQUE(tenant_id, name)
);

COMMENT ON TABLE outbound_routes IS 'Giden çağrıların (LCR) hangi trunk üzerinden çıkacağını belirler.';
COMMENT ON COLUMN outbound_routes.number_pattern IS 'Hedef numara deseni (örn: "905%" tüm cep telefonları).';
COMMENT ON COLUMN outbound_routes.caller_id IS 'Dışarıya gösterilecek numara (CLI).';