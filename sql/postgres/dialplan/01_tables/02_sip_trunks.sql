CREATE TABLE IF NOT EXISTS sip_trunks (
    id SERIAL PRIMARY KEY,
    provider_id INT NOT NULL REFERENCES telephony_providers(id),
    name VARCHAR(255) NOT NULL,
    signaling_ip VARCHAR(255),
    signaling_port INT,
    rtp_ip VARCHAR(255),
    supported_codecs JSONB, 
    ptime INT DEFAULT 20, 
    requires_record_route BOOLEAN DEFAULT FALSE,
    outbound_authentication_required BOOLEAN DEFAULT TRUE,
    outbound_authentication_type VARCHAR(50) DEFAULT 'IP_WHITELIST',
    is_active BOOLEAN DEFAULT TRUE,
    UNIQUE(provider_id, name)
);

COMMENT ON TABLE sip_trunks IS 'Dış dünya ile teknik bağlantı noktaları (Trunklar).';
COMMENT ON COLUMN sip_trunks.signaling_ip IS 'Sağlayıcının SIP sunucu IP adresi.';
COMMENT ON COLUMN sip_trunks.supported_codecs IS 'Desteklenen kodek listesi JSON array (örn: ["PCMA", "G729"]).';