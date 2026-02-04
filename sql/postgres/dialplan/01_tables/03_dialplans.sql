CREATE TABLE IF NOT EXISTS dialplans (
    id VARCHAR(255) PRIMARY KEY,
    tenant_id VARCHAR(255) NOT NULL, 
    action VARCHAR(255) NOT NULL,     
    action_data JSONB,    
    description TEXT
);

COMMENT ON TABLE dialplans IS 'Bir çağrı için uygulanacak iş akışı kuralları.';
COMMENT ON COLUMN dialplans.action IS 'Ana aksiyon: "START_AI_CONVERSATION", "BRIDGE_CALL", "PLAY_ANNOUNCEMENT".';
COMMENT ON COLUMN dialplans.action_data IS 'Aksiyon parametreleri (örn: voice_selector, bridge_target).';