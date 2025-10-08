-- 01_telephony_routing.sql: SADECE AĞ VE PROTOKOL YÖNLENDİRME VERİLERİ (DIALPLAN SERVICE)

-- === 5. TELEFONİ SAĞLAYICILARI ===
CREATE TABLE IF NOT EXISTS telephony_providers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    provider_type VARCHAR(50) NOT NULL,
    software_info TEXT
);

-- === 6. SIP TRUNKLARI ===
CREATE TABLE IF NOT EXISTS sip_trunks (
    id SERIAL PRIMARY KEY,
    provider_id INT NOT NULL REFERENCES telephony_providers(id),
    name VARCHAR(255) NOT NULL,
    signaling_ip VARCHAR(255),
    signaling_port INT,
    rtp_ip VARCHAR(255),
    supported_codecs JSONB, 
    ptime INT DEFAULT 20, 
    requires_record_route BOOLEAN DEFAULT FALSE,
    outbound_authentication_required BOOLEAN DEFAULT TRUE,
    outbound_authentication_type VARCHAR(50) DEFAULT 'IP_WHITELIST',
    is_active BOOLEAN DEFAULT TRUE,
    UNIQUE(provider_id, name)
);

-- === 7. DIALPLAN VE INBOUND ROUTE KURALLARI ===
CREATE TABLE IF NOT EXISTS dialplans (
    id VARCHAR(255) PRIMARY KEY,
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    action VARCHAR(255) NOT NULL,     
    action_data JSONB,    
    description TEXT
);

CREATE TABLE IF NOT EXISTS inbound_routes (
    phone_number VARCHAR(255) PRIMARY KEY,
    -- sip_trunk_id'nin varsayılan değeri 1 olarak ayarlanmıştır (system trunk).
    sip_trunk_id INT NOT NULL DEFAULT 1 REFERENCES sip_trunks(id), 
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    default_language_code VARCHAR(10) NOT NULL DEFAULT 'tr',
    is_maintenance_mode BOOLEAN DEFAULT FALSE,
    failsafe_dialplan_id VARCHAR(255) REFERENCES dialplans(id),   
    off_hours_dialplan_id VARCHAR(255) REFERENCES dialplans(id),
    active_dialplan_id VARCHAR(255) REFERENCES dialplans(id)
);

CREATE TABLE IF NOT EXISTS outbound_routes (
    id SERIAL PRIMARY KEY,
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    name VARCHAR(255) NOT NULL,
    number_pattern VARCHAR(50) NOT NULL,
    sip_trunk_id INT NOT NULL REFERENCES sip_trunks(id),
    caller_id VARCHAR(50) NOT NULL,
    priority INT NOT NULL DEFAULT 10,
    is_active BOOLEAN DEFAULT TRUE,
    UNIQUE(tenant_id, name)
);