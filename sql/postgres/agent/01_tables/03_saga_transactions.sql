CREATE TABLE IF NOT EXISTS saga_transactions (
    saga_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    saga_name VARCHAR(255) NOT NULL,
    current_step INT NOT NULL DEFAULT 0,
    status VARCHAR(50) NOT NULL DEFAULT 'RUNNING', 
    payload JSONB,
    step_results JSONB DEFAULT '{}'::jsonb,
    last_error TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE saga_transactions IS 'Dağıtık işlemlerin (SAGA) durum ve adım takibi.';
COMMENT ON COLUMN saga_transactions.status IS 'Durum: "RUNNING", "COMPLETED", "FAILED", "COMPENSATING" (geri alınıyor).';
COMMENT ON COLUMN saga_transactions.payload IS 'İşlemin başlangıç verileri.';
COMMENT ON COLUMN saga_transactions.step_results IS 'Her adımın çıktısını saklar (State transfer).';