# 🌌 Multiverse Chronological Tracker

Un database relazionale progettato in **PostgreSQL** per gestire e orchestrare complessi ordini di visione (rewatch) attraverso molteplici continuità narrative, universi cinematografici e media cartacei.

## 🎯 Obiettivo del Progetto
Questo progetto nasce per risolvere una problematica classica della gestione dei dati: l'incoerenza tra la data di rilascio reale di un'opera e la sua collocazione temporale all'interno di una complessa narrativa espansa (es. Marvel Cinematic Universe, Fox X-Men Universe, DC Comics). 

L'architettura permette di estrarre in tempo reale una timeline di visione coerente, gestendo salti temporali, crossover tra universi e formati multimediali differenti.

## 🏗️ Architettura e Schema Relazionale
Il database è stato normalizzato e diviso in entità distinte per garantire scalabilità e integrità dei dati:

- **Universes**: Anagrafica delle varie continuità (es. *Terra-616*, *Terra-10005*).
- **Media_Entities**: Catalogo centralizzato che ospita Film, Serie TV, Cortometraggi e Fumetti.
- **Characters**: Anagrafica dei personaggi e delle identità segrete.
- **Timeline_Order**: Tabella ponte che assegna un media al suo universo di competenza, fornendogli una coordinata temporale esatta (`chronological_position`).
- **Media_Characters (Many-to-Many)**: Tabella relazionale pura per tracciare le apparizioni multiple dei personaggi attraverso media diversi.
- **Watch_Logs**: Sistema di tracciamento personale per registrare i progressi di rewatch e i voti.

## ⚙️ Business Logic e PL/pgSQL
Oltre alla struttura relazionale (DDL) e all'inserimento dati (DML), il progetto implementa logica lato database utilizzando **PL/pgSQL**:

- **Viste (Views)**: Implementazione di `v_multiverse_timeline` per astrarre query complesse con JOIN multiple, offrendo al client una tabella virtuale già pronta e formattata con l'ordine di visione perfetto.
- **Trigger e Funzioni**: Implementazione di un trigger `BEFORE INSERT OR UPDATE` sulla tabella dei log. Una funzione PL/pgSQL (`check_valid_watch_log()`) convalida autonomamente il rating inserito, correggendo i valori nulli e bloccando tramite eccezioni (`RAISE EXCEPTION`) i voti fuori scala.

## 🛠️ Tech Stack
- **Database Engine**: PostgreSQL
- **Database Management**: pgAdmin
- **Query Language**: SQL / PL/pgSQL

---
*Progetto sviluppato come caso studio pratico per l'esplorazione della Data Engineering e della progettazione di database relazionali robusti.*