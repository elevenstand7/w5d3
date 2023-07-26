
CREATE TABLE users(
id INTEGER PRIMARY KEY,
fname TEXT NOT NULL,
lname TEXT NOT NULL
);

CREATE TABLE questions(
id INTEGER PRIMARY KEY,
title TEXT NOT NULL,
body TEXT NOT NULL,
author TEXT NOT NULL,

FOREIGN KEY (author) REFERENCES users(id)
);

CREATE TABLE question_follows(
user_id INTEGER NOT NULL,
question_id INTEGER NOT NULL
)



CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    pre_question_id INTEGER NOT NULL,
    parent_reply_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (pre_question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
)



CREATE TABLE question_likes(


)
