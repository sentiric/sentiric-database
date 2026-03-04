CREATE TABLE IF NOT EXISTS queue_members (
    queue_id UUID NOT NULL REFERENCES queues(id) ON DELETE CASCADE,
    agent_user_id UUID NOT NULL, -- User Service'deki User ID (Loose Coupling)
    
    skill_level INT DEFAULT 1, -- 1 (En iyi) - 10 (En düşük) (Yetenek bazlı yönlendirme için)
    paused BOOLEAN DEFAULT FALSE, -- Ajan bu kuyrukta geçici olarak pasif mi?
    
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (queue_id, agent_user_id)
);

COMMENT ON TABLE queue_members IS 'Hangi temsilcinin hangi kuyruklara baktığını ve o kuyruktaki yetenek seviyesini tutar.';