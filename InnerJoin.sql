USE db_inner_join;

select * from authors;
select * from books;

select * from authors
join books 
on authors.author_id = books.author_id;

select a.author_id, a.first_name, a.last_name,a.birth_year, b.book_id, b.title, b.publication_year,b.price from authors a
inner join books b
on a.author_id = b.author_id order by birth_year,publication_year;


-- how many books each author has written

select a.author_id, count(*)
from authors a
inner join books b
on a.author_id = b.author_id group by  author_id;

-- Create categories table for many-to-many relationship example
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

INSERT INTO categories (category_id, category_name)
VALUES 
    (1, 'Fiction'),
    (2, 'Classic'),
    (3, 'Romance'),
    (4, 'Political'),
    (5, 'Mystery'),
    (6, 'Adventure');

-- Create junction table for book-category many-to-many relationship
CREATE TABLE book_categories (
    book_id INT,
    category_id INT,
    PRIMARY KEY (book_id, category_id)
);

INSERT INTO book_categories (book_id, category_id)
VALUES 
    ((101, 1), (101, 2), (101, 3), -- Pride and Prejudice: Fiction, Classic, Romance
    (102, 1), (102, 2), (102, 4), -- 1984: Fiction, Classic, Political
    (103, 1), (103, 2), (103, 4), -- Animal Farm: Fiction, Classic, Political
    (104, 1), (104, 2), (104, 6), -- The Old Man and the Sea: Fiction, Classic, Adventure
    (105, 1), (105, 5), -- Murder on the Orient Express: Fiction, Mystery
    (106, 1), (106, 5), -- Death on the Nile: Fiction, Mystery
    (107, 1), (107, 2), (107, 3), -- Emma: Fiction, Classic, Romance
    (108, 1), (108, 2), (108, 6)); -- For Whom the Bell Tolls: Fiction, Classic, Adventure
    
show tables;
    
select b.title, a.first_name, a.last_name, b.publication_year,
group_concat(d.category_name separator ' | ') as 'Genre' from authors a 
inner join books b on b.author_id  = a.author_id 
inner join book_categories c on c.book_id = b.book_id
inner join categories d on d.category_id = c.category_id and b.publication_year < year(date_sub(curdate(),interval 70 year)) group by b.book_id;


select * from books  where publication_year < year(date_sub(curdate(),interval 70 year));


