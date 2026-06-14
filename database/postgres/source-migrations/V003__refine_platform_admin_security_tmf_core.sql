-- TelcoSuite V003 TMF core refinement for Platform Admin And Security
-- Target database: ts_enterprise_platform_governance
-- App schema: platform_admin_security
-- Generated from: planning/suite-details/tmf-api-ddl-reviews/platform-admin-security.md
-- Reviewed: 2026-06-14

CREATE EXTENSION IF NOT EXISTS pgcrypto;

BEGIN;

COMMENT ON SCHEMA platform_admin_security IS 'App-owned schema for Platform Admin And Security; V002 TMF baseline review complete on 2026-06-14.';

-- Promote common TMF resource fields on platform_admin_security.tenant.
ALTER TABLE platform_admin_security.tenant
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_tenant_tmf_id ON platform_admin_security.tenant (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_tenant_tmf_href ON platform_admin_security.tenant (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_tenant_tmf_state ON platform_admin_security.tenant (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN platform_admin_security.tenant.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN platform_admin_security.tenant.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on platform_admin_security.environment.
ALTER TABLE platform_admin_security.environment
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_environment_tmf_id ON platform_admin_security.environment (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_environment_tmf_href ON platform_admin_security.environment (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_environment_tmf_state ON platform_admin_security.environment (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN platform_admin_security.environment.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN platform_admin_security.environment.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on platform_admin_security.platform_user.
ALTER TABLE platform_admin_security.platform_user
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_platform_user_tmf_id ON platform_admin_security.platform_user (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform_user_tmf_href ON platform_admin_security.platform_user (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform_user_tmf_state ON platform_admin_security.platform_user (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN platform_admin_security.platform_user.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN platform_admin_security.platform_user.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on platform_admin_security.platform_role.
ALTER TABLE platform_admin_security.platform_role
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_platform_role_tmf_id ON platform_admin_security.platform_role (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform_role_tmf_href ON platform_admin_security.platform_role (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform_role_tmf_state ON platform_admin_security.platform_role (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN platform_admin_security.platform_role.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN platform_admin_security.platform_role.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on platform_admin_security.platform_permission.
ALTER TABLE platform_admin_security.platform_permission
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_platform_permission_tmf_id ON platform_admin_security.platform_permission (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform_permission_tmf_href ON platform_admin_security.platform_permission (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform_permission_tmf_state ON platform_admin_security.platform_permission (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN platform_admin_security.platform_permission.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN platform_admin_security.platform_permission.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on platform_admin_security.user_group.
ALTER TABLE platform_admin_security.user_group
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_user_group_tmf_id ON platform_admin_security.user_group (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_user_group_tmf_href ON platform_admin_security.user_group (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_user_group_tmf_state ON platform_admin_security.user_group (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN platform_admin_security.user_group.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN platform_admin_security.user_group.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on platform_admin_security.authorization_policy.
ALTER TABLE platform_admin_security.authorization_policy
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_authorization_policy_tmf_id ON platform_admin_security.authorization_policy (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_authorization_policy_tmf_href ON platform_admin_security.authorization_policy (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_authorization_policy_tmf_state ON platform_admin_security.authorization_policy (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN platform_admin_security.authorization_policy.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN platform_admin_security.authorization_policy.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on platform_admin_security.platform_configuration.
ALTER TABLE platform_admin_security.platform_configuration
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_platform_configuration_tmf_id ON platform_admin_security.platform_configuration (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform_configuration_tmf_href ON platform_admin_security.platform_configuration (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform_configuration_tmf_state ON platform_admin_security.platform_configuration (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN platform_admin_security.platform_configuration.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN platform_admin_security.platform_configuration.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on platform_admin_security.secret_certificate_metadata.
ALTER TABLE platform_admin_security.secret_certificate_metadata
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_secret_certificate_metadata_tmf_id ON platform_admin_security.secret_certificate_metadata (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_secret_certificate_metadata_tmf_href ON platform_admin_security.secret_certificate_metadata (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_secret_certificate_metadata_tmf_state ON platform_admin_security.secret_certificate_metadata (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN platform_admin_security.secret_certificate_metadata.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN platform_admin_security.secret_certificate_metadata.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on platform_admin_security.access_audit_reference.
ALTER TABLE platform_admin_security.access_audit_reference
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_access_audit_reference_tmf_id ON platform_admin_security.access_audit_reference (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_access_audit_reference_tmf_href ON platform_admin_security.access_audit_reference (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_access_audit_reference_tmf_state ON platform_admin_security.access_audit_reference (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN platform_admin_security.access_audit_reference.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN platform_admin_security.access_audit_reference.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on platform_admin_security.event_outbox.
ALTER TABLE platform_admin_security.event_outbox
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_event_outbox_tmf_id ON platform_admin_security.event_outbox (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_event_outbox_tmf_href ON platform_admin_security.event_outbox (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_event_outbox_tmf_state ON platform_admin_security.event_outbox (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN platform_admin_security.event_outbox.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN platform_admin_security.event_outbox.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

CREATE TABLE IF NOT EXISTS platform_admin_security.tmf_api_resource_map (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tmf_api text NOT NULL,
    tmf_resource text NOT NULL,
    resource_path text,
    anchor_table text NOT NULL,
    ownership_role text NOT NULL DEFAULT 'master_or_projection',
    field_strategy text NOT NULL,
    local_spec_path text,
    promoted_fields jsonb NOT NULL DEFAULT '[]'::jsonb,
    payload_required boolean NOT NULL DEFAULT true,
    contract_test_required boolean NOT NULL DEFAULT true,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uk_tmf_api_resource_map UNIQUE (tmf_api, tmf_resource, anchor_table)
);

CREATE TABLE IF NOT EXISTS platform_admin_security.tmf_resource_reference (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    reference_role text NOT NULL,
    referenced_api text,
    referenced_resource text,
    referenced_id text,
    referenced_href text,
    referenced_name text,
    referred_type text,
    reference_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    valid_from timestamptz,
    valid_to timestamptz,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    CONSTRAINT ck_tmf_resource_reference_validity CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE TABLE IF NOT EXISTS platform_admin_security.tmf_characteristic (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    characteristic_name text NOT NULL,
    value_type text,
    characteristic_value jsonb NOT NULL DEFAULT '{}'::jsonb,
    value_from timestamptz,
    value_to timestamptz,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    CONSTRAINT ck_tmf_characteristic_validity CHECK (value_to IS NULL OR value_from IS NULL OR value_to >= value_from)
);

CREATE TABLE IF NOT EXISTS platform_admin_security.tmf_external_identifier (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    owner text,
    external_identifier_type text,
    external_identifier_id text NOT NULL,
    external_href text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uk_tmf_external_identifier UNIQUE (tenant_id, source_table, external_identifier_id)
);

CREATE TABLE IF NOT EXISTS platform_admin_security.tmf_related_party (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    party_id text,
    party_href text,
    party_name text,
    party_role text,
    party_referred_type text,
    related_party_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS platform_admin_security.tmf_note (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    note_author text,
    note_date timestamptz,
    note_text text NOT NULL,
    note_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS platform_admin_security.tmf_attachment (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    attachment_id text,
    attachment_href text,
    attachment_name text,
    attachment_type text,
    mime_type text,
    content_url text,
    size_amount numeric,
    size_units text,
    attachment_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS platform_admin_security.tmf_relationship (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    relationship_type text NOT NULL,
    target_table text,
    target_record_id uuid,
    target_canonical_id text,
    target_api text,
    target_resource text,
    target_href text,
    relationship_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    valid_from timestamptz,
    valid_to timestamptz,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_tmf_relationship_validity CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE TABLE IF NOT EXISTS platform_admin_security.event_contract (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version text NOT NULL DEFAULT 'v1',
    tmf_api text,
    tmf_resource text,
    source_table text NOT NULL,
    event_type text NOT NULL,
    event_key_strategy text NOT NULL,
    payload_basis text NOT NULL,
    outbox_table text NOT NULL DEFAULT 'platform_admin_security.event_outbox',
    retention_class text NOT NULL DEFAULT 'event_replay_90d',
    masking_policy text NOT NULL DEFAULT 'Apply source table masking policy before external publication',
    consumer_notes text,
    is_active boolean NOT NULL DEFAULT true,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uk_event_contract UNIQUE (event_name, event_version)
);

CREATE TABLE IF NOT EXISTS platform_admin_security.privacy_retention_policy (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    table_name text NOT NULL,
    data_domain text NOT NULL,
    data_classification text NOT NULL,
    retention_class text NOT NULL,
    retention_basis text NOT NULL,
    default_retention_days integer,
    legal_hold_supported boolean NOT NULL DEFAULT true,
    residency_rule text,
    masking_policy text NOT NULL,
    audit_level text NOT NULL DEFAULT 'standard',
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uk_privacy_retention_policy UNIQUE (table_name)
);

CREATE INDEX IF NOT EXISTS ix_tmf_api_resource_map_lookup ON platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource);
CREATE INDEX IF NOT EXISTS ix_tmf_resource_reference_lookup ON platform_admin_security.tmf_resource_reference (tenant_id, source_table, source_canonical_id);
CREATE INDEX IF NOT EXISTS ix_tmf_characteristic_lookup ON platform_admin_security.tmf_characteristic (tenant_id, source_table, characteristic_name);
CREATE INDEX IF NOT EXISTS ix_tmf_external_identifier_lookup ON platform_admin_security.tmf_external_identifier (tenant_id, external_identifier_id);
CREATE INDEX IF NOT EXISTS ix_tmf_related_party_lookup ON platform_admin_security.tmf_related_party (tenant_id, party_id);
CREATE INDEX IF NOT EXISTS ix_tmf_note_lookup ON platform_admin_security.tmf_note (tenant_id, source_table, source_canonical_id);
CREATE INDEX IF NOT EXISTS ix_tmf_attachment_lookup ON platform_admin_security.tmf_attachment (tenant_id, source_table, source_canonical_id);
CREATE INDEX IF NOT EXISTS ix_tmf_relationship_lookup ON platform_admin_security.tmf_relationship (tenant_id, source_table, relationship_type);
CREATE INDEX IF NOT EXISTS ix_event_contract_lookup ON platform_admin_security.event_contract (event_name, event_version);
CREATE INDEX IF NOT EXISTS ix_privacy_retention_policy_lookup ON platform_admin_security.privacy_retention_policy (table_name);

COMMENT ON TABLE platform_admin_security.tmf_api_resource_map IS 'V002 TMF support/control table for Platform Admin And Security.';
COMMENT ON TABLE platform_admin_security.tmf_resource_reference IS 'V002 TMF support/control table for Platform Admin And Security.';
COMMENT ON TABLE platform_admin_security.tmf_characteristic IS 'V002 TMF support/control table for Platform Admin And Security.';
COMMENT ON TABLE platform_admin_security.tmf_external_identifier IS 'V002 TMF support/control table for Platform Admin And Security.';
COMMENT ON TABLE platform_admin_security.tmf_related_party IS 'V002 TMF support/control table for Platform Admin And Security.';
COMMENT ON TABLE platform_admin_security.tmf_note IS 'V002 TMF support/control table for Platform Admin And Security.';
COMMENT ON TABLE platform_admin_security.tmf_attachment IS 'V002 TMF support/control table for Platform Admin And Security.';
COMMENT ON TABLE platform_admin_security.tmf_relationship IS 'V002 TMF support/control table for Platform Admin And Security.';
COMMENT ON TABLE platform_admin_security.event_contract IS 'V002 TMF support/control table for Platform Admin And Security.';
COMMENT ON TABLE platform_admin_security.privacy_retention_policy IS 'V002 TMF support/control table for Platform Admin And Security.';


INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF672', 'checkPermission', '/checkPermission', 'platform_permission', 'Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns.', 'references/tmforum-open-apis/openapi-specs/TMF672_UserRolesPermissions/TMF672-User_Role_Permission_Management_API-v5.1.0.oas.yaml', '[]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.check_permission.created', 'v1', 'TMF672', 'checkPermission', 'platform_admin_security.platform_permission', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.check_permission.updated', 'v1', 'TMF672', 'checkPermission', 'platform_admin_security.platform_permission', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.check_permission.stateChanged', 'v1', 'TMF672', 'checkPermission', 'platform_admin_security.platform_permission', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.check_permission.deleted', 'v1', 'TMF672', 'checkPermission', 'platform_admin_security.platform_permission', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF672', 'permissionSet', '/permissionSet', 'platform_permission', 'Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns.', 'references/tmforum-open-apis/openapi-specs/TMF672_UserRolesPermissions/TMF672-User_Role_Permission_Management_API-v5.1.0.oas.yaml', '[]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.permission_set.created', 'v1', 'TMF672', 'permissionSet', 'platform_admin_security.platform_permission', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.permission_set.updated', 'v1', 'TMF672', 'permissionSet', 'platform_admin_security.platform_permission', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.permission_set.stateChanged', 'v1', 'TMF672', 'permissionSet', 'platform_admin_security.platform_permission', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.permission_set.deleted', 'v1', 'TMF672', 'permissionSet', 'platform_admin_security.platform_permission', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF672', 'permissionSpecification', '/permissionSpecification', 'platform_permission', 'Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns.', 'references/tmforum-open-apis/openapi-specs/TMF672_UserRolesPermissions/TMF672-User_Role_Permission_Management_API-v5.1.0.oas.yaml', '[]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.permission_specification.created', 'v1', 'TMF672', 'permissionSpecification', 'platform_admin_security.platform_permission', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.permission_specification.updated', 'v1', 'TMF672', 'permissionSpecification', 'platform_admin_security.platform_permission', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.permission_specification.stateChanged', 'v1', 'TMF672', 'permissionSpecification', 'platform_admin_security.platform_permission', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.permission_specification.deleted', 'v1', 'TMF672', 'permissionSpecification', 'platform_admin_security.platform_permission', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF672', 'permissionSpecificationSet', '/permissionSpecificationSet', 'platform_permission', 'Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns.', 'references/tmforum-open-apis/openapi-specs/TMF672_UserRolesPermissions/TMF672-User_Role_Permission_Management_API-v5.1.0.oas.yaml', '[]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.permission_specification_set.created', 'v1', 'TMF672', 'permissionSpecificationSet', 'platform_admin_security.platform_permission', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.permission_specification_set.updated', 'v1', 'TMF672', 'permissionSpecificationSet', 'platform_admin_security.platform_permission', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.permission_specification_set.stateChanged', 'v1', 'TMF672', 'permissionSpecificationSet', 'platform_admin_security.platform_permission', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.permission_specification_set.deleted', 'v1', 'TMF672', 'permissionSpecificationSet', 'platform_admin_security.platform_permission', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF720', 'digitalIdentity', '/digitalIdentity', 'platform_user', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF720_DigitalIdentity/TMF720_Digital_Identity_Management_API_v4.0.0_swagger.json', '["id", "href", "creationDate", "lastUpdate", "nickname", "status", "attachment", "contactMedium", "credential", "individualIdentified", "partyRoleIdentified", "relatedParty", "resourceIdentified", "validFor", "@baseType", "@schemaLocation"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.digital_identity.created', 'v1', 'TMF720', 'digitalIdentity', 'platform_admin_security.platform_user', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.digital_identity.updated', 'v1', 'TMF720', 'digitalIdentity', 'platform_admin_security.platform_user', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.digital_identity.stateChanged', 'v1', 'TMF720', 'digitalIdentity', 'platform_admin_security.platform_user', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.digital_identity.deleted', 'v1', 'TMF720', 'digitalIdentity', 'platform_admin_security.platform_user', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF691', 'userinfo', '/userinfo', 'platform_user', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF691_FederatedIdentity/TMF691-FederatedIdentity-v4.0.0.swagger.json', '["birthdate", "email", "email_verified", "family_name", "gender", "given_name", "locale", "middle_name", "name", "nickname", "phone_number", "phone_number_verified", "picture", "preferred_username", "profile", "sub"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.userinfo.created', 'v1', 'TMF691', 'userinfo', 'platform_admin_security.platform_user', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.userinfo.updated', 'v1', 'TMF691', 'userinfo', 'platform_admin_security.platform_user', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.userinfo.stateChanged', 'v1', 'TMF691', 'userinfo', 'platform_admin_security.platform_user', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.userinfo.deleted', 'v1', 'TMF691', 'userinfo', 'platform_admin_security.platform_user', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF696', 'partyRoleProductOfferingRiskAssessment', '/partyRoleProductOfferingRiskAssessment', 'platform_role', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement/TMF696_Risk_Management_API_v4.0.0_swagger.json', '["id", "href", "status", "characteristic", "partyRole", "place", "productOffering", "riskAssessmentResult", "@baseType", "@schemaLocation", "@type"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_role_product_offering_risk_assessment.created', 'v1', 'TMF696', 'partyRoleProductOfferingRiskAssessment', 'platform_admin_security.platform_role', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_role_product_offering_risk_assessment.updated', 'v1', 'TMF696', 'partyRoleProductOfferingRiskAssessment', 'platform_admin_security.platform_role', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_role_product_offering_risk_assessment.stateChanged', 'v1', 'TMF696', 'partyRoleProductOfferingRiskAssessment', 'platform_admin_security.platform_role', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_role_product_offering_risk_assessment.deleted', 'v1', 'TMF696', 'partyRoleProductOfferingRiskAssessment', 'platform_admin_security.platform_role', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF696', 'partyRoleRiskAssessment', '/partyRoleRiskAssessment', 'platform_role', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement/TMF696_Risk_Management_API_v4.0.0_swagger.json', '["id", "href", "status", "characteristic", "place", "riskAssessmentResult", "@baseType", "@schemaLocation", "@type"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_role_risk_assessment.created', 'v1', 'TMF696', 'partyRoleRiskAssessment', 'platform_admin_security.platform_role', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_role_risk_assessment.updated', 'v1', 'TMF696', 'partyRoleRiskAssessment', 'platform_admin_security.platform_role', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_role_risk_assessment.stateChanged', 'v1', 'TMF696', 'partyRoleRiskAssessment', 'platform_admin_security.platform_role', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_role_risk_assessment.deleted', 'v1', 'TMF696', 'partyRoleRiskAssessment', 'platform_admin_security.platform_role', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF696', 'productOfferingRiskAssessment', '/productOfferingRiskAssessment', 'tenant', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement/TMF696_Risk_Management_API_v4.0.0_swagger.json', '["id", "href", "status", "characteristic", "partyRole", "place", "productOffering", "riskAssessmentResult", "@baseType", "@schemaLocation", "@type"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.product_offering_risk_assessment.created', 'v1', 'TMF696', 'productOfferingRiskAssessment', 'platform_admin_security.tenant', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.product_offering_risk_assessment.updated', 'v1', 'TMF696', 'productOfferingRiskAssessment', 'platform_admin_security.tenant', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.product_offering_risk_assessment.stateChanged', 'v1', 'TMF696', 'productOfferingRiskAssessment', 'platform_admin_security.tenant', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.product_offering_risk_assessment.deleted', 'v1', 'TMF696', 'productOfferingRiskAssessment', 'platform_admin_security.tenant', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF696', 'productOrderRiskAssessment', '/productOrderRiskAssessment', 'tenant', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement/TMF696_Risk_Management_API_v4.0.0_swagger.json', '["id", "href", "status", "characteristic", "place", "productOrder", "riskAssessmentResult", "@baseType", "@schemaLocation", "@type"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.product_order_risk_assessment.created', 'v1', 'TMF696', 'productOrderRiskAssessment', 'platform_admin_security.tenant', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.product_order_risk_assessment.updated', 'v1', 'TMF696', 'productOrderRiskAssessment', 'platform_admin_security.tenant', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.product_order_risk_assessment.stateChanged', 'v1', 'TMF696', 'productOrderRiskAssessment', 'platform_admin_security.tenant', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.product_order_risk_assessment.deleted', 'v1', 'TMF696', 'productOrderRiskAssessment', 'platform_admin_security.tenant', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF696', 'shoppingCartRiskAssessment', '/shoppingCartRiskAssessment', 'tenant', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement/TMF696_Risk_Management_API_v4.0.0_swagger.json', '["id", "href", "status", "characteristic", "place", "riskAssessmentResult", "shoppingCart", "@baseType", "@schemaLocation", "@type"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.shopping_cart_risk_assessment.created', 'v1', 'TMF696', 'shoppingCartRiskAssessment', 'platform_admin_security.tenant', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.shopping_cart_risk_assessment.updated', 'v1', 'TMF696', 'shoppingCartRiskAssessment', 'platform_admin_security.tenant', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.shopping_cart_risk_assessment.stateChanged', 'v1', 'TMF696', 'shoppingCartRiskAssessment', 'platform_admin_security.tenant', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.shopping_cart_risk_assessment.deleted', 'v1', 'TMF696', 'shoppingCartRiskAssessment', 'platform_admin_security.tenant', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF644', 'partyPrivacyAgreement', '/partyPrivacyAgreement', 'tenant', 'Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns.', 'references/tmforum-open-apis/openapi-specs/TMF644_Privacy/TMF644-Privacy-v5.0.0.oas.yaml', '[]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_privacy_agreement.created', 'v1', 'TMF644', 'partyPrivacyAgreement', 'platform_admin_security.tenant', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_privacy_agreement.updated', 'v1', 'TMF644', 'partyPrivacyAgreement', 'platform_admin_security.tenant', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_privacy_agreement.stateChanged', 'v1', 'TMF644', 'partyPrivacyAgreement', 'platform_admin_security.tenant', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_privacy_agreement.deleted', 'v1', 'TMF644', 'partyPrivacyAgreement', 'platform_admin_security.tenant', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF644', 'partyPrivacyProfile', '/partyPrivacyProfile', 'tenant', 'Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns.', 'references/tmforum-open-apis/openapi-specs/TMF644_Privacy/TMF644-Privacy-v5.0.0.oas.yaml', '[]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_privacy_profile.created', 'v1', 'TMF644', 'partyPrivacyProfile', 'platform_admin_security.tenant', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_privacy_profile.updated', 'v1', 'TMF644', 'partyPrivacyProfile', 'platform_admin_security.tenant', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_privacy_profile.stateChanged', 'v1', 'TMF644', 'partyPrivacyProfile', 'platform_admin_security.tenant', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_privacy_profile.deleted', 'v1', 'TMF644', 'partyPrivacyProfile', 'platform_admin_security.tenant', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF644', 'partyPrivacyProfileSpecification', '/partyPrivacyProfileSpecification', 'tenant', 'Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns.', 'references/tmforum-open-apis/openapi-specs/TMF644_Privacy/TMF644-Privacy-v5.0.0.oas.yaml', '[]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_privacy_profile_specification.created', 'v1', 'TMF644', 'partyPrivacyProfileSpecification', 'platform_admin_security.tenant', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_privacy_profile_specification.updated', 'v1', 'TMF644', 'partyPrivacyProfileSpecification', 'platform_admin_security.tenant', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_privacy_profile_specification.stateChanged', 'v1', 'TMF644', 'partyPrivacyProfileSpecification', 'platform_admin_security.tenant', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.party_privacy_profile_specification.deleted', 'v1', 'TMF644', 'partyPrivacyProfileSpecification', 'platform_admin_security.tenant', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF667', 'document', '/document', 'tenant', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF667_Document/TMF667_Document_Management_API_v4.0.0_swagger.json', '["id", "href", "creationDate", "description", "documentType", "lastUpdate", "name", "version", "attachment", "category", "characteristic", "document", "documentSpecification", "externalIdentifier", "relatedEntity", "relatedParty"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.document.created', 'v1', 'TMF667', 'document', 'platform_admin_security.tenant', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.document.updated', 'v1', 'TMF667', 'document', 'platform_admin_security.tenant', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.document.stateChanged', 'v1', 'TMF667', 'document', 'platform_admin_security.tenant', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.document.deleted', 'v1', 'TMF667', 'document', 'platform_admin_security.tenant', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF667', 'documentSpecification', '/documentSpecification', 'tenant', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF667_Document/TMF667_Document_Management_API_v4.0.0_swagger.json', '["id", "href", "description", "isBundle", "lastUpdate", "name", "version", "attachment", "constraint", "entitySpecRelationship", "lifecycleStatus", "relatedParty", "specCharacteristic", "targetEntitySchema", "validFor", "@baseType"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.document_specification.created', 'v1', 'TMF667', 'documentSpecification', 'platform_admin_security.tenant', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.document_specification.updated', 'v1', 'TMF667', 'documentSpecification', 'platform_admin_security.tenant', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.document_specification.stateChanged', 'v1', 'TMF667', 'documentSpecification', 'platform_admin_security.tenant', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO platform_admin_security.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('platform_admin_security.document_specification.deleted', 'v1', 'TMF667', 'documentSpecification', 'platform_admin_security.tenant', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();

INSERT INTO platform_admin_security.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('platform_admin_security.tenant', 'platform_admin_security', 'restricted', 'regulated_lifecycle', 'Suite data model and TMF API baseline review', 2555, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Mask direct identifiers, secrets, payment details, and sensitive evidence outside privileged roles.', 'high') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO platform_admin_security.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('platform_admin_security.environment', 'platform_admin_security', 'restricted', 'regulated_lifecycle', 'Suite data model and TMF API baseline review', 2555, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Mask direct identifiers, secrets, payment details, and sensitive evidence outside privileged roles.', 'high') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO platform_admin_security.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('platform_admin_security.platform_user', 'platform_admin_security', 'restricted', 'regulated_lifecycle', 'Suite data model and TMF API baseline review', 2555, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Mask direct identifiers, secrets, payment details, and sensitive evidence outside privileged roles.', 'high') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO platform_admin_security.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('platform_admin_security.platform_role', 'platform_admin_security', 'restricted', 'regulated_lifecycle', 'Suite data model and TMF API baseline review', 2555, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Mask direct identifiers, secrets, payment details, and sensitive evidence outside privileged roles.', 'high') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO platform_admin_security.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('platform_admin_security.platform_permission', 'platform_admin_security', 'restricted', 'regulated_lifecycle', 'Suite data model and TMF API baseline review', 2555, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Mask direct identifiers, secrets, payment details, and sensitive evidence outside privileged roles.', 'high') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO platform_admin_security.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('platform_admin_security.user_group', 'platform_admin_security', 'restricted', 'regulated_lifecycle', 'Suite data model and TMF API baseline review', 2555, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Mask direct identifiers, secrets, payment details, and sensitive evidence outside privileged roles.', 'high') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO platform_admin_security.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('platform_admin_security.authorization_policy', 'platform_admin_security', 'restricted', 'regulated_lifecycle', 'Suite data model and TMF API baseline review', 2555, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Mask direct identifiers, secrets, payment details, and sensitive evidence outside privileged roles.', 'high') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO platform_admin_security.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('platform_admin_security.platform_configuration', 'platform_admin_security', 'restricted', 'regulated_lifecycle', 'Suite data model and TMF API baseline review', 2555, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Mask direct identifiers, secrets, payment details, and sensitive evidence outside privileged roles.', 'high') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO platform_admin_security.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('platform_admin_security.secret_certificate_metadata', 'platform_admin_security', 'restricted', 'regulated_lifecycle', 'Suite data model and TMF API baseline review', 2555, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Mask direct identifiers, secrets, payment details, and sensitive evidence outside privileged roles.', 'high') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO platform_admin_security.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('platform_admin_security.access_audit_reference', 'platform_admin_security', 'restricted', 'regulated_lifecycle', 'Suite data model and TMF API baseline review', 2555, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Mask direct identifiers, secrets, payment details, and sensitive evidence outside privileged roles.', 'high') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO platform_admin_security.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('platform_admin_security.event_outbox', 'platform_admin_security', 'restricted', 'regulated_lifecycle', 'Suite data model and TMF API baseline review', 2555, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Mask direct identifiers, secrets, payment details, and sensitive evidence outside privileged roles.', 'high') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();

COMMIT;
