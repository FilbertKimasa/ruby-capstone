-- schema.sql

-- Table for genres
CREATE TABLE genres (
  id INT PRIMARY KEY,
  name VARCHAR(255)
);

-- Table for music albums
CREATE TABLE music_albums (
  id INT PRIMARY KEY,
  published_date DATE,
  archived BOOLEAN,
  on_spotify BOOLEAN,
  genre_id INT REFERENCES genres(id)
);
