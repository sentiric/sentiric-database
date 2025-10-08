-- 03_cdr_logging.sql: Çağrı Kayıtları ve Olaylar (CDR SERVICE)

CREATE TABLE IF NOT EXISTS calls (
    call_id VARCHAR(255) PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    contact_id INT REFERENCES contacts(id), 
    tenant_id VARCHAR(255) REFERENCES tenants(id),
    start_time TIMESTAMPTZ,
    answer_time TIMESTAMPTZ,
    end_time TIMESTAMPTZ,
    duration_seconds INT,
    status VARCHAR(50), 
    disposition VARCHAR(50), 
    recording_url TEXT, 
    total_cost NUMERIC(10, 5),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS call_events (
    event_id BIGSERIAL PRIMARY KEY,
    call_id VARCHAR(255) NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    event_timestamp TIMESTAMPTZ NOT NULL,
    payload JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);