CREATE DATABASE catalog_of_my_things;

CREATE TABLE item (
                      id SERIAL PRIMARY KEY,
                      genre_id INTEGER,
                      label_id INTEGER,
                      author_id INTEGER,
                      publish_date DATE,
                      archived BOOLEAN,
                      FOREIGN KEY (genre_id) REFERENCES genre (id),
                      FOREIGN KEY (author_id) REFERENCES author (id),
                      FOREIGN KEY (label_id) REFERENCES label (id)
);


CREATE TABLE label (
                       id SERIAL PRIMARY KEY,
                       title VARCHAR(150),
                       color VARCHAR(150)
);

CREATE TABLE book (
                      id INTEGER PRIMARY KEY,
                      publisher VARCHAR(100),
                      publish_date DATE,
                      cover_state VARCHAR(100),
                      item_id INTEGER,
                      FOREIGN KEY (item_id) REFERENCES item (id)
);

CREATE INDEX idx_book_item_id ON book(item_id);
CREATE INDEX idx_item_label_id ON item(label_id);
