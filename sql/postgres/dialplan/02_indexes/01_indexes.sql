CREATE INDEX IF NOT EXISTS idx_inbound_routes_tenant_id ON inbound_routes(tenant_id);
CREATE INDEX IF NOT EXISTS idx_outbound_routes_tenant_id ON outbound_routes(tenant_id);