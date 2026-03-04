CREATE TABLE IF NOT EXISTS inbound_routes (
    phone_number VARCHAR(255) PRIMARY KEY, -- E.164 (Örn: 90212...)
    tenant_id VARCHAR(255) NOT NULL,
    sip_trunk_id INT NOT NULL REFERENCES sip_trunks(id), 
    
    active_dialplan_id VARCHAR(255) REFERENCES dialplans(id),
    
    -- [YENİ] Zaman Yönetimi
    schedule_id UUID REFERENCES schedules(id),
    off_hours_dialplan_id VARCHAR(255) REFERENCES dialplans(id),
    
    -- [YENİ] Spam Koruması
    block_anonymous BOOLEAN DEFAULT FALSE,
    
    failsafe_dialplan_id VARCHAR(255) REFERENCES dialplans(id),   
    default_language_code VARCHAR(10) NOT NULL DEFAULT 'tr',
    is_maintenance_mode BOOLEAN DEFAULT FALSE
);

COMMENT ON TABLE inbound_routes IS 'Gelen çağrıların (DID) hangi plana yönlendirileceğini belirler.';
COMMENT ON COLUMN inbound_routes.schedule_id IS 'Bu numaranın çalışma saatleri. Mesai dışıysa off_hours_dialplan_id çalışır.';
COMMENT ON COLUMN inbound_routes.block_anonymous IS 'Gizli numaralardan gelen aramaları otomatik reddet.';