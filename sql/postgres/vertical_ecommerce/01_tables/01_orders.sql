CREATE TABLE IF NOT EXISTS ecommerce_orders (
    order_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL,
    user_id UUID,
    status VARCHAR(50)
);

COMMENT ON TABLE ecommerce_orders IS 'E-ticaret sipariş kayıtları.';

CREATE INDEX IF NOT EXISTS idx_ecommerce_tenant_id ON ecommerce_orders(tenant_id);
