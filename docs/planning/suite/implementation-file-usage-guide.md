# Enterprise Platform, Data, And Governance Implementation File Usage Guide

Reviewed: 2026-06-14

## Purpose

This guide explains how to use the planning, TMF, UI, data, and DDL files for the Enterprise Platform, Data, And Governance suite while building its apps.

Suite focus: platform integration, eventing, security, workflow, data, reporting, compliance, and certification capabilities.

## Suite-Level Files

| File | Use it for |
| --- | --- |
| [README.md](README.md) | Suite navigation and app list. |
| [tech-and-ui-guidance.md](tech-and-ui-guidance.md) | Suite-specific Angular, PrimeNG, layout, navigation, density, and UI consistency guidance. |
| [data-model.md](data-model.md) | Suite database ownership, app schemas, data mastery, cross-app sharing, and physical model guidance. |
| [journey-coverage.md](journey-coverage.md) | Cross-app suite journeys and end-to-end flow validation. |
| [../build-artifact-usage-guide.md](../build-artifact-usage-guide.md) | Global explanation of how all generated files fit together. |
| [../suite-app-coverage-control-matrix.md](../suite-app-coverage-control-matrix.md) | Build-readiness status across all suites and apps. |
| [../tmf-api-to-ddl-traceability-matrix.md](../tmf-api-to-ddl-traceability-matrix.md) | API-level TMF-to-schema/table coverage. |
| [../../../database/postgres/README.md](../../../database/postgres/README.md) | Database execution model and migration usage. |

## Database And Migration Use

Physical database: `ts_enterprise_platform_governance`

Run migrations in order inside this suite database. `V001` creates app schemas and starter tables. Each V002+ migration refines one app with promoted TMF fields, support tables, event contracts, and privacy/retention/audit policies.

| Migration | Path |
| --- | --- |
| `V001__create_app_schemas_and_starter_tables.sql` | `database/postgres/suites/ts_enterprise_platform_governance/V001__create_app_schemas_and_starter_tables.sql` |
| `V002__refine_integration_api_eventing_tmf_core.sql` | `database/postgres/suites/ts_enterprise_platform_governance/V002__refine_integration_api_eventing_tmf_core.sql` |
| `V003__refine_platform_admin_security_tmf_core.sql` | `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql` |
| `V004__refine_security_compliance_regulatory_tmf_core.sql` | `database/postgres/suites/ts_enterprise_platform_governance/V004__refine_security_compliance_regulatory_tmf_core.sql` |
| `V005__refine_workflow_automation_tmf_core.sql` | `database/postgres/suites/ts_enterprise_platform_governance/V005__refine_workflow_automation_tmf_core.sql` |
| `V006__refine_data_reporting_intelligence_tmf_core.sql` | `database/postgres/suites/ts_enterprise_platform_governance/V006__refine_data_reporting_intelligence_tmf_core.sql` |
| `V007__refine_test_certification_lab_tmf_core.sql` | `database/postgres/suites/ts_enterprise_platform_governance/V007__refine_test_certification_lab_tmf_core.sql` |

## App File Map

| App | Schema | App usage guide | TMF review | App migration | Primary TMF/API areas |
| --- | --- | --- | --- | --- | --- |
| Data, Reporting, And Intelligence | `data_reporting_intelligence` | [data-reporting-intelligence/implementation-file-usage.md](data-reporting-intelligence/implementation-file-usage.md) | [data-reporting-intelligence.md](../tmf-api-ddl-reviews/data-reporting-intelligence.md) | `V006__refine_data_reporting_intelligence_tmf_core.sql` | Cross-cutting TMF APIs, TMF915, TMF696, TMF680, TMF667 |
| Integration, Eventing, And API Platform | `integration_api_eventing` | [integration-eventing-api-platform/implementation-file-usage.md](integration-eventing-api-platform/implementation-file-usage.md) | [integration-api-eventing.md](../tmf-api-ddl-reviews/integration-api-eventing.md) | `V002__refine_integration_api_eventing_tmf_core.sql` | Cross-cutting TMF APIs, TMF710, TMF688, TMF681, TMF644 |
| Platform Admin And Security | `platform_admin_security` | [platform-admin-security/implementation-file-usage.md](platform-admin-security/implementation-file-usage.md) | [platform-admin-security.md](../tmf-api-ddl-reviews/platform-admin-security.md) | `V003__refine_platform_admin_security_tmf_core.sql` | TMF672, TMF720, TMF691, TMF696, TMF644, TMF667 |
| Security Operations, Compliance, And Regulatory | `security_compliance_regulatory` | [security-operations-compliance-regulatory/implementation-file-usage.md](security-operations-compliance-regulatory/implementation-file-usage.md) | [security-compliance-regulatory.md](../tmf-api-ddl-reviews/security-compliance-regulatory.md) | `V004__refine_security_compliance_regulatory_tmf_core.sql` | TMF720, TMF672, TMF696, TMF621, TMF644, TMF667, TMF707, TMF710, TMF681, TMF735, TMF724, TMF655 |
| Test And Certification Lab | `test_certification_lab` | [test-certification-lab/implementation-file-usage.md](test-certification-lab/implementation-file-usage.md) | [test-certification-lab.md](../tmf-api-ddl-reviews/test-certification-lab.md) | `V007__refine_test_certification_lab_tmf_core.sql` | TMF704, TMF705, TMF706, TMF708, TMF709, TMF707, TMF710, cross-cutting TMF APIs |
| Workflow And Automation Studio | `workflow_automation` | [workflow-automation-studio/implementation-file-usage.md](workflow-automation-studio/implementation-file-usage.md) | [workflow-automation.md](../tmf-api-ddl-reviews/workflow-automation.md) | `V005__refine_workflow_automation_tmf_core.sql` | TMF701, TMF696, TMF679, TMF697, TMF921, TMF915, TMF672, TMF710 |

## Suite Build Workflow

1. Start with this guide and the suite `data-model.md` to confirm database, schema, and ownership boundaries.
2. Use `tech-and-ui-guidance.md` before any Angular work so all apps share the TelcoSuite design language.
3. Build apps in the priority order from [../tmf-api-ddl-reviews/backlog.md](../tmf-api-ddl-reviews/backlog.md), unless delivery priorities explicitly change.
4. For each app, open its `implementation-file-usage.md` and follow its checklist.
5. Apply `V001`, then the app's V002+ migration, before implementing repositories/entities that depend on promoted columns or support tables.
6. Emit events through the app `event_outbox` and use the app `event_contract` table as the baseline register.
7. Enforce table handling with the app `privacy_retention_policy` table and add jurisdiction-specific rules before release.
8. Keep cross-app interactions out of database writes; use APIs, events, governed views, workflow tasks, or data products.

## Suite Delivery Gate

The suite is implementation-ready when each app keeps these artifacts aligned: app overview, modules/features, personas/journeys, TMF review, V002+ DDL, endpoint contract tests, event behavior, and privacy/audit controls.
