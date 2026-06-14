# Enterprise Platform, Data, And Governance Data Model

This document defines the suite-level data model for Enterprise Platform, Data, And Governance. It translates the product-suite data mastery decisions into one PostgreSQL suite database with app-owned schemas and TMF-aligned entity ownership.

## Suite Database Layout

Physical database: `ts_enterprise_platform_governance`

| App | Owning schema | Primary data role |
| --- | --- | --- |
| Integration, Eventing, And API Platform | `integration_api_eventing` | API contracts, event catalog, subscriptions, gateway policy, adapter metadata, notification delivery attempts, tracing references |
| Platform Admin And Security | `platform_admin_security` | Tenant, user, role, policy, access, platform configuration |
| Security Operations, Compliance, And Regulatory | `security_compliance_regulatory` | Security/compliance cases, controls, evidence, regulatory requests, retention, legal hold |
| Workflow And Automation Studio | `workflow_automation` | Process definitions, tasks, rules, decisions, automation, compensation evidence |
| Data, Reporting, And Intelligence | `data_reporting_intelligence` | Data products, reports, KPIs, metadata, lineage, data quality, AI governance evidence |
| Test And Certification Lab | `test_certification_lab` | Test cases, scenarios, environments, executions, results, conformance evidence |

## Data Modeling Rules

- Platform apps master platform metadata and governance records, not domain business data owned by BSS, OSS, digital, or planning apps.
- Identity, role, policy, API, event, workflow, data product, test, and compliance records require strong versioning and audit history.
- Data products and reports must retain lineage to operational source masters and must not become write paths back into operational apps.
- Workflow owns process/task/automation evidence; domain apps still own their domain order, case, ticket, problem, or lifecycle state.
- Security and compliance evidence must support retention, legal hold, export, masking, and privileged-access review.

## Entity Mastery Matrix

| Entity family | Master app | Owning schema | TMF API anchors | Main consumers | Data role |
| --- | --- | --- | --- | --- | --- |
| API contract | Integration, Eventing, And API Platform | `integration_api_eventing` | TMF710, OpenAPI contracts | All suites, developer portal | Master platform contract registry |
| Event catalog and subscription | Integration, Eventing, And API Platform | `integration_api_eventing` | TMF688 | All suites, workflow, data | Master event metadata |
| Adapter and integration metadata | Integration, Eventing, And API Platform | `integration_api_eventing` | Extension area | Domain apps, observability | Master adapter and mapping metadata |
| Gateway policy and API route | Integration, Eventing, And API Platform | `integration_api_eventing` | Cross-cutting APIs | API runtime, developer portal, security | Master governance metadata |
| Notification delivery attempt | Integration, Eventing, And API Platform | `integration_api_eventing` | TMF681, TMF644 | Customer 360, ecosystem, marketing, care | Master delivery attempt metadata |
| Tenant and environment | Platform Admin And Security | `platform_admin_security` | TMF672 | All suites | Master platform boundary |
| Platform user, role, permission, group, policy | Platform Admin And Security | `platform_admin_security` | TMF672, TMF720, TMF691 | All suites, audit, workflow | Master platform identity and authorization |
| Platform configuration | Platform Admin And Security | `platform_admin_security` | TMF701 | All suites | Master configuration |
| Security/compliance case | Security Operations, Compliance, And Regulatory | `security_compliance_regulatory` | TMF621, TMF644, TMF667, TMF681, TMF696 | Legal, audit, operations | Master case |
| Regulatory request | Security Operations, Compliance, And Regulatory | `security_compliance_regulatory` | TMF621, TMF667, TMF681, TMF696 | Domain apps, legal, reporting | Master request/evidence |
| Retention and legal hold record | Security Operations, Compliance, And Regulatory | `security_compliance_regulatory` | TMF644, TMF667, TMF735 | All suites | Master governance rule/evidence |
| Audit evidence package | Security Operations, Compliance, And Regulatory | `security_compliance_regulatory` | TMF667, TMF681, TMF696 | Audit, compliance, legal | Master evidence |
| Process definition | Workflow And Automation Studio | `workflow_automation` | TMF701, TMF921 | Domain apps, platform, assurance | Master definition |
| Task and work queue item | Workflow And Automation Studio | `workflow_automation` | TMF701, TMF921 | All suites | Master task state |
| Rule, decision, and automation evidence | Workflow And Automation Studio | `workflow_automation` | TMF701, TMF921 | Domain apps, audit | Master decision evidence |
| Curated data product | Data, Reporting, And Intelligence | `data_reporting_intelligence` | Cross-cutting APIs | Reporting, AI, governance | Master analytical product |
| KPI and report definition | Data, Reporting, And Intelligence | `data_reporting_intelligence` | TMF667, cross-cutting APIs | Executives, operations | Master analytical definition |
| Metadata, lineage, and data quality record | Data, Reporting, And Intelligence | `data_reporting_intelligence` | TMF701, TMF696 | All suites, governance | Master governance metadata |
| AI governance record | Data, Reporting, And Intelligence | `data_reporting_intelligence` | TMF915, TMF696, TMF680 | Compliance, data, product teams | Master governance evidence |
| Test case | Test And Certification Lab | `test_certification_lab` | TMF704 | Release, app teams, partner | Master test asset |
| Test environment | Test And Certification Lab | `test_certification_lab` | TMF705 | Release, app teams, partner | Master test environment |
| Test data definition | Test And Certification Lab | `test_certification_lab` | TMF706 | Release, app teams, partner | Master test data definition |
| Test scenario/execution/result/artifact | Test And Certification Lab | `test_certification_lab` | TMF708, TMF709, TMF707, TMF710 | Release, certification, app teams | Master execution/evidence |
| TMF conformance evidence | Test And Certification Lab | `test_certification_lab` | TMF710 | Release gates, partner, audit | Master conformance evidence |

## Schema-Ready App Physical Design

Candidate table names are starter names for app migrations. Each app must validate exact TMF API version, resource, operation, and field paths against `references/tmforum-open-apis/openapi-specs/` before creating DDL.

| Owning schema | Starter table groups and candidate tables | Key and relationship rules | Controls and storage notes |
| --- | --- | --- | --- |
| `integration_api_eventing` | Integration control plane: `api_contract`, `api_contract_version`, `event_type`, `event_subscription`, `gateway_policy`, `api_route`, `integration_adapter`, `mapping_rule`, `notification_delivery_attempt`, `trace_reference`, `event_outbox` | API contracts use versioned IDs and OpenAPI/TMF spec references. Event subscriptions reference producers/consumers. Notification attempts reference templates, recipients, consent snapshot, and delivery provider IDs. | API/event contracts are versioned and immutable after publication. Delivery attempts need replay/idempotency keys, masking, retention, and provider evidence. |
| `platform_admin_security` | Tenant and identity: `tenant`, `environment`, `platform_user`, `platform_role`, `platform_permission`, `user_group`, `authorization_policy`, `platform_configuration`, `secret_certificate_metadata`, `access_audit_reference`, `event_outbox` | Tenant/environment IDs scope all platform metadata. User/role/policy records reference digital identity/federation IDs and do not replace customer account access relationships mastered in BSS. | Security-sensitive. Require privileged access audit, secret metadata only, policy versioning, and environment separation. |
| `security_compliance_regulatory` | Security and compliance: `security_incident`, `compliance_control`, `control_evidence`, `regulatory_obligation`, `regulatory_submission`, `retention_policy`, `legal_hold`, `audit_evidence_package`, `business_continuity_plan`, `event_outbox` | Compliance records reference evidence from domain apps and platform logs without mastering operational domain records. Retention/legal hold records are authoritative policy references for all suites. | Restricted data class. Preserve chain of custody, immutability where required, export trail, legal hold, and regulatory retention. |
| `workflow_automation` | Workflow and automation: `process_definition`, `process_version`, `rule_definition`, `decision_definition`, `work_queue`, `task`, `automation_playbook`, `intent_handling_metadata`, `configuration_package`, `extension_schema`, `event_outbox` | Workflow tasks reference domain entity IDs and source app, but domain lifecycle remains with the domain app. Rules/decisions are versioned and invoked through APIs/events. | Store execution evidence, compensation state, actor, correlation/causation IDs, and rule/model version. |
| `data_reporting_intelligence` | Data products and intelligence: `curated_data_product`, `data_product_version`, `reference_data`, `code_set`, `kpi_definition`, `report_definition`, `lineage_record`, `data_quality_issue`, `ai_model_governance`, `event_outbox` | Analytical entities reference operational source contracts, event versions, lineage, and certification state. Data products must not become write paths into operational masters. | Store data quality score, certification, lineage, refresh policy, masking, retention, and usage approval. |
| `test_certification_lab` | Test and conformance: `test_case`, `test_scenario`, `test_environment`, `test_data_definition`, `test_execution`, `test_result`, `test_artifact`, `conformance_evidence`, `certification_gate`, `event_outbox` | Test assets reference API contracts, environments, data definitions, releases, and partner certifications. Formal conformance evidence references exact TMF spec versions. | Separate production data from synthetic/masked test data. Preserve evidence, result artifacts, and release gate decisions. |

## Consumed Cross-Suite Data

| Source suite/app | Consumed data | Storage rule |
| --- | --- | --- |
| All domain suites | API contracts, event contracts, source IDs, operational metrics, data product inputs | Store metadata, lineage, projections, and evidence, not operational write masters |
| BSS Commercial | Customer, order, billing, usage, consent, revenue data | Store governed data products and policy references only |
| OSS suites | Inventory, fulfillment, assurance, performance, change data | Store governed data products, health metadata, test evidence, and policy references |
| Digital, Partner, And Ecosystem | Partner, developer, subscription, portal usage data | Store platform metadata, data products, and governance evidence |

## TMF Compliance Rules

- Use TMF710 and OpenAPI contracts for API contract registry; use TMF688 for event catalog and subscription metadata.
- Use TMF672, TMF720, and TMF691 for tenant, environment, user, role, permission, policy, and digital identity references.
- Use TMF621, TMF644, TMF667, TMF681, and TMF696 for compliance, privacy, evidence, communication, and risk cases.
- Use TMF701 and TMF921 for workflow, automation, intent, process, and task-related records.
- Use TMF704, TMF705, TMF706, TMF707, TMF708, TMF709, and TMF710 for test case, environment, data, result, execution, scenario, artifact, and conformance records where available.
- Data products must document source TMF APIs and source operational masters even when the analytical model is not itself a TMF resource.

## Events And Projections

- Publish events for API contract changed, event contract changed, subscription changed, gateway policy changed, notification delivery attempted, tenant/environment changed, user changed, role changed, policy changed, compliance case changed, retention hold changed, workflow published, task changed, data product certified, data quality issue changed, test result published, and certification gate changed.
- Each event must be registered with event name/version, event key, payload basis, outbox table, known consumers, replay retention, and masking controls before implementation.
- Domain apps consume platform metadata through APIs/events and must not directly update platform governance schemas.
- Data-product events must include lineage, source contract version, source app, data quality status, and certification state.

## App-Level Data Model Checklist

- Platform metadata is distinct from domain business records.
- Candidate tables, primary keys, alternate identifiers, cross-app reference fields, and migration owner must be recorded before creating migrations.
- Each app must maintain TMF conformance, event contract, and privacy/retention/audit registers for every table group.
- Policy, identity, workflow, API, event, test, and data product records are versioned.
- Data products retain lineage and do not create hidden write paths.
- Compliance evidence supports retention, legal hold, masking, export, and chain-of-custody requirements.
- Every platform extension records API contract, owner, risk, and compatibility impact.
