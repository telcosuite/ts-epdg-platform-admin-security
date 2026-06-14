# Platform Admin And Security TMF API To DDL Review

Reviewed: 2026-06-14

Status: Complete for baseline app implementation. Endpoint-specific contract tests and final story-level field promotion still happen during build.

## Scope

This review covers `platform_admin_security` in suite database `ts_enterprise_platform_governance`. It uses the local TMF Open API reference set, the suite data model, the API-to-DDL traceability matrix, and the V001 starter DDL.

The review confirms that the app can move into implementation with a V002 typed DDL baseline while preserving full TMF payload compatibility through validated `tmf_payload`, typed common TMF columns, and normalized support tables.

## TMF API Baseline Selection

| TMF API | Local baseline spec | Resources/path roots reviewed | V001 table groups |
| --- | --- | --- | --- |
| TMF672 | `references/tmforum-open-apis/openapi-specs/TMF672_UserRolesPermissions/TMF672-User_Role_Permission_Management_API-v5.1.0.oas.yaml` | `checkPermission`, `permissionSet`, `permissionSpecification`, `permissionSpecificationSet` | tenant; environment; platform_user; platform_role; platform_permission; developer_application references |
| TMF720 | `references/tmforum-open-apis/openapi-specs/TMF720_DigitalIdentity/TMF720_Digital_Identity_Management_API_v4.0.0_swagger.json` | `digitalIdentity` | platform_user; customer_identity_link; developer_organization; developer_application |
| TMF691 | `references/tmforum-open-apis/openapi-specs/TMF691_FederatedIdentity/TMF691-FederatedIdentity-v4.0.0.swagger.json` | `userinfo` | platform_user; customer_identity_link references |
| TMF696 | `references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement/TMF696_Risk_Management_API_v4.0.0_swagger.json` | `partyRoleProductOfferingRiskAssessment`, `partyRoleRiskAssessment`, `productOfferingRiskAssessment`, `productOrderRiskAssessment`, `shoppingCartRiskAssessment` | rule_definition; decision_definition; credit_decision; risk_exposure; compliance_control |
| TMF644 | `references/tmforum-open-apis/openapi-specs/TMF644_Privacy/TMF644-Privacy-v5.0.0.oas.yaml` | `partyPrivacyAgreement`, `partyPrivacyProfile`, `partyPrivacyProfileSpecification` | consent; privacy_preference; retention_policy references in platform |
| TMF667 | `references/tmforum-open-apis/openapi-specs/TMF667_Document/TMF667_Document_Management_API_v4.0.0_swagger.json` | `document`, `documentSpecification` | customer_document_metadata; control_evidence; audit_evidence_package |

## Current DDL Coverage

Current starter DDL is in `database/postgres/suites/ts_enterprise_platform_governance/V001__create_app_schemas_and_starter_tables.sql` under schema `platform_admin_security`.

| Current table | TMF purpose | V002 decision |
| --- | --- | --- |
| `platform_admin_security.tenant` | Starter table for Platform Admin And Security; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql` |
| `platform_admin_security.environment` | Starter table for Platform Admin And Security; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql` |
| `platform_admin_security.platform_user` | Starter table for Platform Admin And Security; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql` |
| `platform_admin_security.platform_role` | Starter table for Platform Admin And Security; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql` |
| `platform_admin_security.platform_permission` | Starter table for Platform Admin And Security; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql` |
| `platform_admin_security.user_group` | Starter table for Platform Admin And Security; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql` |
| `platform_admin_security.authorization_policy` | Governance/control table for app data handling. | Keep and refine through `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql` |
| `platform_admin_security.platform_configuration` | Starter table for Platform Admin And Security; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql` |
| `platform_admin_security.secret_certificate_metadata` | Starter table for Platform Admin And Security; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql` |
| `platform_admin_security.access_audit_reference` | Starter table for Platform Admin And Security; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql` |
| `platform_admin_security.event_outbox` | App outbox for domain and TMF notification events. | Keep and refine through `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql` |

## Resource To Table Decisions

| TMF API/resource | Master or anchor table | Path coverage | Promoted field candidates | Field handling strategy |
| --- | --- | --- | --- | --- |
| TMF672 `checkPermission` | `platform_admin_security.platform_permission` | `/checkPermission`, `/checkPermission/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF672 `permissionSet` | `platform_admin_security.platform_permission` | `/permissionSet`, `/permissionSet/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF672 `permissionSpecification` | `platform_admin_security.platform_permission` | `/permissionSpecification`, `/permissionSpecification/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF672 `permissionSpecificationSet` | `platform_admin_security.platform_permission` | `/permissionSpecificationSet`, `/permissionSpecificationSet/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF720 `digitalIdentity` | `platform_admin_security.platform_user` | `/digitalIdentity`, `/digitalIdentity/{id}` | `id`, `href`, `creationDate`, `lastUpdate`, `nickname`, `status`, `attachment`, `contactMedium` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF691 `userinfo` | `platform_admin_security.platform_user` | `/userinfo`, `/userinfo/{id}` | `birthdate`, `email`, `email_verified`, `family_name`, `gender`, `given_name`, `locale`, `middle_name` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `partyRoleProductOfferingRiskAssessment` | `platform_admin_security.platform_role` | `/partyRoleProductOfferingRiskAssessment`, `/partyRoleProductOfferingRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `partyRole`, `place`, `productOffering`, `riskAssessmentResult` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `partyRoleRiskAssessment` | `platform_admin_security.platform_role` | `/partyRoleRiskAssessment`, `/partyRoleRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `place`, `riskAssessmentResult`, `@baseType`, `@schemaLocation` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `productOfferingRiskAssessment` | `platform_admin_security.tenant` | `/productOfferingRiskAssessment`, `/productOfferingRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `partyRole`, `place`, `productOffering`, `riskAssessmentResult` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `productOrderRiskAssessment` | `platform_admin_security.tenant` | `/productOrderRiskAssessment`, `/productOrderRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `place`, `productOrder`, `riskAssessmentResult`, `@baseType` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `shoppingCartRiskAssessment` | `platform_admin_security.tenant` | `/shoppingCartRiskAssessment`, `/shoppingCartRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `place`, `riskAssessmentResult`, `shoppingCart`, `@baseType` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF644 `partyPrivacyAgreement` | `platform_admin_security.tenant` | `/partyPrivacyAgreement`, `/partyPrivacyAgreement/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF644 `partyPrivacyProfile` | `platform_admin_security.tenant` | `/partyPrivacyProfile`, `/partyPrivacyProfile/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF644 `partyPrivacyProfileSpecification` | `platform_admin_security.tenant` | `/partyPrivacyProfileSpecification`, `/partyPrivacyProfileSpecification/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF667 `document` | `platform_admin_security.tenant` | `/document`, `/document/{id}` | `id`, `href`, `creationDate`, `description`, `documentType`, `lastUpdate`, `name`, `version` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF667 `documentSpecification` | `platform_admin_security.tenant` | `/documentSpecification`, `/documentSpecification/{id}` | `id`, `href`, `description`, `isBundle`, `lastUpdate`, `name`, `version`, `attachment` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |

## V002 DDL Refinement

Migration: `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql`

The migration adds this implementation baseline for the app:

| Area | Decision |
| --- | --- |
| Common TMF fields | Add reusable typed columns such as `tmf_id`, `tmf_href`, `tmf_type`, `tmf_base_type`, `tmf_schema_location`, `tmf_referred_type`, `tmf_name`, `tmf_description`, `tmf_lifecycle_status`, `tmf_state`, dates, priority, and external ID to every V001 app table. |
| Full TMF compatibility | Keep the V001 `tmf_payload` column as the complete validated TMF resource snapshot for fields that are not yet promoted to typed columns. |
| Characteristics and references | Add normalized `tmf_characteristic`, `tmf_resource_reference`, `tmf_external_identifier`, `tmf_related_party`, `tmf_note`, `tmf_attachment`, and `tmf_relationship` support tables. |
| API/resource map | Add `tmf_api_resource_map` rows for the selected local TMF APIs and resource roots. |
| Event contracts | Add baseline event contract rows for create, update, state-change, and delete events per reviewed API resource. |
| Privacy and audit | Add table-level privacy, retention, legal-hold, residency, masking, and audit policy rows. |
| High-volume candidates | `platform_admin_security.event_outbox` |

## Event Contract Baseline

Events are registered in `platform_admin_security.event_contract` using `platform_admin_security.event_outbox` as the publication basis. Consumers must be added when integrations are designed; no app should directly write another app schema.

## Privacy, Retention, And Audit Baseline

| Table | Data classification | Retention class | Audit level |
| --- | --- | --- | --- |
| `platform_admin_security.tenant` | restricted | regulated_lifecycle | high |
| `platform_admin_security.environment` | restricted | regulated_lifecycle | high |
| `platform_admin_security.platform_user` | restricted | regulated_lifecycle | high |
| `platform_admin_security.platform_role` | restricted | regulated_lifecycle | high |
| `platform_admin_security.platform_permission` | restricted | regulated_lifecycle | high |
| `platform_admin_security.user_group` | restricted | regulated_lifecycle | high |
| `platform_admin_security.authorization_policy` | restricted | regulated_lifecycle | high |
| `platform_admin_security.platform_configuration` | restricted | regulated_lifecycle | high |
| `platform_admin_security.secret_certificate_metadata` | restricted | regulated_lifecycle | high |
| `platform_admin_security.access_audit_reference` | restricted | regulated_lifecycle | high |
| `platform_admin_security.event_outbox` | restricted | regulated_lifecycle | high |

## Build Gate Result

| Gate item | Result |
| --- | --- |
| API/resource review | Complete for baseline implementation |
| V002 typed DDL | Complete: `database/postgres/suites/ts_enterprise_platform_governance/V003__refine_platform_admin_security_tmf_core.sql` |
| Event contract register | Baseline complete |
| Privacy/retention/audit classification | Baseline complete |
| Remaining implementation control | Validate exact endpoint operations and contract tests as Angular/Spring Boot features are built |
