CREATE TABLE IF NOT EXISTS inbound_routes (
    phone_number VARCHAR(255) PRIMARY KEY,
    sip_trunk_id INT NOT NULL DEFAULT 1 REFERENCES sip_trunks(id), 
    tenant_id VARCHAR(255) NOT NULL,
    default_language_code VARCHAR(10) NOT NULL DEFAULT 'tr',
    is_maintenance_mode BOOLEAN DEFAULT FALSE,
    failsafe_dialplan_id VARCHAR(255) REFERENCES dialplans(id),   
    off_hours_dialplan_id VARCHAR(255) REFERENCES dialplans(id),
    active_dialplan_id VARCHAR(255) REFERENCES dialplans(id)
);

COMMENT ON TABLE inbound_routes IS 'Gelen çağrıların (DID) hangi plana yönlendirileceğini belirler.';
COMMENT ON COLUMN inbound_routes.phone_number IS 'Gelen numara (E.164 formatında, örn: 90212...).';
COMMENT ON COLUMN inbound_routes.failsafe_dialplan_id IS 'Sistem hatası veya timeout durumunda devreye girecek plan.';