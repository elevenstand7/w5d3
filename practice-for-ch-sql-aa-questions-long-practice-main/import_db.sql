
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

)



CREATE TABLE replies(

)



CREATE TABLE question_likes(

)