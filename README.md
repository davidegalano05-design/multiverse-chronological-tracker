# 🌌 Multiverse Chronological Tracker

A relational database designed in **PostgreSQL** to manage and orchestrate complex viewing orders (rewatches) across multiple narrative continuities, cinematic universes, and print media.

## 🎯 Project Objective
This project was born to solve a classic data management problem: the inconsistency between the actual release date of a work and its chronological placement within a complex expanded narrative (e.g., Marvel Cinematic Universe, Fox X-Men Universe, DC Comics). 

The architecture allows for the real-time extraction of a coherent viewing timeline, handling time jumps, cross-universe crossovers, and different multimedia formats.

## 🏗️ Architecture and Relational Schema
The database has been normalized and divided into distinct entities to ensure scalability and data integrity:

- **Universes**: Registry of various continuities (e.g., *Earth-616*, *Earth-10005*).
- **Media_Entities**: Centralized catalog hosting Movies, TV Series, Short Films, and Comics.
- **Characters**: Registry of characters and their secret identities.
- **Timeline_Order**: Bridge table that assigns media to its respective universe, providing an exact temporal coordinate (`chronological_position`).
- **Media_Characters (Many-to-Many)**: Pure relational table to track multiple character appearances across different media.
- **Watch_Logs**: Personal tracking system to record rewatch progress and ratings.

## ⚙️ Business Logic and PL/pgSQL
Beyond the relational structure (DDL) and data insertion (DML), the project implements server-side logic using **PL/pgSQL**:

- **Views**: Implementation of `v_multiverse_timeline` to abstract complex queries with multiple JOINs, offering the client a ready-made, formatted virtual table with the perfect viewing order.
- **Triggers and Functions**: Implementation of a `BEFORE INSERT OR UPDATE` trigger on the log table. A PL/pgSQL function (`check_valid_watch_log()`) autonomously validates the inserted rating, correcting null values and blocking out-of-scale ratings via exceptions (`RAISE EXCEPTION`).

## 🛠️ Tech Stack
- **Database Engine**: PostgreSQL
- **Database Management**: pgAdmin
- **Query Language**: SQL / PL/pgSQL

---
*Project developed as a practical case study for exploring Data Engineering and the design of robust relational databases.*