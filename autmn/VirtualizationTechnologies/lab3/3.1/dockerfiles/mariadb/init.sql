CREATE DATABASE IF NOT EXISTS rumskiy;

USE rumskiy;

CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    text VARCHAR(255) NOT NULL
);

INSERT INTO messages (text) VALUES
    ('hello'),
    ('darkness'),
    ('my'),
    ('old'),
    ('friend');
    
