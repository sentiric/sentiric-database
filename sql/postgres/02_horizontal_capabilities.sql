-- 02_horizontal_capabilities.sql: Konfigürasyon, RAG, VCA ve Saga Kontrol Tabloları (AGENT SERVICE)

-- === 8. YATAY KONFİGÜRASYON (Announcements ve Templates) ===
CREATE TABLE IF NOT EXISTS announcements (
    id VARCHAR(255) NOT NULL,
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    language_code VARCHAR(10) NOT NULL,
    audio_path VARCHAR(255) NOT NULL,
    description TEXT,    
    PRIMARY KEY (id, language_code, tenant_id)
);

CREATE TABLE IF NOT EXISTS templates (
    id VARCHAR(255) NOT NULL,
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),    
    language_code VARCHAR(10) NOT NULL,               
    template_type VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    description TEXT,
    PRIMARY KEY (id, language_code, tenant_id)
);

-- === 9. RAG (Knowledge Service) ===
CREATE TABLE IF NOT EXISTS datasources (
    id SERIAL PRIMARY KEY,
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    source_type VARCHAR(50) NOT NULL, -- 'postgres', 'web', 'file'
    source_uri TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    last_indexed_at TIMESTAMPTZ,
    UNIQUE(tenant_id, source_uri)
);

-- === 10. VCA (Value and Cost Analytics) - CDR Service tarafından beslenir ===
CREATE TABLE IF NOT EXISTS cost_models (
    id VARCHAR(255) PRIMARY KEY,
    resource_type VARCHAR(50) NOT NULL, 
    cost_per_unit NUMERIC(10, 8) NOT NULL,
    currency VARCHAR(5) NOT NULL,
    start_date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS usage_records (
    id BIGSERIAL PRIMARY KEY,
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    call_id VARCHAR(255),
    saga_id UUID,
    service_name VARCHAR(100) NOT NULL,
    resource_type VARCHAR(50) NOT NULL,
    quantity NUMERIC(15, 5) NOT NULL,
    calculated_cost NUMERIC(10, 5),
    recorded_at TIMESTAMPTZ DEFAULT NOW()
);

-- === 11. SAGA (Dağıtık İşlem Yönetimi) ===
CREATE TABLE IF NOT EXISTS saga_transactions (
    saga_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    saga_name VARCHAR(255) NOT NULL,
    current_step INT NOT NULL DEFAULT 0,
    status VARCHAR(50) NOT NULL DEFAULT 'RUNNING', 
    payload JSONB,
    step_results JSONB DEFAULT '{}'::jsonb,
    last_error TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);