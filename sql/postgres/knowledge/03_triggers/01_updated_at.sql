-- updated_at sütununu otomatik güncelleyen trigger
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