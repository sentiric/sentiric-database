CREATE TABLE IF NOT EXISTS agent_profiles (
    user_id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    tenant_id VARCHAR(255) NOT NULL,
    
    display_name VARCHAR(100), -- Müşteriye görünecek isim (Örn: "Ahmet B.")
    
    max_concurrent_calls INT DEFAULT 1,
    max_concurrent_chats INT DEFAULT 3,
    
    status VARCHAR(50) DEFAULT 'OFFLINE', -- 'ONLINE', 'OFFLINE', 'BUSY', 'BREAK'
    last_status_change TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE agent_profiles IS 'Çağrı Merkezi temsilcilerinin kapasite ve anlık durum verileri. Agent-UI üzerinden güncellenir.';