-- вывести id всех должников в порядке возрастания
SELECT reader_id
FROM actions
WHERE return < date()
ORDER BY reader_id;

-- вывести id всех должников без повторений в порядке возрастания
SELECT DISTINCT reader_id
FROM actions
WHERE return < date()
ORDER BY reader_id;

-- count(), max(age), min(age), avg(age)
-- вывести id всех должников без повторений с кол-вом книг, которые надо вернуть, топ-20 должников
SELECT reader_id, count()
FROM actions
WHERE return < date()
GROUP BY reader_id
ORDER BY count() DESC
LIMIT 20;

-- вывести id всех должников без повторений с кол-вом книг, которые надо вернуть,
-- топ-20 должников у которых задолженность >1 книги
SELECT reader_id, count()
FROM actions
WHERE return < date()
GROUP BY reader_id
HAVING count() > 1
ORDER BY count() DESC
LIMIT 20;

-- вывести id всех должников без повторений с кол-вом книг, которые надо вернуть,
-- топ-20 должников у которых задолженность >1 книги
-- +вывести дату самой последней просрочки и самой первой
SELECT reader_id, count() as count, min(return) as 'oldest', max(return) as 'newest'
FROM actions
WHERE return < date()
GROUP BY reader_id
-- HAVING count() > 1
ORDER BY count()
LIMIT 20;

-- вывести id + имя всех должников без повторений с кол-вом книг, которые надо вернуть,
-- топ-20 должников у которых задолженность >1 книги
-- +вывести дату самой последней просрочки и самой первой
WITH debtors as (SELECT reader_id, count() as count, min(return) as 'oldest', max(return) as 'newest'
                 FROM actions
                 WHERE return < date()
                 GROUP BY reader_id
                 HAVING count() > 1)
SELECT r.id, r.name, r.phone, d.count, d.oldest, d.newest
FROM debtors d
         JOIN readers r ON r.id = d.reader_id;
