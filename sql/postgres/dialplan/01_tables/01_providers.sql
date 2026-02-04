CREATE TABLE IF NOT EXISTS telephony_providers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    provider_type VARCHAR(50) NOT NULL,
    software_info TEXT
);

COMMENT ON TABLE telephony_providers IS 'Harici VoIP/SIP Trunk sağlayıcı firmalar.';
COMMENT ON COLUMN telephony_providers.provider_type IS 'Tip: "cloud_sip_trunk", "local_gateway", "webrtc".';