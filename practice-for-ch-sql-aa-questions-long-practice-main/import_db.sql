PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS users;

CREATE TABLE users(
id INTEGER PRIMARY KEY,
fname TEXT NOT NULL,
lname TEXT NOT NULL
);

CREATE TABLE questions(
id INTEGER PRIMARY KEY,
title TEXT NOT NULL,
body TEXT NOT NULL,
author_id INTEGER NOT NULL,

FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows(
id INTEGER PRIMARY KEY,
user_id INTEGER NOT NULL,
question_id INTEGER NOT NULL
);



CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    pre_question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (pre_question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);



CREATE TABLE question_likes(
    id INTEGER PRIMARY KEY,
    liked BOOLEAN DEFAULT 'false',
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


INSERT INTO
    users (id, fname, lname)
VALUES
    (1, 'Bob', 'Lastbob'),
    (2, 'Tim', 'Lasttim');


INSERT INTO
    questions (id, title, body, author_id)
VALUES
    (1, 'What is this', 'very long q about a body thing', 1),
    (2, 'meh', 'i tryed meh', 2);


INSERT INTO
    question_follows (id, user_id, question_id)
VALUES
    (1, 1, 2),
    (2, 2, 1);


INSERT INTO
    replies (id, body, pre_question_id, parent_reply_id, user_id)
VALUES
    (1, 'You did''t try hard enough', 2, NULL, 1),
    (2, 'It''s a... I don''t know.', 1, NULL, 2);

INSERT INTO
    question_likes (id, liked, question_id, user_id)
VALUES
    (1, 'true', 1, 1),
    (2, 'true', 2, 2);
