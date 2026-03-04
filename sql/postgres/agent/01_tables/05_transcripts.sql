CREATE TABLE IF NOT EXISTS transcripts (
    id BIGSERIAL PRIMARY KEY,
    conversation_id UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
    
    sender_type VARCHAR(50) NOT NULL, -- 'USER', 'AI', 'AGENT', 'SYSTEM'
    sender_id VARCHAR(255),           -- Kim konuştu? (User ID veya 'ai-assistant')
    
    message_text TEXT NOT NULL,       -- Konuşulan metin veya mesaj içeriği
    
    sentiment_score NUMERIC(3,2),     -- Bu cümlenin duygu skoru (Anlık sinirlenme tespiti için)
    media_payload JSONB,              -- Ses kaydı URL'i, WhatsApp resmi, PDF linki vb.
    
    created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE transcripts IS 'Ajan ekranına (Web Agent UI) yansıyacak olan satır satır konuşma dökümleri.';
COMMENT ON COLUMN transcripts.media_payload IS 'Eğer mesaj bir medya içeriyorsa (ses, resim) detayları burada JSON olarak saklanır.';

CREATE INDEX IF NOT EXISTS idx_transcripts_conv_id ON transcripts(conversation_id);