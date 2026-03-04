CREATE TABLE IF NOT EXISTS conversations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL,
    call_id VARCHAR(255) NOT NULL, -- CDR'daki çağrı ile eşleşir (Foreign Key yok, Loosely Coupled)
    customer_id UUID,              -- User DB'deki müşteri ID'si (Varsa)
    assigned_agent_id UUID,        -- Eğer insana devredildiyse (User DB'deki ID)
    
    channel VARCHAR(50) DEFAULT 'voice', -- 'voice', 'whatsapp', 'webchat'
    status VARCHAR(50) DEFAULT 'ACTIVE', -- ACTIVE, TRANSFERRED, COMPLETED, CLOSED
    
    summary TEXT,                  -- AI tarafından çağrı bitiminde oluşturulan özet
    sentiment_score NUMERIC(3,2),  -- AI'ın belirlediği genel müşteri duygu skoru (-1.0 ile 1.0 arası)
    
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE conversations IS 'AI ve Müşteri (veya Ajan) arasındaki uçtan uca konuşma oturumu. Metin ve bağlam hafızasıdır.';
COMMENT ON COLUMN conversations.sentiment_score IS 'Müşteri memnuniyetini otomatik ölçmek için AI tarafından doldurulur (Örn: Sinirli bir müşteri için -0.8).';

CREATE INDEX IF NOT EXISTS idx_conversations_tenant_call ON conversations(tenant_id, call_id);