CREATE TABLE IF NOT EXISTS queues (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL, -- Örn: "VIP Müşteri Destek", "Global Satış"
    
    routing_strategy VARCHAR(50) DEFAULT 'LONGEST_IDLE', -- 'RING_ALL', 'ROUND_ROBIN', 'LONGEST_IDLE'
    max_wait_time_seconds INT DEFAULT 300,
    
    fallback_action VARCHAR(255), -- 'VOICEMAIL', 'HANGUP', 'TRANSFER_TO_DIALPLAN'
    fallback_action_data JSONB,   -- Örn: { "dialplan_id": "DP_FAILSAFE" }
    
    music_on_hold_id VARCHAR(255), -- Announcements tablosundan ID
    
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE queues IS 'ACD (Automatic Call Distributor) kuyruk tanımları. Yönlendirme mantığı olduğu için Dialplan servisinde durur.';
CREATE INDEX idx_queues_tenant ON queues(tenant_id);