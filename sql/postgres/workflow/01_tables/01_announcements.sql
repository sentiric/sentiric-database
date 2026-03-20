CREATE TABLE IF NOT EXISTS announcements (
    id VARCHAR(255) NOT NULL,
    tenant_id VARCHAR(255) NOT NULL,
    language_code VARCHAR(10) NOT NULL,
    audio_path VARCHAR(255) NOT NULL,
    description TEXT,    
    PRIMARY KEY (id, language_code, tenant_id)
);

COMMENT ON TABLE announcements IS 'Sistem tarafından çalınacak statik ses dosyalarının tanımları.';
COMMENT ON COLUMN announcements.audio_path IS 'Ses dosyasının assets içindeki göreceli yolu (örn: audio/tr/welcome.wav).';