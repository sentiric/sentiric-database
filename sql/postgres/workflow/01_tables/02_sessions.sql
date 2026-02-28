-- Aktif çağrıların hangi adımda olduğunu tutar (Redis yedeği/kalıcı log olarak)
CREATE TABLE IF NOT EXISTS workflow_sessions (
    session_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    call_id VARCHAR(255) NOT NULL,
    workflow_id VARCHAR(255) REFERENCES workflows(id),
    current_step_id VARCHAR(255),
    state_data JSONB DEFAULT '{}'::jsonb, -- Toplanan değişkenler (örn: tuşlanan numara)
    status VARCHAR(50) DEFAULT 'RUNNING',
    started_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_wf_sessions_call_id ON workflow_sessions(call_id);