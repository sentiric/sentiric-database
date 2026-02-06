CREATE TABLE IF NOT EXISTS sip_trunks (
    id SERIAL PRIMARY KEY,
    provider_id INT NOT NULL REFERENCES telephony_providers(id),
    name VARCHAR(255) NOT NULL,
    signaling_ip VARCHAR(255),
    -- YENİ EKLENEN KRİTİK ALAN: IP bloğu için CIDR notasyonu
    ip_block VARCHAR(255),
    -- YENİ EKLENEN KRİTİK ALAN SONU
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
COMMENT ON COLUMN sip_trunks.signaling_ip IS 'Sağlayıcının ana SIP sunucu IP adresi (Tekil eşleşme için).';
-- YENİ YORUM
COMMENT ON COLUMN sip_trunks.ip_block IS 'Bu trunka ait IP bloğu (CIDR notasyonu, örn: 194.48.95.0/24).';
COMMENT ON COLUMN sip_trunks.supported_codecs IS 'Desteklenen kodek listesi JSON array (örn: ["PCMA", "G729"]).';