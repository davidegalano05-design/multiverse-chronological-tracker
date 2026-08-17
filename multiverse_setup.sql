-- ==========================================
-- 1. CREAZIONE DELL'ARCHITETTURA (DDL)
-- ==========================================

CREATE TABLE Universes (
    id_universe SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE Media_Entities (
    id_media SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    release_date DATE,
    media_type VARCHAR(50) CHECK (media_type IN ('Movie', 'TV Series', 'Short', 'Comic Book')),
    duration_minutes INT
);

CREATE TABLE Timeline_Order (
    id_timeline SERIAL PRIMARY KEY,
    id_media INT REFERENCES Media_Entities(id_media) ON DELETE CASCADE,
    id_universe INT REFERENCES Universes(id_universe) ON DELETE CASCADE,
    chronological_position INT NOT NULL,
    in_universe_year INT,
    UNIQUE(id_universe, chronological_position) 
);

CREATE TABLE Characters (
    id_character SERIAL PRIMARY KEY,
    real_name VARCHAR(150),
    alias VARCHAR(150) NOT NULL
);

CREATE TABLE Media_Characters (
    id_media INT REFERENCES Media_Entities(id_media) ON DELETE CASCADE,
    id_character INT REFERENCES Characters(id_character) ON DELETE CASCADE,
    PRIMARY KEY (id_media, id_character)
);

CREATE TABLE Watch_Logs (
    id_log SERIAL PRIMARY KEY,
    id_media INT REFERENCES Media_Entities(id_media) ON DELETE CASCADE,
    watch_date DATE DEFAULT CURRENT_DATE,
    rating INT CHECK (rating >= 1 AND rating <= 10)
);

-- ==========================================
-- 2. POPOLAMENTO DEI DATI (DML)
-- ==========================================

INSERT INTO Universes (name, description) VALUES
('Terra-616', 'La continuity principale (Sacra Linea Temporale)'),
('Terra-10005', 'L''universo originale dei film degli X-Men (Fox)'),
('Terra-Prime (DC)', 'Continuity principale fumetti DC post-Flashpoint');

INSERT INTO Media_Entities (title, release_date, media_type, duration_minutes) VALUES
('Captain America: Il primo Vendicatore', '2011-07-22', 'Movie', 124),
('Iron Man', '2008-05-02', 'Movie', 126),
('WandaVision', '2021-01-15', 'TV Series', 350),
('Agatha All Along', '2024-09-18', 'TV Series', 320),
('X-Men', '2000-07-14', 'Movie', 104),
('The Avengers', '2012-05-04', 'Movie', 143),
('Loki', '2021-06-09', 'TV Series', 290),
('Spider-Man: No Way Home', '2021-12-17', 'Movie', 148),
('Deadpool & Wolverine', '2024-07-26', 'Movie', 127),
('Thunderbolts*', '2025-05-02', 'Movie', 130),
('Avengers: Doomsday', '2026-05-01', 'Movie', 150),
('Flashpoint (Issues 1-5)', '2011-05-11', 'Comic Book', NULL),
('Flash Maxi serie (52-63)', '2021-01-01', 'Comic Book', NULL);

INSERT INTO Timeline_Order (id_media, id_universe, chronological_position, in_universe_year) VALUES
(1, 1, 1, 1943), (2, 1, 2, 2010), (3, 1, 3, 2023), 
(4, 1, 4, 2026), (5, 2, 1, 2000), (6, 1, 5, 2012), 
(7, 1, 6, 2023), (8, 1, 7, 2024), (9, 2, 2, 2024);

INSERT INTO Characters (real_name, alias) VALUES
('Tony Stark', 'Iron Man'),
('John Walker', 'US Agent'),
('Robert Reynolds', 'Sentry'),
('Barry Allen', 'The Flash');

INSERT INTO Media_Characters (id_media, id_character) VALUES 
(2, 1), (6, 1), (10, 2), (10, 3), (11, 2), (11, 3), (12, 4), (13, 4);

-- ==========================================
-- 3. VISTE E LOGICA PL/pgSQL
-- ==========================================

CREATE OR REPLACE VIEW v_multiverse_timeline AS
SELECT 
    t.chronological_position AS ordine_visione,
    m.title AS titolo_opera,
    m.media_type AS formato,
    t.in_universe_year AS anno_narrativo,
    u.name AS universo_di_appartenenza
FROM Timeline_Order t
JOIN Media_Entities m ON t.id_media = m.id_media
JOIN Universes u ON t.id_universe = u.id_universe
ORDER BY u.name, t.chronological_position;

CREATE OR REPLACE FUNCTION check_valid_watch_log()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.rating IS NULL THEN
        NEW.rating := 6;
    END IF;
    IF NEW.rating < 1 OR NEW.rating > 10 THEN
        RAISE EXCEPTION 'Il voto deve essere compreso tra 1 e 10. Voto inserito: %', NEW.rating;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_before_insert_log
BEFORE INSERT OR UPDATE ON Watch_Logs
FOR EACH ROW
EXECUTE FUNCTION check_valid_watch_log();
