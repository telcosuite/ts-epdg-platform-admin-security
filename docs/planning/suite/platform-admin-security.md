# Platform Admin And Security App

## Purpose

Administer tenants, environments, identities, access, authorization, audit, privacy evidence, secrets, platform configuration, and secure operating boundaries.

## Primary Personas

- Tenant admin: manages tenant, brand, geography, environment, and feature access.
- Security admin: governs identities, roles, scopes, privileged access, and policy.
- Platform engineer: manages secrets, certificates, integrations, and environment configuration.
- Auditor/compliance officer: reviews access, audit trails, privacy evidence, and control compliance.
- System admin: supports operational user management and configuration.

## Core Workflow

1. Create tenants, regions, environments, organizations, feature access, limits, and data boundaries.
2. Manage users, roles, groups, identity providers, service accounts, sessions, scopes, and privileged access.
3. Define authorization policies by role, attribute, tenant, channel, API, resource, geography, account, partner, and risk.
4. Audit user/API/data/admin actions and manage access review evidence.
5. Manage secrets, certificates, API credentials, webhooks, encryption keys, and external system connections.

## Module Capability Matrix

| Module | Detailed Capabilities | Related APIs |
| --- | --- | --- |
| Tenant And Environment Administration | Manage tenants, regions, environments, organizations, deployment profiles, feature access, tenant limits, branding, policies, and data boundaries. | [TMF672](../../../references/tmforum-open-apis/openapi-specs/TMF672_UserRolesPermissions) |
| Identity And Access | Manage users, groups, roles, permissions, scopes, sessions, identity providers, federation, service accounts, OAuth/OIDC, SSO, MFA, delegated administration, and privileged access. | [TMF720](../../../references/tmforum-open-apis/openapi-specs/TMF720_DigitalIdentity), [TMF691](../../../references/tmforum-open-apis/openapi-specs/TMF691_FederatedIdentity), [TMF672](../../../references/tmforum-open-apis/openapi-specs/TMF672_UserRolesPermissions) |
| Policy And Authorization | Define fine-grained policies by role, attribute, tenant, channel, API, resource, geography, account, partner, and risk. Support simulation, audit, and exceptions. | [TMF672](../../../references/tmforum-open-apis/openapi-specs/TMF672_UserRolesPermissions), [TMF696](../../../references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement) |
| Audit, Compliance, And Privacy | Track user actions, API actions, data changes, approvals, access events, exports, security events, audit search, evidence retention, access reviews, and privacy requests. | [TMF644](../../../references/tmforum-open-apis/openapi-specs/TMF644_Privacy), [TMF667](../../../references/tmforum-open-apis/openapi-specs/TMF667_Document) |
| Secrets And Platform Configuration | Manage secrets, certificates, API credentials, webhooks, encryption keys, external system connections, rotation, expiry, ownership, secure environment config, and tenant/module/integration configuration. | Platform-specific extension area |

## Data Ownership

Owns tenant metadata, environment metadata, platform identity records, access policy, authorization rules, audit records, compliance evidence, secret metadata, and platform configuration.

## First Release Scope

Deliver tenant/environment admin, identity/access, policy enforcement metadata, audit trails, and secrets management. Add privileged access workflows, access recertification, and policy simulation depth later.

