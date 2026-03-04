DROP TABLE IF EXISTS ecommerce_orders; -- Şema geliştirme aşamasında olduğumuz için Drop edip yeniden yaratıyoruz
CREATE TABLE ecommerce_orders (
    order_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL,
    customer_phone VARCHAR(50), -- Arayan numara ile siparişi eşleştirmek için
    status VARCHAR(50) DEFAULT 'PROCESSING', -- SHIPPED, DELIVERED, CANCELLED
    total_amount NUMERIC(10, 2),
    tracking_number VARCHAR(100),
    estimated_delivery DATE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE ecommerce_orders IS 'AI Asistanın kargo durumu sorgulayan müşteriye cevap verebilmesi için gerekli E-Ticaret sipariş veritabanı.';
CREATE INDEX idx_ecommerce_phone ON ecommerce_orders(customer_phone);