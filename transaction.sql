-- клиент берет книгу
BEGIN;
INSERT OR ROLLBACK INTO actions (book_id, reader_id) VALUES (2, 3389);

UPDATE OR ROLLBACK books
SET count=count-1
WHERE id=2;

-- select changes();
END;