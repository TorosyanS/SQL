CREATE TABLE authors
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);
CREATE INDEX ix_authors_name ON authors (name);

CREATE TABLE genre
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE books
(
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    isbn       VARCHAR(32)  NOT NULL,
    author_id  INTEGER      NOT NULL,
    title      VARCHAR(256) NOT NULL,
    annotation TEXT         NOT NULL,
    count      INTEGER      NOT NULL DEFAULT 1,

    CONSTRAINT fk_author_id
        FOREIGN KEY (author_id)
            REFERENCES authors (id)
);
CREATE INDEX ix_books_authors ON books (author_id);

CREATE TABLE books_genres
(
    book_id  INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,

    CONSTRAINT fk_book_id
        FOREIGN KEY (book_id)
            REFERENCES books (id),

    CONSTRAINT fk_genre_id
        FOREIGN KEY (genre_id)
            REFERENCES genres (id)
);
CREATE UNIQUE INDEX uix_books_genres ON books_genres(book_id, genre_id);

CREATE TABLE readers
(
    id       INTEGER PRIMARY KEY AUTOINCREMENT,
    name     VARCHAR(128) NOT NULL,
    phone    VARCHAR(32)  NOT NULL,
    birthday DATE
);
CREATE UNIQUE INDEX uix_readers_phone ON readers (phone);

CREATE TABLE actions
(
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id   INTEGER NOT NULL,
    reader_id INTEGER NOT NULL,
    date      DATE NOT NULL DEFAULT (DATE()),
    return    DATE NOT NULL DEFAULT (DATE('NOW', '+7 DAY')),

    CONSTRAINT fk_book_id
        FOREIGN KEY (book_id)
            REFERENCES books (id),

    CONSTRAINT fk_reader_id
        FOREIGN KEY (reader_id)
            REFERENCES readers (id)
);
CREATE UNIQUE INDEX uix_actions_bookreader ON actions (book_id, reader_id);