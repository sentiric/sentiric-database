CREATE TABLE IF NOT EXISTS public_applications (
    app_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id VARCHAR(255) NOT NULL,
    user_id UUID,
    submission_date TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE public_applications IS 'Genel başvuru kayıtları.';

CREATE INDEX IF NOT EXISTS idx_public_tenant_id ON public_applications(tenant_id);
