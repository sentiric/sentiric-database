CREATE TABLE IF NOT EXISTS calls (
    call_id VARCHAR(255) PRIMARY KEY,
    user_id UUID,        
    contact_id INT,      
    tenant_id VARCHAR(255), 
    start_time TIMESTAMPTZ,
    answer_time TIMESTAMPTZ,
    end_time TIMESTAMPTZ,
    duration_seconds INT,
    status VARCHAR(50), 
    disposition VARCHAR(50), 
    recording_url TEXT, 
    total_cost NUMERIC(10, 5),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE calls IS 'Ana çağrı kayıtları (Master CDR - Call Detail Record).';
COMMENT ON COLUMN calls.disposition IS 'Sonuç: "ANSWERED", "BUSY", "FAILED", "NO_ANSWER".';
COMMENT ON COLUMN calls.recording_url IS 'Ses kaydının S3/MinIO adresi.';