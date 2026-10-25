# Assignment 7 – Discord-style Chat

## Decisions I made and why

I made three tables: `users`, `channels` and `messages`, where every message points to exactly one channel and one user through a FOREIGN KEY, so the database refuses a message from a user or in a channel that does not exist. Every `id` is `BIGINT GENERATED ALWAYS AS IDENTITY`, because the server is meant to grow to millions of messages and a plain `INTEGER` stops at about 2.1 billion, while `BIGINT` will never run out and the database picks the numbers itself, so two rows cannot get the same id. The time `sent_at` is `TIMESTAMPTZ` and not `TIMESTAMP`, because the users live in different time zones: it stores the exact moment, so "18:00 in Sofia" and "16:00 in London" are correctly the same time and messages sort in the real order, and every user can see it in their own local time. I deliberately do not store the message count of a user (it is counted with `COUNT` when needed, so it can never be out of date), the channel name inside each message (only `channel_id`), or any user time zone, edits or direct messages, because the task does not need them yet. I also added an index on `(channel_id, sent_at DESC, id DESC)` so that "the last 20 messages in a channel" stays fast even with millions of rows, and `id` is used as a tie-breaker when two messages arrive in the same second.

## Files

- `dump.sql` – full export of the `chat` database (structure + data), made with `pg_dump`
- `queries.sql` – the two queries from the task, with comments
