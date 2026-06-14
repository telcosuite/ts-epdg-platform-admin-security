-- TelcoSuite starter DDL for Enterprise Platform, Data, And Governance
-- Target database: ts_enterprise_platform_governance
-- Source model: planning/suite-details/06-enterprise-platform-data-governance/data-model.md
-- Migration type: Flyway SQL migration, run while connected to ts_enterprise_platform_governance.
-- Purpose: create app schemas, starter tables, standard controls, and app event outboxes.

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE SCHEMA IF NOT EXISTS integration_api_eventing;
COMMENT ON SCHEMA integration_api_eventing IS 'App-owned schema for Integration, Eventing, And API Platform in Enterprise Platform, Data, And Governance.';
CREATE SCHEMA IF NOT EXISTS platform_admin_security;
COMMENT ON SCHEMA platform_admin_security IS 'App-owned schema for Platform Admin And Security in Enterprise Platform, Data, And Governance.';
CREATE SCHEMA IF NOT EXISTS security_compliance_regulatory;
COMMENT ON SCHEMA security_compliance_regulatory IS 'App-owned schema for Security Operations, Compliance, And Regulatory in Enterprise Platform, Data, And Governance.';
CREATE SCHEMA IF NOT EXISTS workflow_automation;
COMMENT ON SCHEMA workflow_automation IS 'App-owned schema for Workflow And Automation Studio in Enterprise Platform, Data, And Governance.';
CREATE SCHEMA IF NOT EXISTS data_reporting_intelligence;
COMMENT ON SCHEMA data_reporting_intelligence IS 'App-owned schema for Data, Reporting, And Intelligence in Enterprise Platform, Data, And Governance.';
CREATE SCHEMA IF NOT EXISTS test_certification_lab;
COMMENT ON SCHEMA test_certification_lab IS 'App-owned schema for Test And Certification Lab in Enterprise Platform, Data, And Governance.';

CREATE TABLE IF NOT EXISTS integration_api_eventing.api_contract (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_integrati_api_contract_canonica_fed85a0b UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_integrati_api_contract_version_8e091d4a CHECK (version > 0),
    CONSTRAINT ck_integrati_api_contract_validity_b0b189c1 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_integrati_api_contract_canonica_1be828d0 ON integration_api_eventing.api_contract (canonical_id);
CREATE INDEX IF NOT EXISTS ix_integrati_api_contract_status_4d2e1a7a ON integration_api_eventing.api_contract (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_integrati_api_contract_updated_1eeb4467 ON integration_api_eventing.api_contract (updated_at);
CREATE INDEX IF NOT EXISTS ix_integrati_api_contract_source_e1ff6dac ON integration_api_eventing.api_contract (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_integrati_api_contract_attrgin_a6963346 ON integration_api_eventing.api_contract USING gin (attributes);
COMMENT ON TABLE integration_api_eventing.api_contract IS 'Starter table for Integration, Eventing, And API Platform. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN integration_api_eventing.api_contract.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN integration_api_eventing.api_contract.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN integration_api_eventing.api_contract.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS integration_api_eventing.api_contract_version (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_integrati_api_contract_version_canonica_261de368 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_integrati_api_contract_version_version_e8bcedcc CHECK (version > 0),
    CONSTRAINT ck_integrati_api_contract_version_validity_749e3354 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_integrati_api_contract_version_canonica_0292fa99 ON integration_api_eventing.api_contract_version (canonical_id);
CREATE INDEX IF NOT EXISTS ix_integrati_api_contract_version_status_51c4d2f9 ON integration_api_eventing.api_contract_version (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_integrati_api_contract_version_updated_c1404b6b ON integration_api_eventing.api_contract_version (updated_at);
CREATE INDEX IF NOT EXISTS ix_integrati_api_contract_version_source_01d9e31c ON integration_api_eventing.api_contract_version (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_integrati_api_contract_version_attrgin_41bb4dda ON integration_api_eventing.api_contract_version USING gin (attributes);
COMMENT ON TABLE integration_api_eventing.api_contract_version IS 'Starter table for Integration, Eventing, And API Platform. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN integration_api_eventing.api_contract_version.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN integration_api_eventing.api_contract_version.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN integration_api_eventing.api_contract_version.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS integration_api_eventing.event_type (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_integrati_event_type_canonica_1b59c630 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_integrati_event_type_version_ba641b40 CHECK (version > 0),
    CONSTRAINT ck_integrati_event_type_validity_eb3671fa CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_integrati_event_type_canonica_71e5f98d ON integration_api_eventing.event_type (canonical_id);
CREATE INDEX IF NOT EXISTS ix_integrati_event_type_status_102fd9f6 ON integration_api_eventing.event_type (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_integrati_event_type_updated_f0e5e71a ON integration_api_eventing.event_type (updated_at);
CREATE INDEX IF NOT EXISTS ix_integrati_event_type_source_ba0f313d ON integration_api_eventing.event_type (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_integrati_event_type_attrgin_407eae16 ON integration_api_eventing.event_type USING gin (attributes);
COMMENT ON TABLE integration_api_eventing.event_type IS 'Starter table for Integration, Eventing, And API Platform. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN integration_api_eventing.event_type.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN integration_api_eventing.event_type.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN integration_api_eventing.event_type.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS integration_api_eventing.event_subscription (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_integrati_event_subscription_canonica_22934de9 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_integrati_event_subscription_version_aef4738a CHECK (version > 0),
    CONSTRAINT ck_integrati_event_subscription_validity_634a8edd CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_integrati_event_subscription_canonica_2e21e910 ON integration_api_eventing.event_subscription (canonical_id);
CREATE INDEX IF NOT EXISTS ix_integrati_event_subscription_status_db0db0e1 ON integration_api_eventing.event_subscription (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_integrati_event_subscription_updated_f7c46600 ON integration_api_eventing.event_subscription (updated_at);
CREATE INDEX IF NOT EXISTS ix_integrati_event_subscription_source_3bdd6ddd ON integration_api_eventing.event_subscription (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_integrati_event_subscription_attrgin_607561b9 ON integration_api_eventing.event_subscription USING gin (attributes);
COMMENT ON TABLE integration_api_eventing.event_subscription IS 'Starter table for Integration, Eventing, And API Platform. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN integration_api_eventing.event_subscription.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN integration_api_eventing.event_subscription.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN integration_api_eventing.event_subscription.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS integration_api_eventing.gateway_policy (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_integrati_gateway_policy_canonica_3f021fe0 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_integrati_gateway_policy_version_fadcf5a2 CHECK (version > 0),
    CONSTRAINT ck_integrati_gateway_policy_validity_129c1e7f CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_integrati_gateway_policy_canonica_b7fba044 ON integration_api_eventing.gateway_policy (canonical_id);
CREATE INDEX IF NOT EXISTS ix_integrati_gateway_policy_status_5806875b ON integration_api_eventing.gateway_policy (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_integrati_gateway_policy_updated_f2957ae2 ON integration_api_eventing.gateway_policy (updated_at);
CREATE INDEX IF NOT EXISTS ix_integrati_gateway_policy_source_6957c13c ON integration_api_eventing.gateway_policy (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_integrati_gateway_policy_attrgin_364a2ad9 ON integration_api_eventing.gateway_policy USING gin (attributes);
COMMENT ON TABLE integration_api_eventing.gateway_policy IS 'Starter table for Integration, Eventing, And API Platform. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN integration_api_eventing.gateway_policy.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN integration_api_eventing.gateway_policy.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN integration_api_eventing.gateway_policy.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS integration_api_eventing.api_route (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_integrati_api_route_canonica_bcdfacda UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_integrati_api_route_version_e5591b8d CHECK (version > 0),
    CONSTRAINT ck_integrati_api_route_validity_77356aba CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_integrati_api_route_canonica_ce39b8b2 ON integration_api_eventing.api_route (canonical_id);
CREATE INDEX IF NOT EXISTS ix_integrati_api_route_status_9951b415 ON integration_api_eventing.api_route (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_integrati_api_route_updated_595b4e5d ON integration_api_eventing.api_route (updated_at);
CREATE INDEX IF NOT EXISTS ix_integrati_api_route_source_92380ad3 ON integration_api_eventing.api_route (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_integrati_api_route_attrgin_afb16825 ON integration_api_eventing.api_route USING gin (attributes);
COMMENT ON TABLE integration_api_eventing.api_route IS 'Starter table for Integration, Eventing, And API Platform. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN integration_api_eventing.api_route.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN integration_api_eventing.api_route.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN integration_api_eventing.api_route.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS integration_api_eventing.integration_adapter (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_integrati_integration_adapter_canonica_c7559aad UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_integrati_integration_adapter_version_eaa1e753 CHECK (version > 0),
    CONSTRAINT ck_integrati_integration_adapter_validity_e980c629 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_integrati_integration_adapter_canonica_4696e4ce ON integration_api_eventing.integration_adapter (canonical_id);
CREATE INDEX IF NOT EXISTS ix_integrati_integration_adapter_status_07fd1154 ON integration_api_eventing.integration_adapter (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_integrati_integration_adapter_updated_2856c956 ON integration_api_eventing.integration_adapter (updated_at);
CREATE INDEX IF NOT EXISTS ix_integrati_integration_adapter_source_4ec200ac ON integration_api_eventing.integration_adapter (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_integrati_integration_adapter_attrgin_eaba07ce ON integration_api_eventing.integration_adapter USING gin (attributes);
COMMENT ON TABLE integration_api_eventing.integration_adapter IS 'Starter table for Integration, Eventing, And API Platform. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN integration_api_eventing.integration_adapter.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN integration_api_eventing.integration_adapter.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN integration_api_eventing.integration_adapter.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS integration_api_eventing.mapping_rule (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_integrati_mapping_rule_canonica_9eb60c88 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_integrati_mapping_rule_version_d0579c28 CHECK (version > 0),
    CONSTRAINT ck_integrati_mapping_rule_validity_1bb9798c CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_integrati_mapping_rule_canonica_e7211ba6 ON integration_api_eventing.mapping_rule (canonical_id);
CREATE INDEX IF NOT EXISTS ix_integrati_mapping_rule_status_507aac63 ON integration_api_eventing.mapping_rule (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_integrati_mapping_rule_updated_00137a9d ON integration_api_eventing.mapping_rule (updated_at);
CREATE INDEX IF NOT EXISTS ix_integrati_mapping_rule_source_8d4593ff ON integration_api_eventing.mapping_rule (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_integrati_mapping_rule_attrgin_dab58ed2 ON integration_api_eventing.mapping_rule USING gin (attributes);
COMMENT ON TABLE integration_api_eventing.mapping_rule IS 'Starter table for Integration, Eventing, And API Platform. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN integration_api_eventing.mapping_rule.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN integration_api_eventing.mapping_rule.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN integration_api_eventing.mapping_rule.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS integration_api_eventing.notification_delivery_attempt (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_integrati_notification_delivery_atte_canonica_461eae8d UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_integrati_notification_delivery_atte_version_d4a0d0b2 CHECK (version > 0),
    CONSTRAINT ck_integrati_notification_delivery_atte_validity_2ddbf91f CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_integrati_notification_delivery_atte_canonica_613b202e ON integration_api_eventing.notification_delivery_attempt (canonical_id);
CREATE INDEX IF NOT EXISTS ix_integrati_notification_delivery_atte_status_2f67e29a ON integration_api_eventing.notification_delivery_attempt (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_integrati_notification_delivery_atte_updated_c93b655f ON integration_api_eventing.notification_delivery_attempt (updated_at);
CREATE INDEX IF NOT EXISTS ix_integrati_notification_delivery_atte_source_775ae1d5 ON integration_api_eventing.notification_delivery_attempt (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_integrati_notification_delivery_atte_attrgin_72d4dc8a ON integration_api_eventing.notification_delivery_attempt USING gin (attributes);
COMMENT ON TABLE integration_api_eventing.notification_delivery_attempt IS 'Starter table for Integration, Eventing, And API Platform. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN integration_api_eventing.notification_delivery_attempt.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN integration_api_eventing.notification_delivery_attempt.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN integration_api_eventing.notification_delivery_attempt.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS integration_api_eventing.trace_reference (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_integrati_trace_reference_canonica_79145c30 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_integrati_trace_reference_version_60d42069 CHECK (version > 0),
    CONSTRAINT ck_integrati_trace_reference_validity_f425cbc9 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_integrati_trace_reference_canonica_444a6920 ON integration_api_eventing.trace_reference (canonical_id);
CREATE INDEX IF NOT EXISTS ix_integrati_trace_reference_status_1449e4a1 ON integration_api_eventing.trace_reference (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_integrati_trace_reference_updated_3deb2488 ON integration_api_eventing.trace_reference (updated_at);
CREATE INDEX IF NOT EXISTS ix_integrati_trace_reference_source_4e7cc918 ON integration_api_eventing.trace_reference (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_integrati_trace_reference_attrgin_f537a0f5 ON integration_api_eventing.trace_reference USING gin (attributes);
COMMENT ON TABLE integration_api_eventing.trace_reference IS 'Starter table for Integration, Eventing, And API Platform. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN integration_api_eventing.trace_reference.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN integration_api_eventing.trace_reference.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN integration_api_eventing.trace_reference.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS integration_api_eventing.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_integrati_event_outbox_status_33fdcf4d CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_integrati_event_outbox_publish_d4621438 ON integration_api_eventing.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_integrati_event_outbox_eventkey_93c4b504 ON integration_api_eventing.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_integrati_event_outbox_agg_077b759a ON integration_api_eventing.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE integration_api_eventing.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS platform_admin_security.tenant (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_platform__tenant_canonica_806c4536 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_platform__tenant_version_7064153f CHECK (version > 0),
    CONSTRAINT ck_platform__tenant_validity_b81f8c75 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_platform__tenant_canonica_a26cfb8a ON platform_admin_security.tenant (canonical_id);
CREATE INDEX IF NOT EXISTS ix_platform__tenant_status_babb77c1 ON platform_admin_security.tenant (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_platform__tenant_updated_57f4fdf9 ON platform_admin_security.tenant (updated_at);
CREATE INDEX IF NOT EXISTS ix_platform__tenant_source_162cf2d2 ON platform_admin_security.tenant (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform__tenant_attrgin_20477a73 ON platform_admin_security.tenant USING gin (attributes);
COMMENT ON TABLE platform_admin_security.tenant IS 'Starter table for Platform Admin And Security. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN platform_admin_security.tenant.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN platform_admin_security.tenant.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN platform_admin_security.tenant.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS platform_admin_security.environment (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_platform__environment_canonica_8a49f418 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_platform__environment_version_e947d5c8 CHECK (version > 0),
    CONSTRAINT ck_platform__environment_validity_d06b7c86 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_platform__environment_canonica_ea69ad7c ON platform_admin_security.environment (canonical_id);
CREATE INDEX IF NOT EXISTS ix_platform__environment_status_2275c583 ON platform_admin_security.environment (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_platform__environment_updated_af3983cf ON platform_admin_security.environment (updated_at);
CREATE INDEX IF NOT EXISTS ix_platform__environment_source_bd79ddbb ON platform_admin_security.environment (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform__environment_attrgin_9fcb283e ON platform_admin_security.environment USING gin (attributes);
COMMENT ON TABLE platform_admin_security.environment IS 'Starter table for Platform Admin And Security. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN platform_admin_security.environment.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN platform_admin_security.environment.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN platform_admin_security.environment.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS platform_admin_security.platform_user (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_platform__platform_user_canonica_6f7a45af UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_platform__platform_user_version_ec6ffcd1 CHECK (version > 0),
    CONSTRAINT ck_platform__platform_user_validity_a73e5e00 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_platform__platform_user_canonica_01440d81 ON platform_admin_security.platform_user (canonical_id);
CREATE INDEX IF NOT EXISTS ix_platform__platform_user_status_3c0f3702 ON platform_admin_security.platform_user (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_platform__platform_user_updated_97379fea ON platform_admin_security.platform_user (updated_at);
CREATE INDEX IF NOT EXISTS ix_platform__platform_user_source_678e0e23 ON platform_admin_security.platform_user (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform__platform_user_attrgin_abbfaaa1 ON platform_admin_security.platform_user USING gin (attributes);
COMMENT ON TABLE platform_admin_security.platform_user IS 'Starter table for Platform Admin And Security. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN platform_admin_security.platform_user.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN platform_admin_security.platform_user.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN platform_admin_security.platform_user.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS platform_admin_security.platform_role (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_platform__role_canonica_7ea679b8 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_platform__role_version_f99f37ea CHECK (version > 0),
    CONSTRAINT ck_platform__role_validity_984e13ca CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_platform__role_canonica_9d940ed3 ON platform_admin_security.platform_role (canonical_id);
CREATE INDEX IF NOT EXISTS ix_platform__role_status_6e79a09a ON platform_admin_security.platform_role (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_platform__role_updated_8cc84242 ON platform_admin_security.platform_role (updated_at);
CREATE INDEX IF NOT EXISTS ix_platform__role_source_93300c01 ON platform_admin_security.platform_role (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform__role_attrgin_1d827f7c ON platform_admin_security.platform_role USING gin (attributes);
COMMENT ON TABLE platform_admin_security.platform_role IS 'Starter table for Platform Admin And Security. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN platform_admin_security.platform_role.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN platform_admin_security.platform_role.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN platform_admin_security.platform_role.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS platform_admin_security.platform_permission (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_platform__permission_canonica_1bf93b59 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_platform__permission_version_50d5a21c CHECK (version > 0),
    CONSTRAINT ck_platform__permission_validity_1a7267fe CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_platform__permission_canonica_66f50dcb ON platform_admin_security.platform_permission (canonical_id);
CREATE INDEX IF NOT EXISTS ix_platform__permission_status_56416d05 ON platform_admin_security.platform_permission (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_platform__permission_updated_800c2857 ON platform_admin_security.platform_permission (updated_at);
CREATE INDEX IF NOT EXISTS ix_platform__permission_source_6c1463e1 ON platform_admin_security.platform_permission (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform__permission_attrgin_2b305bb6 ON platform_admin_security.platform_permission USING gin (attributes);
COMMENT ON TABLE platform_admin_security.platform_permission IS 'Starter table for Platform Admin And Security. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN platform_admin_security.platform_permission.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN platform_admin_security.platform_permission.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN platform_admin_security.platform_permission.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS platform_admin_security.user_group (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_platform__user_group_canonica_c1b721e9 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_platform__user_group_version_8367aac4 CHECK (version > 0),
    CONSTRAINT ck_platform__user_group_validity_dd2b81ba CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_platform__user_group_canonica_44a83e51 ON platform_admin_security.user_group (canonical_id);
CREATE INDEX IF NOT EXISTS ix_platform__user_group_status_59e12e80 ON platform_admin_security.user_group (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_platform__user_group_updated_4e94c0f8 ON platform_admin_security.user_group (updated_at);
CREATE INDEX IF NOT EXISTS ix_platform__user_group_source_d9cbe67f ON platform_admin_security.user_group (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform__user_group_attrgin_55d81f8a ON platform_admin_security.user_group USING gin (attributes);
COMMENT ON TABLE platform_admin_security.user_group IS 'Starter table for Platform Admin And Security. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN platform_admin_security.user_group.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN platform_admin_security.user_group.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN platform_admin_security.user_group.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS platform_admin_security.authorization_policy (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_platform__authorization_policy_canonica_e86b5a0c UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_platform__authorization_policy_version_2ad3815a CHECK (version > 0),
    CONSTRAINT ck_platform__authorization_policy_validity_69f3edf6 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_platform__authorization_policy_canonica_a124db91 ON platform_admin_security.authorization_policy (canonical_id);
CREATE INDEX IF NOT EXISTS ix_platform__authorization_policy_status_4f29dfc8 ON platform_admin_security.authorization_policy (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_platform__authorization_policy_updated_a6191d98 ON platform_admin_security.authorization_policy (updated_at);
CREATE INDEX IF NOT EXISTS ix_platform__authorization_policy_source_733706a2 ON platform_admin_security.authorization_policy (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform__authorization_policy_attrgin_30fac87a ON platform_admin_security.authorization_policy USING gin (attributes);
COMMENT ON TABLE platform_admin_security.authorization_policy IS 'Starter table for Platform Admin And Security. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN platform_admin_security.authorization_policy.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN platform_admin_security.authorization_policy.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN platform_admin_security.authorization_policy.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS platform_admin_security.platform_configuration (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_platform__platform_configuration_canonica_94251e6d UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_platform__platform_configuration_version_11aad891 CHECK (version > 0),
    CONSTRAINT ck_platform__platform_configuration_validity_48377d66 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_platform__platform_configuration_canonica_9ff18fdc ON platform_admin_security.platform_configuration (canonical_id);
CREATE INDEX IF NOT EXISTS ix_platform__platform_configuration_status_9cde9628 ON platform_admin_security.platform_configuration (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_platform__platform_configuration_updated_a037bb44 ON platform_admin_security.platform_configuration (updated_at);
CREATE INDEX IF NOT EXISTS ix_platform__platform_configuration_source_2a166b16 ON platform_admin_security.platform_configuration (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform__platform_configuration_attrgin_1b18b75e ON platform_admin_security.platform_configuration USING gin (attributes);
COMMENT ON TABLE platform_admin_security.platform_configuration IS 'Starter table for Platform Admin And Security. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN platform_admin_security.platform_configuration.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN platform_admin_security.platform_configuration.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN platform_admin_security.platform_configuration.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS platform_admin_security.secret_certificate_metadata (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_platform__secret_certificate_metadat_canonica_3b44a289 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_platform__secret_certificate_metadat_version_dc77e563 CHECK (version > 0),
    CONSTRAINT ck_platform__secret_certificate_metadat_validity_8b70af57 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_platform__secret_certificate_metadat_canonica_a3a42844 ON platform_admin_security.secret_certificate_metadata (canonical_id);
CREATE INDEX IF NOT EXISTS ix_platform__secret_certificate_metadat_status_3f1f11fd ON platform_admin_security.secret_certificate_metadata (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_platform__secret_certificate_metadat_updated_4c393661 ON platform_admin_security.secret_certificate_metadata (updated_at);
CREATE INDEX IF NOT EXISTS ix_platform__secret_certificate_metadat_source_2fcae14e ON platform_admin_security.secret_certificate_metadata (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform__secret_certificate_metadat_attrgin_585c463c ON platform_admin_security.secret_certificate_metadata USING gin (attributes);
COMMENT ON TABLE platform_admin_security.secret_certificate_metadata IS 'Starter table for Platform Admin And Security. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN platform_admin_security.secret_certificate_metadata.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN platform_admin_security.secret_certificate_metadata.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN platform_admin_security.secret_certificate_metadata.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS platform_admin_security.access_audit_reference (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_platform__access_audit_reference_canonica_0b28ed16 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_platform__access_audit_reference_version_f19ab4b2 CHECK (version > 0),
    CONSTRAINT ck_platform__access_audit_reference_validity_11efa9f0 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_platform__access_audit_reference_canonica_f3ba819b ON platform_admin_security.access_audit_reference (canonical_id);
CREATE INDEX IF NOT EXISTS ix_platform__access_audit_reference_status_d2452346 ON platform_admin_security.access_audit_reference (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_platform__access_audit_reference_updated_d4f67976 ON platform_admin_security.access_audit_reference (updated_at);
CREATE INDEX IF NOT EXISTS ix_platform__access_audit_reference_source_33abec57 ON platform_admin_security.access_audit_reference (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_platform__access_audit_reference_attrgin_ba39358f ON platform_admin_security.access_audit_reference USING gin (attributes);
COMMENT ON TABLE platform_admin_security.access_audit_reference IS 'Starter table for Platform Admin And Security. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN platform_admin_security.access_audit_reference.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN platform_admin_security.access_audit_reference.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN platform_admin_security.access_audit_reference.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS platform_admin_security.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_platform__event_outbox_status_f4a6529f CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_platform__event_outbox_publish_42f54714 ON platform_admin_security.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_platform__event_outbox_eventkey_68f5b6e5 ON platform_admin_security.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_platform__event_outbox_agg_b7cfafaa ON platform_admin_security.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE platform_admin_security.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS security_compliance_regulatory.security_incident (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_security__security_incident_canonica_2533ddcd UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_security__security_incident_version_3b3d6b36 CHECK (version > 0),
    CONSTRAINT ck_security__security_incident_validity_81942b0f CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_security__security_incident_canonica_a0362dbb ON security_compliance_regulatory.security_incident (canonical_id);
CREATE INDEX IF NOT EXISTS ix_security__security_incident_status_69b6a053 ON security_compliance_regulatory.security_incident (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_security__security_incident_updated_4c165d58 ON security_compliance_regulatory.security_incident (updated_at);
CREATE INDEX IF NOT EXISTS ix_security__security_incident_source_9c019449 ON security_compliance_regulatory.security_incident (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_security__security_incident_attrgin_2338d91e ON security_compliance_regulatory.security_incident USING gin (attributes);
COMMENT ON TABLE security_compliance_regulatory.security_incident IS 'Starter table for Security Operations, Compliance, And Regulatory. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN security_compliance_regulatory.security_incident.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN security_compliance_regulatory.security_incident.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN security_compliance_regulatory.security_incident.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS security_compliance_regulatory.compliance_control (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_security__compliance_control_canonica_827cb42e UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_security__compliance_control_version_9b946731 CHECK (version > 0),
    CONSTRAINT ck_security__compliance_control_validity_38767d00 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_security__compliance_control_canonica_e0e1a65b ON security_compliance_regulatory.compliance_control (canonical_id);
CREATE INDEX IF NOT EXISTS ix_security__compliance_control_status_bcd406e9 ON security_compliance_regulatory.compliance_control (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_security__compliance_control_updated_be914cbd ON security_compliance_regulatory.compliance_control (updated_at);
CREATE INDEX IF NOT EXISTS ix_security__compliance_control_source_5c3f6165 ON security_compliance_regulatory.compliance_control (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_security__compliance_control_attrgin_a4fb1632 ON security_compliance_regulatory.compliance_control USING gin (attributes);
COMMENT ON TABLE security_compliance_regulatory.compliance_control IS 'Starter table for Security Operations, Compliance, And Regulatory. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN security_compliance_regulatory.compliance_control.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN security_compliance_regulatory.compliance_control.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN security_compliance_regulatory.compliance_control.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS security_compliance_regulatory.control_evidence (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_security__control_evidence_canonica_80b3009e UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_security__control_evidence_version_de1b9514 CHECK (version > 0),
    CONSTRAINT ck_security__control_evidence_validity_f81eacc7 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_security__control_evidence_canonica_d7f7552d ON security_compliance_regulatory.control_evidence (canonical_id);
CREATE INDEX IF NOT EXISTS ix_security__control_evidence_status_dcd75e73 ON security_compliance_regulatory.control_evidence (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_security__control_evidence_updated_ba53b7c3 ON security_compliance_regulatory.control_evidence (updated_at);
CREATE INDEX IF NOT EXISTS ix_security__control_evidence_source_eda14998 ON security_compliance_regulatory.control_evidence (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_security__control_evidence_attrgin_724d75d7 ON security_compliance_regulatory.control_evidence USING gin (attributes);
COMMENT ON TABLE security_compliance_regulatory.control_evidence IS 'Starter table for Security Operations, Compliance, And Regulatory. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN security_compliance_regulatory.control_evidence.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN security_compliance_regulatory.control_evidence.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN security_compliance_regulatory.control_evidence.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS security_compliance_regulatory.regulatory_obligation (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_security__regulatory_obligation_canonica_a646a4fe UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_security__regulatory_obligation_version_7227e216 CHECK (version > 0),
    CONSTRAINT ck_security__regulatory_obligation_validity_590c9a96 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_security__regulatory_obligation_canonica_ff788a0a ON security_compliance_regulatory.regulatory_obligation (canonical_id);
CREATE INDEX IF NOT EXISTS ix_security__regulatory_obligation_status_9a781bcc ON security_compliance_regulatory.regulatory_obligation (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_security__regulatory_obligation_updated_b5b44532 ON security_compliance_regulatory.regulatory_obligation (updated_at);
CREATE INDEX IF NOT EXISTS ix_security__regulatory_obligation_source_7f105ad6 ON security_compliance_regulatory.regulatory_obligation (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_security__regulatory_obligation_attrgin_7cb28698 ON security_compliance_regulatory.regulatory_obligation USING gin (attributes);
COMMENT ON TABLE security_compliance_regulatory.regulatory_obligation IS 'Starter table for Security Operations, Compliance, And Regulatory. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN security_compliance_regulatory.regulatory_obligation.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN security_compliance_regulatory.regulatory_obligation.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN security_compliance_regulatory.regulatory_obligation.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS security_compliance_regulatory.regulatory_submission (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_security__regulatory_submission_canonica_c2b1ba5d UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_security__regulatory_submission_version_721b5de2 CHECK (version > 0),
    CONSTRAINT ck_security__regulatory_submission_validity_4366a207 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_security__regulatory_submission_canonica_f04b69dd ON security_compliance_regulatory.regulatory_submission (canonical_id);
CREATE INDEX IF NOT EXISTS ix_security__regulatory_submission_status_a62a5a75 ON security_compliance_regulatory.regulatory_submission (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_security__regulatory_submission_updated_6051e3e3 ON security_compliance_regulatory.regulatory_submission (updated_at);
CREATE INDEX IF NOT EXISTS ix_security__regulatory_submission_source_6c9bf389 ON security_compliance_regulatory.regulatory_submission (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_security__regulatory_submission_attrgin_fe9fc63a ON security_compliance_regulatory.regulatory_submission USING gin (attributes);
COMMENT ON TABLE security_compliance_regulatory.regulatory_submission IS 'Starter table for Security Operations, Compliance, And Regulatory. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN security_compliance_regulatory.regulatory_submission.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN security_compliance_regulatory.regulatory_submission.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN security_compliance_regulatory.regulatory_submission.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS security_compliance_regulatory.retention_policy (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_security__retention_policy_canonica_f600f39f UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_security__retention_policy_version_d452d640 CHECK (version > 0),
    CONSTRAINT ck_security__retention_policy_validity_36d93ac1 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_security__retention_policy_canonica_dcdb251b ON security_compliance_regulatory.retention_policy (canonical_id);
CREATE INDEX IF NOT EXISTS ix_security__retention_policy_status_52feb587 ON security_compliance_regulatory.retention_policy (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_security__retention_policy_updated_9cae6ae3 ON security_compliance_regulatory.retention_policy (updated_at);
CREATE INDEX IF NOT EXISTS ix_security__retention_policy_source_997b9e56 ON security_compliance_regulatory.retention_policy (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_security__retention_policy_attrgin_0e94b953 ON security_compliance_regulatory.retention_policy USING gin (attributes);
COMMENT ON TABLE security_compliance_regulatory.retention_policy IS 'Starter table for Security Operations, Compliance, And Regulatory. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN security_compliance_regulatory.retention_policy.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN security_compliance_regulatory.retention_policy.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN security_compliance_regulatory.retention_policy.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS security_compliance_regulatory.legal_hold (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_security__legal_hold_canonica_dfbad2c4 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_security__legal_hold_version_a2491dc6 CHECK (version > 0),
    CONSTRAINT ck_security__legal_hold_validity_dc865f18 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_security__legal_hold_canonica_4116c5fd ON security_compliance_regulatory.legal_hold (canonical_id);
CREATE INDEX IF NOT EXISTS ix_security__legal_hold_status_e57ff085 ON security_compliance_regulatory.legal_hold (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_security__legal_hold_updated_20d36392 ON security_compliance_regulatory.legal_hold (updated_at);
CREATE INDEX IF NOT EXISTS ix_security__legal_hold_source_a2b37a25 ON security_compliance_regulatory.legal_hold (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_security__legal_hold_attrgin_7cd88c3a ON security_compliance_regulatory.legal_hold USING gin (attributes);
COMMENT ON TABLE security_compliance_regulatory.legal_hold IS 'Starter table for Security Operations, Compliance, And Regulatory. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN security_compliance_regulatory.legal_hold.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN security_compliance_regulatory.legal_hold.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN security_compliance_regulatory.legal_hold.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS security_compliance_regulatory.audit_evidence_package (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_security__audit_evidence_package_canonica_3df2d9c5 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_security__audit_evidence_package_version_6453e431 CHECK (version > 0),
    CONSTRAINT ck_security__audit_evidence_package_validity_4e3b55b0 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_security__audit_evidence_package_canonica_f799b0f3 ON security_compliance_regulatory.audit_evidence_package (canonical_id);
CREATE INDEX IF NOT EXISTS ix_security__audit_evidence_package_status_f7f80ca2 ON security_compliance_regulatory.audit_evidence_package (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_security__audit_evidence_package_updated_08aa057b ON security_compliance_regulatory.audit_evidence_package (updated_at);
CREATE INDEX IF NOT EXISTS ix_security__audit_evidence_package_source_ae4b7ea9 ON security_compliance_regulatory.audit_evidence_package (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_security__audit_evidence_package_attrgin_7af5f2fc ON security_compliance_regulatory.audit_evidence_package USING gin (attributes);
COMMENT ON TABLE security_compliance_regulatory.audit_evidence_package IS 'Starter table for Security Operations, Compliance, And Regulatory. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN security_compliance_regulatory.audit_evidence_package.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN security_compliance_regulatory.audit_evidence_package.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN security_compliance_regulatory.audit_evidence_package.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS security_compliance_regulatory.business_continuity_plan (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_security__business_continuity_plan_canonica_ab386e78 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_security__business_continuity_plan_version_57af0c02 CHECK (version > 0),
    CONSTRAINT ck_security__business_continuity_plan_validity_f3ff2df9 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_security__business_continuity_plan_canonica_c7c5b06b ON security_compliance_regulatory.business_continuity_plan (canonical_id);
CREATE INDEX IF NOT EXISTS ix_security__business_continuity_plan_status_9a2aa8a2 ON security_compliance_regulatory.business_continuity_plan (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_security__business_continuity_plan_updated_4bc71955 ON security_compliance_regulatory.business_continuity_plan (updated_at);
CREATE INDEX IF NOT EXISTS ix_security__business_continuity_plan_source_0f3594b5 ON security_compliance_regulatory.business_continuity_plan (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_security__business_continuity_plan_attrgin_4a697622 ON security_compliance_regulatory.business_continuity_plan USING gin (attributes);
COMMENT ON TABLE security_compliance_regulatory.business_continuity_plan IS 'Starter table for Security Operations, Compliance, And Regulatory. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN security_compliance_regulatory.business_continuity_plan.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN security_compliance_regulatory.business_continuity_plan.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN security_compliance_regulatory.business_continuity_plan.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS security_compliance_regulatory.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_security__event_outbox_status_35a8f9e6 CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_security__event_outbox_publish_76aa5414 ON security_compliance_regulatory.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_security__event_outbox_eventkey_3add6106 ON security_compliance_regulatory.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_security__event_outbox_agg_68afd33e ON security_compliance_regulatory.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE security_compliance_regulatory.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS workflow_automation.process_definition (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_workflow__process_definition_canonica_07a5d4d1 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_workflow__process_definition_version_25346200 CHECK (version > 0),
    CONSTRAINT ck_workflow__process_definition_validity_c1b2cd30 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_workflow__process_definition_canonica_9a8ba481 ON workflow_automation.process_definition (canonical_id);
CREATE INDEX IF NOT EXISTS ix_workflow__process_definition_status_44e0fa36 ON workflow_automation.process_definition (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_workflow__process_definition_updated_325e85a0 ON workflow_automation.process_definition (updated_at);
CREATE INDEX IF NOT EXISTS ix_workflow__process_definition_source_797cff95 ON workflow_automation.process_definition (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_workflow__process_definition_attrgin_235e7ea9 ON workflow_automation.process_definition USING gin (attributes);
COMMENT ON TABLE workflow_automation.process_definition IS 'Starter table for Workflow And Automation Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN workflow_automation.process_definition.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN workflow_automation.process_definition.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN workflow_automation.process_definition.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS workflow_automation.process_version (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_workflow__process_version_canonica_80c6f3e6 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_workflow__process_version_version_c348b0b6 CHECK (version > 0),
    CONSTRAINT ck_workflow__process_version_validity_9157db9c CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_workflow__process_version_canonica_c86a6e69 ON workflow_automation.process_version (canonical_id);
CREATE INDEX IF NOT EXISTS ix_workflow__process_version_status_ad92e225 ON workflow_automation.process_version (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_workflow__process_version_updated_0a48ccb1 ON workflow_automation.process_version (updated_at);
CREATE INDEX IF NOT EXISTS ix_workflow__process_version_source_ec4aed73 ON workflow_automation.process_version (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_workflow__process_version_attrgin_b050ab60 ON workflow_automation.process_version USING gin (attributes);
COMMENT ON TABLE workflow_automation.process_version IS 'Starter table for Workflow And Automation Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN workflow_automation.process_version.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN workflow_automation.process_version.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN workflow_automation.process_version.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS workflow_automation.rule_definition (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_workflow__rule_definition_canonica_79de6e24 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_workflow__rule_definition_version_96e79f33 CHECK (version > 0),
    CONSTRAINT ck_workflow__rule_definition_validity_c4c89449 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_workflow__rule_definition_canonica_998db8d4 ON workflow_automation.rule_definition (canonical_id);
CREATE INDEX IF NOT EXISTS ix_workflow__rule_definition_status_157a9435 ON workflow_automation.rule_definition (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_workflow__rule_definition_updated_f392d79a ON workflow_automation.rule_definition (updated_at);
CREATE INDEX IF NOT EXISTS ix_workflow__rule_definition_source_91448e97 ON workflow_automation.rule_definition (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_workflow__rule_definition_attrgin_3d009451 ON workflow_automation.rule_definition USING gin (attributes);
COMMENT ON TABLE workflow_automation.rule_definition IS 'Starter table for Workflow And Automation Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN workflow_automation.rule_definition.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN workflow_automation.rule_definition.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN workflow_automation.rule_definition.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS workflow_automation.decision_definition (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_workflow__decision_definition_canonica_71926935 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_workflow__decision_definition_version_54b69468 CHECK (version > 0),
    CONSTRAINT ck_workflow__decision_definition_validity_4a275214 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_workflow__decision_definition_canonica_02dfb714 ON workflow_automation.decision_definition (canonical_id);
CREATE INDEX IF NOT EXISTS ix_workflow__decision_definition_status_1f3177cd ON workflow_automation.decision_definition (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_workflow__decision_definition_updated_9d3c677e ON workflow_automation.decision_definition (updated_at);
CREATE INDEX IF NOT EXISTS ix_workflow__decision_definition_source_34094cf7 ON workflow_automation.decision_definition (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_workflow__decision_definition_attrgin_9b462c3a ON workflow_automation.decision_definition USING gin (attributes);
COMMENT ON TABLE workflow_automation.decision_definition IS 'Starter table for Workflow And Automation Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN workflow_automation.decision_definition.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN workflow_automation.decision_definition.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN workflow_automation.decision_definition.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS workflow_automation.work_queue (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_workflow__work_queue_canonica_66608086 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_workflow__work_queue_version_7857b350 CHECK (version > 0),
    CONSTRAINT ck_workflow__work_queue_validity_f5ed0ab5 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_workflow__work_queue_canonica_909f7faa ON workflow_automation.work_queue (canonical_id);
CREATE INDEX IF NOT EXISTS ix_workflow__work_queue_status_acf79bcc ON workflow_automation.work_queue (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_workflow__work_queue_updated_d8b50597 ON workflow_automation.work_queue (updated_at);
CREATE INDEX IF NOT EXISTS ix_workflow__work_queue_source_0e48bd11 ON workflow_automation.work_queue (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_workflow__work_queue_attrgin_080f316f ON workflow_automation.work_queue USING gin (attributes);
COMMENT ON TABLE workflow_automation.work_queue IS 'Starter table for Workflow And Automation Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN workflow_automation.work_queue.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN workflow_automation.work_queue.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN workflow_automation.work_queue.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS workflow_automation.task (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_workflow__task_canonica_a535bf91 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_workflow__task_version_b117a69d CHECK (version > 0),
    CONSTRAINT ck_workflow__task_validity_2b922cd2 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_workflow__task_canonica_d6aab279 ON workflow_automation.task (canonical_id);
CREATE INDEX IF NOT EXISTS ix_workflow__task_status_e876c105 ON workflow_automation.task (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_workflow__task_updated_7a06a67b ON workflow_automation.task (updated_at);
CREATE INDEX IF NOT EXISTS ix_workflow__task_source_44cb5b35 ON workflow_automation.task (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_workflow__task_attrgin_77f866f7 ON workflow_automation.task USING gin (attributes);
COMMENT ON TABLE workflow_automation.task IS 'Starter table for Workflow And Automation Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN workflow_automation.task.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN workflow_automation.task.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN workflow_automation.task.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS workflow_automation.automation_playbook (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_workflow__automation_playbook_canonica_650c7fa3 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_workflow__automation_playbook_version_0f8ea424 CHECK (version > 0),
    CONSTRAINT ck_workflow__automation_playbook_validity_aab5a881 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_workflow__automation_playbook_canonica_41802052 ON workflow_automation.automation_playbook (canonical_id);
CREATE INDEX IF NOT EXISTS ix_workflow__automation_playbook_status_b0bb8af5 ON workflow_automation.automation_playbook (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_workflow__automation_playbook_updated_6cc715d0 ON workflow_automation.automation_playbook (updated_at);
CREATE INDEX IF NOT EXISTS ix_workflow__automation_playbook_source_c39baf59 ON workflow_automation.automation_playbook (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_workflow__automation_playbook_attrgin_5ed1f968 ON workflow_automation.automation_playbook USING gin (attributes);
COMMENT ON TABLE workflow_automation.automation_playbook IS 'Starter table for Workflow And Automation Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN workflow_automation.automation_playbook.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN workflow_automation.automation_playbook.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN workflow_automation.automation_playbook.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS workflow_automation.intent_handling_metadata (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_workflow__intent_handling_metadata_canonica_c7f4a09a UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_workflow__intent_handling_metadata_version_8f8050ba CHECK (version > 0),
    CONSTRAINT ck_workflow__intent_handling_metadata_validity_96cfabc6 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_workflow__intent_handling_metadata_canonica_035b7415 ON workflow_automation.intent_handling_metadata (canonical_id);
CREATE INDEX IF NOT EXISTS ix_workflow__intent_handling_metadata_status_0ecfa463 ON workflow_automation.intent_handling_metadata (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_workflow__intent_handling_metadata_updated_18193f97 ON workflow_automation.intent_handling_metadata (updated_at);
CREATE INDEX IF NOT EXISTS ix_workflow__intent_handling_metadata_source_3960f350 ON workflow_automation.intent_handling_metadata (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_workflow__intent_handling_metadata_attrgin_908ebbc6 ON workflow_automation.intent_handling_metadata USING gin (attributes);
COMMENT ON TABLE workflow_automation.intent_handling_metadata IS 'Starter table for Workflow And Automation Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN workflow_automation.intent_handling_metadata.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN workflow_automation.intent_handling_metadata.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN workflow_automation.intent_handling_metadata.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS workflow_automation.configuration_package (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_workflow__configuration_package_canonica_ffd38d84 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_workflow__configuration_package_version_00815730 CHECK (version > 0),
    CONSTRAINT ck_workflow__configuration_package_validity_8bf8df20 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_workflow__configuration_package_canonica_be3a85b9 ON workflow_automation.configuration_package (canonical_id);
CREATE INDEX IF NOT EXISTS ix_workflow__configuration_package_status_2ad683c0 ON workflow_automation.configuration_package (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_workflow__configuration_package_updated_0a33376e ON workflow_automation.configuration_package (updated_at);
CREATE INDEX IF NOT EXISTS ix_workflow__configuration_package_source_72374942 ON workflow_automation.configuration_package (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_workflow__configuration_package_attrgin_d71108c3 ON workflow_automation.configuration_package USING gin (attributes);
COMMENT ON TABLE workflow_automation.configuration_package IS 'Starter table for Workflow And Automation Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN workflow_automation.configuration_package.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN workflow_automation.configuration_package.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN workflow_automation.configuration_package.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS workflow_automation.extension_schema (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_workflow__extension_schema_canonica_6a14aad2 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_workflow__extension_schema_version_7a608b3f CHECK (version > 0),
    CONSTRAINT ck_workflow__extension_schema_validity_da72a172 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_workflow__extension_schema_canonica_a8bd32dd ON workflow_automation.extension_schema (canonical_id);
CREATE INDEX IF NOT EXISTS ix_workflow__extension_schema_status_2003cad7 ON workflow_automation.extension_schema (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_workflow__extension_schema_updated_9d742ef9 ON workflow_automation.extension_schema (updated_at);
CREATE INDEX IF NOT EXISTS ix_workflow__extension_schema_source_aba0fc4e ON workflow_automation.extension_schema (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_workflow__extension_schema_attrgin_c5dc3ad7 ON workflow_automation.extension_schema USING gin (attributes);
COMMENT ON TABLE workflow_automation.extension_schema IS 'Starter table for Workflow And Automation Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN workflow_automation.extension_schema.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN workflow_automation.extension_schema.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN workflow_automation.extension_schema.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS workflow_automation.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_workflow__event_outbox_status_534b98c3 CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_workflow__event_outbox_publish_1fe8e682 ON workflow_automation.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_workflow__event_outbox_eventkey_bd0fb699 ON workflow_automation.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_workflow__event_outbox_agg_d76660f4 ON workflow_automation.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE workflow_automation.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS data_reporting_intelligence.curated_data_product (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_data_repo_curated_data_product_canonica_e3e2cac3 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_data_repo_curated_data_product_version_8ae362d2 CHECK (version > 0),
    CONSTRAINT ck_data_repo_curated_data_product_validity_26ab1bfd CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_data_repo_curated_data_product_canonica_7a0353fc ON data_reporting_intelligence.curated_data_product (canonical_id);
CREATE INDEX IF NOT EXISTS ix_data_repo_curated_data_product_status_6d3f4123 ON data_reporting_intelligence.curated_data_product (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_data_repo_curated_data_product_updated_33429ed2 ON data_reporting_intelligence.curated_data_product (updated_at);
CREATE INDEX IF NOT EXISTS ix_data_repo_curated_data_product_source_463904f7 ON data_reporting_intelligence.curated_data_product (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_data_repo_curated_data_product_attrgin_d8e507c6 ON data_reporting_intelligence.curated_data_product USING gin (attributes);
COMMENT ON TABLE data_reporting_intelligence.curated_data_product IS 'Starter table for Data, Reporting, And Intelligence. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN data_reporting_intelligence.curated_data_product.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN data_reporting_intelligence.curated_data_product.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN data_reporting_intelligence.curated_data_product.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS data_reporting_intelligence.data_product_version (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_data_repo_data_product_version_canonica_fb8a2216 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_data_repo_data_product_version_version_cba7fd39 CHECK (version > 0),
    CONSTRAINT ck_data_repo_data_product_version_validity_73789e91 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_data_repo_data_product_version_canonica_7c2b59e2 ON data_reporting_intelligence.data_product_version (canonical_id);
CREATE INDEX IF NOT EXISTS ix_data_repo_data_product_version_status_22815b78 ON data_reporting_intelligence.data_product_version (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_data_repo_data_product_version_updated_6c3dcdd8 ON data_reporting_intelligence.data_product_version (updated_at);
CREATE INDEX IF NOT EXISTS ix_data_repo_data_product_version_source_30ffae0c ON data_reporting_intelligence.data_product_version (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_data_repo_data_product_version_attrgin_76c4a745 ON data_reporting_intelligence.data_product_version USING gin (attributes);
COMMENT ON TABLE data_reporting_intelligence.data_product_version IS 'Starter table for Data, Reporting, And Intelligence. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN data_reporting_intelligence.data_product_version.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN data_reporting_intelligence.data_product_version.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN data_reporting_intelligence.data_product_version.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS data_reporting_intelligence.reference_data (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_data_repo_reference_data_canonica_979852a5 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_data_repo_reference_data_version_70b6c564 CHECK (version > 0),
    CONSTRAINT ck_data_repo_reference_data_validity_7e308974 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_data_repo_reference_data_canonica_299c92be ON data_reporting_intelligence.reference_data (canonical_id);
CREATE INDEX IF NOT EXISTS ix_data_repo_reference_data_status_793df790 ON data_reporting_intelligence.reference_data (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_data_repo_reference_data_updated_360d34b7 ON data_reporting_intelligence.reference_data (updated_at);
CREATE INDEX IF NOT EXISTS ix_data_repo_reference_data_source_7fd2d6a8 ON data_reporting_intelligence.reference_data (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_data_repo_reference_data_attrgin_48b28634 ON data_reporting_intelligence.reference_data USING gin (attributes);
COMMENT ON TABLE data_reporting_intelligence.reference_data IS 'Starter table for Data, Reporting, And Intelligence. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN data_reporting_intelligence.reference_data.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN data_reporting_intelligence.reference_data.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN data_reporting_intelligence.reference_data.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS data_reporting_intelligence.code_set (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_data_repo_code_set_canonica_f6537cde UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_data_repo_code_set_version_a1c5e4d9 CHECK (version > 0),
    CONSTRAINT ck_data_repo_code_set_validity_7d3bb783 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_data_repo_code_set_canonica_33ed00fe ON data_reporting_intelligence.code_set (canonical_id);
CREATE INDEX IF NOT EXISTS ix_data_repo_code_set_status_2693f698 ON data_reporting_intelligence.code_set (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_data_repo_code_set_updated_d0f52f76 ON data_reporting_intelligence.code_set (updated_at);
CREATE INDEX IF NOT EXISTS ix_data_repo_code_set_source_e42b88eb ON data_reporting_intelligence.code_set (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_data_repo_code_set_attrgin_a4d04fa6 ON data_reporting_intelligence.code_set USING gin (attributes);
COMMENT ON TABLE data_reporting_intelligence.code_set IS 'Starter table for Data, Reporting, And Intelligence. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN data_reporting_intelligence.code_set.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN data_reporting_intelligence.code_set.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN data_reporting_intelligence.code_set.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS data_reporting_intelligence.kpi_definition (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_data_repo_kpi_definition_canonica_11ede7bc UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_data_repo_kpi_definition_version_7040af69 CHECK (version > 0),
    CONSTRAINT ck_data_repo_kpi_definition_validity_b7a3d239 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_data_repo_kpi_definition_canonica_50e27193 ON data_reporting_intelligence.kpi_definition (canonical_id);
CREATE INDEX IF NOT EXISTS ix_data_repo_kpi_definition_status_9a4fba9d ON data_reporting_intelligence.kpi_definition (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_data_repo_kpi_definition_updated_3f3b683b ON data_reporting_intelligence.kpi_definition (updated_at);
CREATE INDEX IF NOT EXISTS ix_data_repo_kpi_definition_source_2ff044c8 ON data_reporting_intelligence.kpi_definition (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_data_repo_kpi_definition_attrgin_df63dc8b ON data_reporting_intelligence.kpi_definition USING gin (attributes);
COMMENT ON TABLE data_reporting_intelligence.kpi_definition IS 'Starter table for Data, Reporting, And Intelligence. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN data_reporting_intelligence.kpi_definition.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN data_reporting_intelligence.kpi_definition.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN data_reporting_intelligence.kpi_definition.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS data_reporting_intelligence.report_definition (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_data_repo_report_definition_canonica_02a5d565 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_data_repo_report_definition_version_b121bbdb CHECK (version > 0),
    CONSTRAINT ck_data_repo_report_definition_validity_029994e6 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_data_repo_report_definition_canonica_48c3840b ON data_reporting_intelligence.report_definition (canonical_id);
CREATE INDEX IF NOT EXISTS ix_data_repo_report_definition_status_d598cd34 ON data_reporting_intelligence.report_definition (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_data_repo_report_definition_updated_e3cbc90d ON data_reporting_intelligence.report_definition (updated_at);
CREATE INDEX IF NOT EXISTS ix_data_repo_report_definition_source_e2a35a39 ON data_reporting_intelligence.report_definition (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_data_repo_report_definition_attrgin_a5c3476d ON data_reporting_intelligence.report_definition USING gin (attributes);
COMMENT ON TABLE data_reporting_intelligence.report_definition IS 'Starter table for Data, Reporting, And Intelligence. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN data_reporting_intelligence.report_definition.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN data_reporting_intelligence.report_definition.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN data_reporting_intelligence.report_definition.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS data_reporting_intelligence.lineage_record (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_data_repo_lineage_record_canonica_6ba1414b UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_data_repo_lineage_record_version_bdd5b876 CHECK (version > 0),
    CONSTRAINT ck_data_repo_lineage_record_validity_af21625b CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_data_repo_lineage_record_canonica_c0b91c5a ON data_reporting_intelligence.lineage_record (canonical_id);
CREATE INDEX IF NOT EXISTS ix_data_repo_lineage_record_status_d09427cc ON data_reporting_intelligence.lineage_record (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_data_repo_lineage_record_updated_bae7f9da ON data_reporting_intelligence.lineage_record (updated_at);
CREATE INDEX IF NOT EXISTS ix_data_repo_lineage_record_source_8a648809 ON data_reporting_intelligence.lineage_record (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_data_repo_lineage_record_attrgin_f9b2c129 ON data_reporting_intelligence.lineage_record USING gin (attributes);
COMMENT ON TABLE data_reporting_intelligence.lineage_record IS 'Starter table for Data, Reporting, And Intelligence. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN data_reporting_intelligence.lineage_record.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN data_reporting_intelligence.lineage_record.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN data_reporting_intelligence.lineage_record.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS data_reporting_intelligence.data_quality_issue (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_data_repo_data_quality_issue_canonica_0852cb09 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_data_repo_data_quality_issue_version_440001ea CHECK (version > 0),
    CONSTRAINT ck_data_repo_data_quality_issue_validity_ba26a92f CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_data_repo_data_quality_issue_canonica_faa1eef5 ON data_reporting_intelligence.data_quality_issue (canonical_id);
CREATE INDEX IF NOT EXISTS ix_data_repo_data_quality_issue_status_be383634 ON data_reporting_intelligence.data_quality_issue (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_data_repo_data_quality_issue_updated_3340ebf1 ON data_reporting_intelligence.data_quality_issue (updated_at);
CREATE INDEX IF NOT EXISTS ix_data_repo_data_quality_issue_source_97ddba8f ON data_reporting_intelligence.data_quality_issue (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_data_repo_data_quality_issue_attrgin_bfe2514e ON data_reporting_intelligence.data_quality_issue USING gin (attributes);
COMMENT ON TABLE data_reporting_intelligence.data_quality_issue IS 'Starter table for Data, Reporting, And Intelligence. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN data_reporting_intelligence.data_quality_issue.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN data_reporting_intelligence.data_quality_issue.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN data_reporting_intelligence.data_quality_issue.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS data_reporting_intelligence.ai_model_governance (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_data_repo_ai_model_governance_canonica_dc0577e2 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_data_repo_ai_model_governance_version_fe4272a7 CHECK (version > 0),
    CONSTRAINT ck_data_repo_ai_model_governance_validity_aae3a7df CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_data_repo_ai_model_governance_canonica_295c06d0 ON data_reporting_intelligence.ai_model_governance (canonical_id);
CREATE INDEX IF NOT EXISTS ix_data_repo_ai_model_governance_status_178a577a ON data_reporting_intelligence.ai_model_governance (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_data_repo_ai_model_governance_updated_e12e6b3d ON data_reporting_intelligence.ai_model_governance (updated_at);
CREATE INDEX IF NOT EXISTS ix_data_repo_ai_model_governance_source_77fda77b ON data_reporting_intelligence.ai_model_governance (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_data_repo_ai_model_governance_attrgin_9c3270dd ON data_reporting_intelligence.ai_model_governance USING gin (attributes);
COMMENT ON TABLE data_reporting_intelligence.ai_model_governance IS 'Starter table for Data, Reporting, And Intelligence. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN data_reporting_intelligence.ai_model_governance.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN data_reporting_intelligence.ai_model_governance.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN data_reporting_intelligence.ai_model_governance.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS data_reporting_intelligence.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_data_repo_event_outbox_status_23082987 CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_data_repo_event_outbox_publish_efcdeced ON data_reporting_intelligence.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_data_repo_event_outbox_eventkey_8ae3ccd3 ON data_reporting_intelligence.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_data_repo_event_outbox_agg_0bf7221d ON data_reporting_intelligence.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE data_reporting_intelligence.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS test_certification_lab.test_case (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_test_cert_test_case_canonica_99cbcde1 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_test_cert_test_case_version_e0d031d3 CHECK (version > 0),
    CONSTRAINT ck_test_cert_test_case_validity_ed4120fd CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_test_cert_test_case_canonica_ba9eb50f ON test_certification_lab.test_case (canonical_id);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_case_status_0e068fc1 ON test_certification_lab.test_case (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_case_updated_96653dc8 ON test_certification_lab.test_case (updated_at);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_case_source_89372036 ON test_certification_lab.test_case (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_test_cert_test_case_attrgin_8f5a412d ON test_certification_lab.test_case USING gin (attributes);
COMMENT ON TABLE test_certification_lab.test_case IS 'Starter table for Test And Certification Lab. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN test_certification_lab.test_case.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN test_certification_lab.test_case.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN test_certification_lab.test_case.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS test_certification_lab.test_scenario (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_test_cert_test_scenario_canonica_acd0f0b6 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_test_cert_test_scenario_version_3f92305c CHECK (version > 0),
    CONSTRAINT ck_test_cert_test_scenario_validity_057560a6 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_test_cert_test_scenario_canonica_f547b5c2 ON test_certification_lab.test_scenario (canonical_id);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_scenario_status_556ab44a ON test_certification_lab.test_scenario (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_scenario_updated_6a2a5b61 ON test_certification_lab.test_scenario (updated_at);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_scenario_source_5c1531d8 ON test_certification_lab.test_scenario (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_test_cert_test_scenario_attrgin_69ce63a3 ON test_certification_lab.test_scenario USING gin (attributes);
COMMENT ON TABLE test_certification_lab.test_scenario IS 'Starter table for Test And Certification Lab. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN test_certification_lab.test_scenario.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN test_certification_lab.test_scenario.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN test_certification_lab.test_scenario.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS test_certification_lab.test_environment (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_test_cert_test_environment_canonica_5dad0bba UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_test_cert_test_environment_version_9802f745 CHECK (version > 0),
    CONSTRAINT ck_test_cert_test_environment_validity_bf944ec3 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_test_cert_test_environment_canonica_f2e094de ON test_certification_lab.test_environment (canonical_id);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_environment_status_581398e1 ON test_certification_lab.test_environment (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_environment_updated_99dad9c5 ON test_certification_lab.test_environment (updated_at);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_environment_source_fc08187e ON test_certification_lab.test_environment (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_test_cert_test_environment_attrgin_00b80ee8 ON test_certification_lab.test_environment USING gin (attributes);
COMMENT ON TABLE test_certification_lab.test_environment IS 'Starter table for Test And Certification Lab. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN test_certification_lab.test_environment.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN test_certification_lab.test_environment.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN test_certification_lab.test_environment.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS test_certification_lab.test_data_definition (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_test_cert_test_data_definition_canonica_63f18ebd UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_test_cert_test_data_definition_version_0e9933f9 CHECK (version > 0),
    CONSTRAINT ck_test_cert_test_data_definition_validity_4b03ba17 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_test_cert_test_data_definition_canonica_f94092fa ON test_certification_lab.test_data_definition (canonical_id);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_data_definition_status_247ad9d9 ON test_certification_lab.test_data_definition (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_data_definition_updated_28a02934 ON test_certification_lab.test_data_definition (updated_at);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_data_definition_source_6069c4cc ON test_certification_lab.test_data_definition (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_test_cert_test_data_definition_attrgin_407d2db3 ON test_certification_lab.test_data_definition USING gin (attributes);
COMMENT ON TABLE test_certification_lab.test_data_definition IS 'Starter table for Test And Certification Lab. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN test_certification_lab.test_data_definition.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN test_certification_lab.test_data_definition.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN test_certification_lab.test_data_definition.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS test_certification_lab.test_execution (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_test_cert_test_execution_canonica_d0bae5bc UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_test_cert_test_execution_version_88b52d7a CHECK (version > 0),
    CONSTRAINT ck_test_cert_test_execution_validity_dd8b0921 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_test_cert_test_execution_canonica_d6df6bfe ON test_certification_lab.test_execution (canonical_id);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_execution_status_3793bc08 ON test_certification_lab.test_execution (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_execution_updated_2b279cdf ON test_certification_lab.test_execution (updated_at);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_execution_source_e4e14dae ON test_certification_lab.test_execution (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_test_cert_test_execution_attrgin_8c75bc34 ON test_certification_lab.test_execution USING gin (attributes);
COMMENT ON TABLE test_certification_lab.test_execution IS 'Starter table for Test And Certification Lab. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN test_certification_lab.test_execution.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN test_certification_lab.test_execution.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN test_certification_lab.test_execution.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS test_certification_lab.test_result (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_test_cert_test_result_canonica_21576e27 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_test_cert_test_result_version_3d76d698 CHECK (version > 0),
    CONSTRAINT ck_test_cert_test_result_validity_5c927145 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_test_cert_test_result_canonica_c1396f2f ON test_certification_lab.test_result (canonical_id);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_result_status_fae2c175 ON test_certification_lab.test_result (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_result_updated_f8df56b5 ON test_certification_lab.test_result (updated_at);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_result_source_28081838 ON test_certification_lab.test_result (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_test_cert_test_result_attrgin_867bddf0 ON test_certification_lab.test_result USING gin (attributes);
COMMENT ON TABLE test_certification_lab.test_result IS 'Starter table for Test And Certification Lab. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN test_certification_lab.test_result.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN test_certification_lab.test_result.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN test_certification_lab.test_result.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS test_certification_lab.test_artifact (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_test_cert_test_artifact_canonica_6351436e UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_test_cert_test_artifact_version_92af96ef CHECK (version > 0),
    CONSTRAINT ck_test_cert_test_artifact_validity_74d2f6fe CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_test_cert_test_artifact_canonica_27d397aa ON test_certification_lab.test_artifact (canonical_id);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_artifact_status_6b709f7c ON test_certification_lab.test_artifact (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_artifact_updated_0f983c26 ON test_certification_lab.test_artifact (updated_at);
CREATE INDEX IF NOT EXISTS ix_test_cert_test_artifact_source_dcec9809 ON test_certification_lab.test_artifact (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_test_cert_test_artifact_attrgin_3cdd36fd ON test_certification_lab.test_artifact USING gin (attributes);
COMMENT ON TABLE test_certification_lab.test_artifact IS 'Starter table for Test And Certification Lab. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN test_certification_lab.test_artifact.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN test_certification_lab.test_artifact.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN test_certification_lab.test_artifact.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS test_certification_lab.conformance_evidence (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_test_cert_conformance_evidence_canonica_107ba1ae UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_test_cert_conformance_evidence_version_1b32cd95 CHECK (version > 0),
    CONSTRAINT ck_test_cert_conformance_evidence_validity_afddbb5d CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_test_cert_conformance_evidence_canonica_e5ea9dc1 ON test_certification_lab.conformance_evidence (canonical_id);
CREATE INDEX IF NOT EXISTS ix_test_cert_conformance_evidence_status_a16c7ac1 ON test_certification_lab.conformance_evidence (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_test_cert_conformance_evidence_updated_b024c526 ON test_certification_lab.conformance_evidence (updated_at);
CREATE INDEX IF NOT EXISTS ix_test_cert_conformance_evidence_source_203ea434 ON test_certification_lab.conformance_evidence (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_test_cert_conformance_evidence_attrgin_027dad52 ON test_certification_lab.conformance_evidence USING gin (attributes);
COMMENT ON TABLE test_certification_lab.conformance_evidence IS 'Starter table for Test And Certification Lab. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN test_certification_lab.conformance_evidence.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN test_certification_lab.conformance_evidence.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN test_certification_lab.conformance_evidence.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS test_certification_lab.certification_gate (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_test_cert_certification_gate_canonica_73fe7469 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_test_cert_certification_gate_version_8ba0bbbe CHECK (version > 0),
    CONSTRAINT ck_test_cert_certification_gate_validity_ed642e35 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_test_cert_certification_gate_canonica_d9daec68 ON test_certification_lab.certification_gate (canonical_id);
CREATE INDEX IF NOT EXISTS ix_test_cert_certification_gate_status_9db47988 ON test_certification_lab.certification_gate (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_test_cert_certification_gate_updated_365e62c5 ON test_certification_lab.certification_gate (updated_at);
CREATE INDEX IF NOT EXISTS ix_test_cert_certification_gate_source_1cab6f61 ON test_certification_lab.certification_gate (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_test_cert_certification_gate_attrgin_d6e37804 ON test_certification_lab.certification_gate USING gin (attributes);
COMMENT ON TABLE test_certification_lab.certification_gate IS 'Starter table for Test And Certification Lab. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN test_certification_lab.certification_gate.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN test_certification_lab.certification_gate.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN test_certification_lab.certification_gate.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS test_certification_lab.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_test_cert_event_outbox_status_0a4f6c61 CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_test_cert_event_outbox_publish_dbfd6526 ON test_certification_lab.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_test_cert_event_outbox_eventkey_a12d5d9d ON test_certification_lab.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_test_cert_event_outbox_agg_3fdd8eb6 ON test_certification_lab.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE test_certification_lab.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';


GRANT USAGE ON SCHEMA integration_api_eventing TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA integration_api_eventing TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA integration_api_eventing TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA integration_api_eventing GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA integration_api_eventing GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA platform_admin_security TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA platform_admin_security TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA platform_admin_security TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA platform_admin_security GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA platform_admin_security GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA security_compliance_regulatory TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA security_compliance_regulatory TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA security_compliance_regulatory TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA security_compliance_regulatory GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA security_compliance_regulatory GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA workflow_automation TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA workflow_automation TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA workflow_automation TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA workflow_automation GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA workflow_automation GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA data_reporting_intelligence TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA data_reporting_intelligence TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA data_reporting_intelligence TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA data_reporting_intelligence GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA data_reporting_intelligence GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA test_certification_lab TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA test_certification_lab TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA test_certification_lab TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA test_certification_lab GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA test_certification_lab GRANT SELECT ON TABLES TO telcosuite_readonly;
