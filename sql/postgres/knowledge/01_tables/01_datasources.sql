CREATE TABLE IF NOT EXISTS datasources (
    id SERIAL PRIMARY KEY,
    tenant_id VARCHAR(255) NOT NULL, 
    source_type VARCHAR(50) NOT NULL,
    source_uri TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    last_indexed_at TIMESTAMPTZ,    
    last_status VARCHAR(50) DEFAULT 'pending',
    UNIQUE(tenant_id, source_uri)
);

COMMENT ON TABLE datasources IS 'RAG sistemi için indekslenecek kaynakların listesi.';
COMMENT ON COLUMN datasources.source_type IS 'Kaynak tipi: "web" (URL), "file" (PDF/TXT), "db" (SQL).';
COMMENT ON COLUMN datasources.last_status IS 'İndeksleme durumu: "pending", "processing", "success", "failed".';