-- Create the database that we'll use to populate data and watch the effect in the binlog
CREATE DATABASE demo;
GO

USE demo;
GO

-- Enable Change Data Capture for the demo database
EXEC sys.sp_cdc_enable_db;
GO

-- BEGIN TABLE movies
DROP TABLE IF EXISTS movies;
CREATE TABLE movies
(
    movie_id             int           NOT NULL,
    title                varchar(256)  NOT NULL,
    release_year         int           NOT NULL,
    country              varchar(256)  NOT NULL,
    genres               varchar(256)  NOT NULL,
    actors               varchar(1024) NOT NULL,
    directors            varchar(512)  NOT NULL,
    composers            varchar(256)  NOT NULL,
    screenwriters        varchar(256)  NOT NULL,
    cinematographer      varchar(256)  NOT NULL,
    production_companies varchar(256)  NOT NULL,
    PRIMARY KEY (movie_id)
);
GO

-- Enable Change Data Capture for the movies table
EXEC sys.sp_cdc_enable_table
    @source_schema = 'dbo',
    @source_name   = 'movies',
    @role_name     = NULL,  -- use NULL for default capture
    @supports_net_changes = 1;
GO

-- Insert sample data into the movies table
INSERT INTO movies (movie_id, title, release_year, country, genres, actors, directors, composers, screenwriters,
                    cinematographer, production_companies)
VALUES (1, 'Once Upon a Time in the West', 1968, 'Italy', 'Western',
        'Claudia Cardinale|Charles Bronson|Henry Fonda|Gabriele Ferzetti|Frank Wolff|Al Mulock|Jason Robards|Woody Strode|Jack Elam|Lionel Stander|Paolo Stoppa|Keenan Wynn|Aldo Sambrell',
        'Sergio Leone', 'Ennio Morricone', 'Sergio Leone|Sergio Donati|Dario Argento|Bernardo Bertolucci',
        'Tonino Delli Colli', 'Paramount Pictures'),
       (2, '10,000 B.C.', 2008, 'United States', 'Adventure',
        'Steven Strait|Camilla Belle|Cliff Curtis|Omar Sharif|Tim Barlow|Marco Khan|Reece Ritchie|Mo Zinal',
        'Roland Emmerich', 'Harald Kloser|Thomas Wanker',
        'Roland Emmerich|Harald Kloser|John Orloff|Matthew Sand|Robert Rodat', 'Ueli Steiger',
        'Warner Bros. Pictures|Legendary Pictures|Centropolis');
GO
