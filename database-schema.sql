drop database if exists projectdb;
create database projectdb;

use projectdb;

CREATE TABLE users (
    id BINARY(16) NOT NULL,
    loginid VARCHAR(15) NOT NULL UNIQUE,
    password BINARY(16) NOT NULL,
    email VARCHAR(255) NOT NULL,
    fullname VARCHAR(255) NOT NULL,
    github_auth BINARY(16) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE user_roles (
    userid BINARY(16) NOT NULL,
    role ENUM ('registered', 'admin'),
    FOREIGN KEY (userid) REFERENCES users(id) on delete cascade,
    PRIMARY KEY (userid, role)
);

CREATE TABLE auth_tokens (
    userid BINARY(16) NOT NULL,
    token BINARY(16) NOT NULL,
    FOREIGN KEY (userid) REFERENCES users(id) on delete cascade,
    PRIMARY KEY (token)
);

CREATE TABLE projects (
    id BINARY(16) NOT NULL,    
    name VARCHAR(100) NOT NULL, 
    description VARCHAR(500),
    creation_timestamp DATETIME not null default current_timestamp,    
    repo_url VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE user_projects (
    userid BINARY(16) NOT NULL,
    projectid BINARY(16) NOT NULL,
    FOREIGN KEY (userid) REFERENCES users(id) on delete cascade,
    FOREIGN KEY (projectid) REFERENCES projects(id) on delete cascade
);

CREATE TABLE tasks (
    id BINARY(16) NOT NULL,    
    creator_userid BINARY(16) NOT NULL,
    title VARCHAR(100) NOT NULL, 
    state ENUM ('proposal', 'in_process', 'completed') NOT NULL default 'proposal',
    description VARCHAR(500),
    creation_timestamp DATETIME not null default current_timestamp,    
    due_timestamp DATETIME,
    label ENUM ('bug', 'enhancement'),
    FOREIGN KEY (creator_userid) REFERENCES users(id) on delete cascade,
    PRIMARY KEY (id)    
);

CREATE TABLE user_tasks (
    userid BINARY(16) NOT NULL,
    taskid BINARY(16) NOT NULL,
    FOREIGN KEY (userid) REFERENCES users(id) on delete cascade,
    FOREIGN KEY (taskid) REFERENCES tasks(id) on delete cascade
);

CREATE TABLE checklist_items (
    id BINARY(16) NOT NULL,
    title VARCHAR(100) NOT NULL,
    checked boolean NOT NULL default 0,
    user_checked BINARY(16),
    FOREIGN KEY (user_checked) REFERENCES users(id) on delete cascade,
    PRIMARY KEY (id)
);

CREATE TABLE project_events (
    id BINARY(16) NOT NULL,
    title VARCHAR(100) NOT NULL,
    date_timestamp DATETIME NOT NULL,
    projectid BINARY(16) NOT NULL,
    FOREIGN KEY (projectid) REFERENCES projects(id) on delete cascade,
    PRIMARY KEY (id)     
);

CREATE TABLE project_comments (
    id BINARY(16) NOT NULL,
    content VARCHAR(100) NOT NULL,
    date_timestamp DATETIME NOT NULL,
    projectid BINARY(16),    
    FOREIGN KEY (projectid) REFERENCES projects(id) on delete cascade,    
    PRIMARY KEY (id)     
);

CREATE TABLE task_comments (
    id BINARY(16) NOT NULL,
    content VARCHAR(100) NOT NULL,
    date_timestamp DATETIME NOT NULL,
    taskid BINARY(16),       
    FOREIGN KEY (taskid) REFERENCES tasks(id) on delete cascade,
    PRIMARY KEY (id)     
);

CREATE TABLE invites (
    id BINARY(16) NOT NULL,
    userid BINARY(16) NOT NULL,
    projectid BINARY(16) NOT NULL,          
    FOREIGN KEY (userid) REFERENCES users(id) on delete cascade,
    FOREIGN KEY (projectid) REFERENCES projects(id) on delete cascade,
    PRIMARY KEY (id)     
);

