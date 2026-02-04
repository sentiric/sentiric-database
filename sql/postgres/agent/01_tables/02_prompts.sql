CREATE TABLE IF NOT EXISTS prompts (
    id VARCHAR(255) NOT NULL,
    tenant_id VARCHAR(255) NOT NULL,   
    language_code VARCHAR(10) NOT NULL,               
    template_type VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    description TEXT,
    PRIMARY KEY (id, language_code, tenant_id)
);

COMMENT ON TABLE prompts IS 'LLM System Promptları, SMS ve Email şablonları.';
COMMENT ON COLUMN prompts.template_type IS 'Tip: "system_prompt", "rag_prompt", "sms", "email".';
COMMENT ON COLUMN prompts.content IS 'Şablonun metin içeriği (yer tutucular içerebilir).';