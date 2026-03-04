CREATE TABLE IF NOT EXISTS calls (
    call_id VARCHAR(255) PRIMARY KEY, -- SIP Call-ID
    tenant_id VARCHAR(255), 
    
    -- [KRİTİK EKLENTİLER]
    direction VARCHAR(20) NOT NULL DEFAULT 'INBOUND', -- 'INBOUND', 'OUTBOUND', 'INTERNAL'
    caller_number VARCHAR(50), -- Arayan Numara (CLI)
    callee_number VARCHAR(50), -- Aranan Numara (DNIS)
    
    user_id UUID,        -- Sisteme kayıtlı ise User ID
    contact_id INT,      -- Hangi kontak üzerinden aradı?
    
    start_time TIMESTAMPTZ,
    answer_time TIMESTAMPTZ,
    end_time TIMESTAMPTZ,
    duration_seconds INT DEFAULT 0,
    
    status VARCHAR(50),      -- 'RINGING', 'IN-PROGRESS', 'COMPLETED', 'FAILED'
    disposition VARCHAR(50), -- 'ANSWERED', 'BUSY', 'NO_ANSWER', 'FAILED'
    
    sip_hangup_cause INT,    -- SIP Response Code (Örn: 200, 486, 503)
    hangup_source VARCHAR(50), -- 'CALLER' (Müşteri kapattı), 'CALLEE' (Biz kapattık), 'SYSTEM' (Hata)

    recording_url TEXT, 
    total_cost NUMERIC(10, 5),
    
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE calls IS 'Ana çağrı kayıtları (Master CDR). Faturalandırma ve yasal loglama için tek kaynak.';
COMMENT ON COLUMN calls.direction IS 'Çağrının yönü. INBOUND: Dışarıdan bize, OUTBOUND: Bizden dışarıya.';
COMMENT ON COLUMN calls.hangup_source IS 'Telefonu kimin yüzümüze kapattığını (veya bizim kapattığımızı) belirler.';

CREATE INDEX idx_calls_tenant_time ON calls(tenant_id, start_time);
CREATE INDEX idx_calls_caller ON calls(caller_number);
CREATE INDEX idx_calls_callee ON calls(callee_number);