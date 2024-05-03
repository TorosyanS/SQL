INSERT INTO authors (name) VALUES ('Пушкин'), ('Лермонтов'), ('Гоголь'), ('Чехов');

INSERT INTO genres (name) VALUES ('Фантастика'), ('Классика'), ('Роман'), ('Драма'), ('Комедия');

INSERT INTO books (isbn, author_id, title, annotation)
WITH RECURSIVE c(x) AS (
    VALUES(1)
    UNION ALL
    SELECT x+1 FROM c WHERE x<50
)
SELECT printf('isbn %d', random()),
       abs(random()%5) + 1,
       printf('title %d', random()),
       'annotation' FROM c
RETURNING id;

INSERT INTO readers (name, phone, birthday)
WITH RECURSIVE c(x) AS (VALUES (1)
                        UNION ALL
                        SELECT x + 1
                        FROM c
                        WHERE x < 500000)
SELECT printf('name %d', random()),
       printf('+%d', abs(random())),
       date('now', printf('-%d YEAR', abs(random())%50+18), printf('-%d DAY', abs(random())%50+18)) FROM c
RETURNING id;


-- генерим должников
INSERT INTO actions (book_id, reader_id, date, return)
WITH r AS (
    SELECT id
    FROM readers
    LIMIT 500
)
SELECT 3, r.id, date('now', printf('-%d DAY', abs(random())%50+18)), date('now', printf('-%d DAY', abs(random())%5))
FROM r

