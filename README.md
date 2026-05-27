# University Enterprise Data Reporting System

## 📌 Project Overview
This project presents a robust suite of SQL relational reporting tools designed for university administration, academic advisors, and institutional data teams. The system queries an enterprise operational database to deliver critical business intelligence across three primary domain tracks: **Enrollment Dynamics, Risk Management Audits, and Student Performance Tracking.**

Instead of isolated operational logs, these queries convert normalized transactional data into structured, strategic insights that stakeholders can immediately use to optimize scheduling, distribute resources, and guide academic intervention.

---

## 🛠️ Data Architecture & SQL Capabilities Demonstrated
The analytics script showcases production-grade SQL practices designed for data integrity, performance, and clear reporting:
* **Relational Joins:** Advanced execution of `INNER JOIN` and multi-table bridges to synthesize fields across Student, Faculty, and Course entities.
* **Data Auditing via Outer Joins:** Implementation of `LEFT JOIN ... WHERE [Key] IS NULL` isolation logic to audit operational gaps (unassigned courses).
* **Aggregations & Filters:** Strategic utilization of `GROUP BY` configurations paired with `HAVING` filters to calculate complex statistical averages across multiple text dimensions.
* **Optimized Conditional Logic:** Layered, non-overlapping `CASE WHEN` evaluations used to generate deterministic grading outputs without runtime data leakage.

---

## 📊 Core Business Intelligence Reports Implemented

### 1. Strategic Enrollment & Trend Mapping
* **Objective:** Track annual student volume trajectories to determine physical resource allocation.
* **Technical Highlights:** High-level date parsing (`YEAR()`) combined with nested multi-column sorting rules.

### 2. Operational Gaps & Risk Management Audit
* **Objective:** Instantly flag active courses that are failing compliance due to having zero assigned faculty members.
* **Technical Highlights:** `LEFT JOIN` operations filtered specifically down to empty primary key results (`IS NULL`).

### 3. Early Intervention Retention Reporting
* **Objective:** Isolate high-risk students whose rolling performance metrics fall below the 50% structural average to register them for proactive tutoring.
* **Technical Highlights:** Post-aggregation data isolation leveraging the `HAVING` clause over multi-field group indices.

### 4. Continuous Student Profile Matrix
* **Objective:** Produce a complete grade matrix evaluating students simultaneously on their lowest baseline performance tier and their highest execution ceiling.
* **Technical Highlights:** Evaluates streaming metric data using a top-down logical scale directly built into scalable `CASE` logic blocks.

---

## 🧠 Technical Challenges Overcome & Lessons Learned
* **Alias Enforcement Gaps:** Initially experimented with using string literal encapsulation (`'column_name'`) within active sorting matrices. Encountered runtime misreads across testing blocks. Resolved the issue by adopting standardized SQL aliases (`AS column_name`) or utilizing precise numerical matrix locations (`ORDER BY 1, 2`).
* **Complex Multi-Attribute Grouping:** Encountered scalar expression errors when attempting to output granular descriptive dimensions (e.g., student name strings) alongside raw database IDs. Remedied this system block by ensuring all non-aggregated descriptive attributes requested within the `SELECT` clause are explicitly represented inside the underlying `GROUP BY` directive.
* **Deterministic Boundary Calculations:** Discovered that standard `BETWEEN` logic structures often cause minor data omission gaps near float boundary points (e.g., values falling exactly between 39.1 and 39.9). Optimized the grading matrices into a clean, top-down chronological elimination tree using explicit relational boundary conditions (`< 40`, `< 50`, etc.).
