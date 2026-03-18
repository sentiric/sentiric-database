-- Dosya: sql/postgres/workflow/01_tables/02_sessions.sql

-- [ARCH-COMPLIANCE] Mimari Kural İhlali Düzeltmesi (constraints.yaml -> architecture.state_management)
-- "Gerçek zamanlı çağrı durumu (CallContext/Session) PostgreSQL'de değil, Redis'te tutulmalıdır."
-- Bu tablo, gerçek zamanlı state tablosu (RUNNING/current_step_id) formatından çıkarılarak, 
-- yalnızca "tamamlanmış iş akışlarının tarihsel loglarını (Audit Log)" barındıran bir formata dönüştürülmüştür.

CREATE TABLE IF NOT EXISTS workflow_execution_logs (
    session_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    call_id VARCHAR(255) NOT NULL,
    workflow_id VARCHAR(255) REFERENCES workflows(id),
    final_state_data JSONB DEFAULT '{}'::jsonb, -- Sadece akış bittiğinde/koptuğunda toplanan nihai bağlam verisi
    status VARCHAR(50) DEFAULT 'COMPLETED',     -- Durumlar: 'COMPLETED', 'FAILED', 'CANCELLED' (RUNNING yasaktır)
    started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    completed_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE workflow_execution_logs IS 'İş akışlarının PostgreSQL üzerindeki kalıcı tarihçesi ve denetim logları. Aktif (RUNNING) state Redis üzerindedir.';

CREATE INDEX idx_wf_exec_logs_call_id ON workflow_execution_logs(call_id);