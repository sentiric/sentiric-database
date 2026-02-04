CREATE TABLE IF NOT EXISTS sip_credentials (
    user_id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    sip_username VARCHAR(255) NOT NULL UNIQUE,
    ha1_hash VARCHAR(32) NOT NULL, 
    created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE sip_credentials IS 'SIP Registrar servisi için kimlik doğrulama verileri.';
COMMENT ON COLUMN sip_credentials.sip_username IS 'SIP cihazındaki Auth User (örn: 1001).';
COMMENT ON COLUMN sip_credentials.ha1_hash IS 'MD5(username:realm:password). Parola düz metin saklanmaz.';