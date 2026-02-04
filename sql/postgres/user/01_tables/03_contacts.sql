CREATE TABLE IF NOT EXISTS contacts (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    contact_type VARCHAR(50) NOT NULL, 
    contact_value VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(contact_type, contact_value) 
);

COMMENT ON TABLE contacts IS 'Kullanıcılara ulaşmak için kullanılan iletişim kanalları (Omnichannel).';
COMMENT ON COLUMN contacts.contact_type IS 'Kanal tipi: "phone", "email", "whatsapp", "telegram".';
COMMENT ON COLUMN contacts.contact_value IS 'Adres değeri: "+90555...", "user@mail.com".';