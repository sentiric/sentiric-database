CREATE TABLE IF NOT EXISTS hospitality_reservations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL, 
    customer_user_id UUID, 
    check_in DATE,
    check_out DATE,
    room_type VARCHAR(50),
    status VARCHAR(50) DEFAULT 'PENDING',
    is_paid BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE hospitality_reservations IS 'Otel/Turizm rezervasyon kayıtları.';