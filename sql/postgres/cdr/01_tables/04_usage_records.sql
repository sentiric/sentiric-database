CREATE TABLE IF NOT EXISTS usage_records (
    id BIGSERIAL PRIMARY KEY,
    tenant_id VARCHAR(255) NOT NULL, 
    call_id VARCHAR(255),
    saga_id UUID,
    service_name VARCHAR(100) NOT NULL,
    resource_type VARCHAR(50) NOT NULL,
    quantity NUMERIC(15, 5) NOT NULL,
    calculated_cost NUMERIC(10, 5),
    recorded_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE usage_records IS 'Servislerden gelen mikro tüketim kayıtları (Faturalandırma temeli).';
COMMENT ON COLUMN usage_records.service_name IS 'Harcamayı yapan servis (örn: "stt-whisper-service").';