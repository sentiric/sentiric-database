CREATE TABLE IF NOT EXISTS schedules (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL, -- "Mesai Saatleri", "Bayram Tatili"
    timezone VARCHAR(50) DEFAULT 'Europe/Istanbul',
    schedule_data JSONB NOT NULL, -- { "monday": ["09:00-18:00"], "default": "closed" }
    created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE schedules IS 'Çağrı yönlendirmesinde kullanılacak zaman dilimi (Mesai saatleri/Tatiller) tanımları.';