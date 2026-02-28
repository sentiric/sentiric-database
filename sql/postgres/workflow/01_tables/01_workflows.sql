CREATE TABLE IF NOT EXISTS workflows (
    id VARCHAR(255) PRIMARY KEY, -- Örn: "wf_echo_test", "wf_inbound_sales"
    tenant_id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    version INT NOT NULL DEFAULT 1,
    definition JSONB NOT NULL, -- Akışın mantığı burada duracak (Nodes, Edges)
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(tenant_id, name)
);

COMMENT ON TABLE workflows IS 'Arama akışlarının (IVR, Chatbot, Test) mantıksal tanımları.';
COMMENT ON COLUMN workflows.definition IS 'Akışın adımlarını içeren JSON yapısı (Low-Code UI tarafından üretilir).';