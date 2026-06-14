# Data, Reporting, And Intelligence App

## Purpose

Ingest, model, govern, analyze, report, and activate data from all product suites for operational intelligence, executive reporting, regulatory reporting, AI, and decision support.

## Primary Personas

- Data analyst: builds operational and analytical views.
- Executive: reviews KPIs across commercial, network, customer, finance, and operations.
- Operations lead: monitors bottlenecks, risk, SLA, and health.
- Data steward: governs reference data and quality.
- AI/product owner: uses curated data for insight and automation.
- Regulatory reporting user: produces scheduled and evidence-backed reports.

## Core Workflow

1. Ingest data from BSS, OSS, digital, partner, platform, external systems, events, and CDC.
2. Curate common models for customer, product, service, resource, site, order, bill, usage, assurance, partner, and finance data.
3. Govern reference data, mappings, code sets, quality rules, lineage, and stewardship.
4. Produce dashboards, operational reports, regulatory reports, and data products.
5. Detect anomalies, churn risk, capacity hotspots, service degradation, revenue leakage, and bottlenecks.
6. Feed insights into workflows, planning, sales, assurance, care, and automation.

## Module Capability Matrix

| Module | Detailed Capabilities | Related APIs |
| --- | --- | --- |
| Operational Data Platform | Ingest, model, curate, and serve data from BSS, OSS, digital, partner, platform, and external systems. Support batch, streaming, CDC, event-sourced pipelines, and common domain models. | Consumes data across all TMF APIs |
| Master Data And Reference Data | Govern geography, technology, product families, service types, resource types, status codes, reason codes, channels, organizations, mappings, stewardship, approvals, versioning, and data quality. | Cross-cutting across all suites |
| KPI And Dashboard | Provide dashboards for executive, commercial, OSS, assurance, capacity, billing, revenue, partner, and platform operations. Support drill-down from KPI to operational entities. | Cross-cutting across all suites |
| Analytics And AI Insight | Detect anomalies, risk, recommendations, churn, capacity hotspots, service degradation, operational bottlenecks, explainable insights, and recommended actions. | [TMF915](../../../references/tmforum-open-apis/openapi-specs/TMF915_AIManagementSuite), [TMF696](../../../references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement), [TMF680](../../../references/tmforum-open-apis/openapi-specs/TMF680_Recommendation) |
| Reporting And Regulatory | Produce scheduled, ad hoc, regulatory, operational, partner, finance, and compliance reports with access control, lineage, evidence, retention, and external reporting integration. | [TMF667](../../../references/tmforum-open-apis/openapi-specs/TMF667_Document), cross-cutting across all suites |

## Data Ownership

Owns curated analytical models, data products, reference data governance, dashboards, reports, insights, lineage, and data quality records. It does not replace operational systems of record.

## First Release Scope

Deliver operational data ingestion, reference data, core KPI dashboards, report catalog, and initial analytics. Add AI insight loops, real-time data products, and advanced governance after core transactional APIs stabilize.

