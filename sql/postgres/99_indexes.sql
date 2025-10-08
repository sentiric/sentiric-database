-- 99_indexes.sql: Performans için tüm indeksler (Tüm modüllerden toplanmıştır)

-- === CORE VARLIK İNDEKLERİ ===
CREATE INDEX IF NOT EXISTS idx_users_tenant_id ON users(tenant_id);
CREATE INDEX IF NOT EXISTS idx_contacts_value ON contacts(contact_value);
CREATE INDEX IF NOT EXISTS idx_sip_credentials_username ON sip_credentials(sip_username);
CREATE INDEX IF NOT EXISTS idx_inbound_routes_tenant_id ON inbound_routes(tenant_id);
CREATE INDEX IF NOT EXISTS idx_outbound_routes_tenant_id ON outbound_routes(tenant_id);

-- === HORIZONTAL CAPABILITY İNDEKLERİ ===
CREATE INDEX IF NOT EXISTS idx_usage_records_call_id ON usage_records(call_id);
CREATE INDEX IF NOT EXISTS idx_saga_transactions_status ON saga_transactions(status);
CREATE INDEX IF NOT EXISTS idx_datasources_tenant_id ON datasources(tenant_id);
CREATE INDEX IF NOT EXISTS idx_announcements_tenant_id ON announcements(tenant_id);

-- === CDR İNDEKLERİ ===
CREATE INDEX IF NOT EXISTS idx_calls_user_id ON calls(user_id);
CREATE INDEX IF NOT EXISTS idx_calls_tenant_id ON calls(tenant_id);
CREATE INDEX IF NOT EXISTS idx_calls_start_time ON calls(start_time);
CREATE INDEX IF NOT EXISTS idx_call_events_call_id ON call_events(call_id);

-- === VBS İNDEKLERİ (Örnek VBS'ler için) ===
CREATE INDEX IF NOT EXISTS idx_hospitality_tenant_id ON hospitality_reservations(tenant_id);
CREATE INDEX IF NOT EXISTS idx_health_services_tenant_id ON health_services(tenant_id);
CREATE INDEX IF NOT EXISTS idx_ecommerce_tenant_id ON ecommerce_orders(tenant_id);
CREATE INDEX IF NOT EXISTS idx_finance_tenant_id ON finance_accounts(tenant_id);
CREATE INDEX IF NOT EXISTS idx_legal_tenant_id ON legal_cases(tenant_id);
CREATE INDEX IF NOT EXISTS idx_public_tenant_id ON public_applications(tenant_id);
CREATE INDEX IF NOT EXISTS idx_insurance_policies_tenant_id ON insurance_policies(tenant_id);