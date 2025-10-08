-- 04_vertical_business_services.sql: Dikey İş Servisleri İçin Şema
-- (Veri Ayrıştırma Grubu: VBS İş Verisi - Tenant bazlı Sharding için ana aday)

-- Not: Tüm bu VBS tabloları, user/tenant tablolarına FK ile bağlanmalıdır.

-- === 1. HOSPITALITY SERVICE (K-7) ===
CREATE TABLE IF NOT EXISTS hospitality_reservations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    customer_user_id UUID REFERENCES users(id),
    check_in DATE,
    room_type VARCHAR(50),
    is_paid BOOLEAN DEFAULT FALSE
);

-- === 2. HEALTH SERVICE (K-7) ===
CREATE TABLE IF NOT EXISTS health_services (
    id SERIAL PRIMARY KEY,
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    service_name VARCHAR(255) NOT NULL,
    price NUMERIC(10, 2),
    requires_prepayment BOOLEAN DEFAULT FALSE
);
-- Bu tablo genellikle RAG ve kural bazlı olduğu için tenant_id'ye gerek duymaz.
-- Ancak VBS tablosu olduğu için ekleyelim:

-- === 3. E-COMMERCE SERVICE (K-7) ===
CREATE TABLE IF NOT EXISTS ecommerce_orders (
    order_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    user_id UUID REFERENCES users(id),
    status VARCHAR(50)
);

-- === 4. FINANCE SERVICE (K-7) ===
CREATE TABLE IF NOT EXISTS finance_accounts (
    account_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    user_id UUID REFERENCES users(id),
    balance NUMERIC(10, 2)
);

-- === 5. LEGAL SERVICE (K-7) ===
CREATE TABLE IF NOT EXISTS legal_cases (
    case_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    client_user_id UUID REFERENCES users(id),
    case_status VARCHAR(50)
);

-- === 6. PUBLIC SERVICE (K-7) ===
CREATE TABLE IF NOT EXISTS public_applications (
    app_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    user_id UUID REFERENCES users(id),
    submission_date TIMESTAMPTZ DEFAULT NOW()
);

-- === 7. INSURANCE SERVICE (YENİ EKLENEN VBS) ===
CREATE TABLE IF NOT EXISTS insurance_policies (
    policy_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id),
    user_id UUID REFERENCES users(id),
    policy_type VARCHAR(50) NOT NULL,
    start_date DATE,
    coverage_amount NUMERIC(15, 2)
);
