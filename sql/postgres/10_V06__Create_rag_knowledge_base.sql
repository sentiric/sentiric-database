-- 05_rag_knowledge_base.sql: RAG BİLGİ TABANI YÖNETİMİ (KNOWLEDGE SERVICES)

-- =============================================================================
-- Bu dosya, Retrieval-Augmented Generation (RAG) mimarisinin kalıcı veri
-- katmanını tanımlar. knowledge-indexing-service bu tablolara yazar,
-- knowledge-query-service ise buradan okur (dolaylı olarak).
-- =============================================================================

-- datasources: İndekslenecek ham veri kaynaklarını (web siteleri, dosyalar, vb.) tanımlar.
-- knowledge-indexing-service bu tabloyu periyodik olarak okur.
CREATE TABLE IF NOT EXISTS datasources (
    id SERIAL PRIMARY KEY,
    tenant_id VARCHAR(255) NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    source_type VARCHAR(50) NOT NULL,
    source_uri TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    last_indexed_at TIMESTAMPTZ,    
    last_status VARCHAR(50) DEFAULT 'pending',
    UNIQUE(tenant_id, source_uri)
);

-- Tablo ve sütunlar üzerine açıklamalar ekleyelim.
COMMENT ON TABLE datasources IS 'RAG sistemi için indekslenecek veri kaynaklarının listesi.';
COMMENT ON COLUMN datasources.tenant_id IS 'Bu veri kaynağının ait olduğu kiracı.';
COMMENT ON COLUMN datasources.source_type IS 'Veri kaynağının türü (web, postgres, file).';
COMMENT ON COLUMN datasources.source_uri IS 'Veri kaynağının konumu (URL, tablo adı, dosya yolu).';
COMMENT ON COLUMN datasources.is_active IS 'Bu kaynağın indeksleme döngüsüne dahil edilip edilmeyeceği.';
COMMENT ON COLUMN datasources.last_indexed_at IS 'Bu kaynağın en son ne zaman başarıyla indekslendiği.';
COMMENT ON COLUMN datasources.last_status IS 'Son indeksleme işleminin durumu. (pending, success, failed, in_progress)';

-- updated_at sütununu otomatik güncelleyen trigger (Eğer henüz yoksa)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'update_updated_at_column') THEN
        CREATE FUNCTION update_updated_at_column()
        RETURNS TRIGGER AS $func$
        BEGIN
           NEW.updated_at = NOW();
           RETURN NEW;
        END;
        $func$ LANGUAGE 'plpgsql';
    END IF;
END;
$$;

CREATE TRIGGER update_datasources_updated_at
BEFORE UPDATE ON datasources
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();