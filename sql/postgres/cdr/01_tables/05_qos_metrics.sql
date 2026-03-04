CREATE TABLE IF NOT EXISTS qos_metrics (
    id BIGSERIAL PRIMARY KEY,
    call_id VARCHAR(255) NOT NULL,
    tenant_id VARCHAR(255),
    
    metric_type VARCHAR(50) DEFAULT 'CALL_SUMMARY', -- 'INTERVAL' (Anlık 5sn) veya 'CALL_SUMMARY' (Özet)
    
    pdd_ms INT, -- Post Dial Delay (Aranan numaranın çalmaya başlamasına kadar geçen süre)
    mos_score NUMERIC(3,2), -- Mean Opinion Score (Ses Kalitesi 1.0 - 5.0)
    
    avg_jitter_ms NUMERIC(6,2),
    max_jitter_ms NUMERIC(6,2),
    packet_loss_percent NUMERIC(5,2),
    round_trip_time_ms NUMERIC(6,2),
    
    recorded_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE qos_metrics IS 'Enterprise müşterilere SLA raporu sunmak ve hat kalitesini kanıtlamak için RTP telemetri verileri.';
CREATE INDEX idx_qos_metrics_call_id ON qos_metrics(call_id);