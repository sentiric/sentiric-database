CREATE TABLE IF NOT EXISTS cost_models (
    id VARCHAR(255) PRIMARY KEY,
    resource_type VARCHAR(50) NOT NULL, 
    cost_per_unit NUMERIC(10, 8) NOT NULL,
    currency VARCHAR(5) NOT NULL,
    start_date DATE NOT NULL
);

COMMENT ON TABLE cost_models IS 'VCA (Value Cost Analytics) için birim maliyet tanımları.';
COMMENT ON COLUMN cost_models.resource_type IS 'Kaynak tipi: "telephony_minute", "llm_token", "stt_second".';