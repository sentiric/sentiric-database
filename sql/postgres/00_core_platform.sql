-- 00_core_platform.sql: TEMEL VARLIKLAR ve KİMLİK YÖNETİMİ
-- (Veri Ayrıştırma Grubu: Yüksek Olasılıklı Ortak Şema - Sharding Olasılığı Düşük)

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- === 1. TENANT YÖNETİMİ (Çekirdek - Diğer tüm tablolara FK sağlar) ===
CREATE TABLE IF NOT EXISTS tenants (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- === 2. KULLANICI YÖNETİMİ (USER SERVICE) ===
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255),
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    user_type VARCHAR(50) NOT NULL, -- 'caller', 'agent', 'admin'
    preferred_language_code VARCHAR(10),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- === 3. İLETİŞİM KANALLARI (USER SERVICE - OMNICHANNEL) ===
CREATE TABLE IF NOT EXISTS contacts (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    contact_type VARCHAR(50) NOT NULL, 
    contact_value VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(contact_type, contact_value) 
);

-- === 4. SIP/VOIP KİMLİK BİLGİLERİ (REGISTRAR SERVICE VE USER SERVICE) ===
CREATE TABLE IF NOT EXISTS sip_credentials (
    user_id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    sip_username VARCHAR(255) NOT NULL UNIQUE,
    ha1_hash VARCHAR(32) NOT NULL, 
    created_at TIMESTAMPTZ DEFAULT NOW()
);