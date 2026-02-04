CREATE TABLE IF NOT EXISTS call_events (
    event_id BIGSERIAL PRIMARY KEY,
    call_id VARCHAR(255) NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    event_timestamp TIMESTAMPTZ NOT NULL,
    payload JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE call_events IS 'Çağrı içindeki mikro olaylar (DTMF basıldı, AI konuştu, kullanıcı sustu).';