CREATE TABLE content_details_netflix (
content_details_netflix ;
    show_id INT PRIMARY KEY,  -- Ye Main ID hai
    type VARCHAR(50),
    title VARCHAR(500),
    rating VARCHAR(50),
    movie_duration_minute FLOAT,
    movie_season FLOAT
);
Copy content_details_netflix from 'C:\Users\QC#\content_details_netflix.csv'
CSV Header 
Delimiter ','
content_details_netflix ;
;


SElect * from content_details_netflix ;



CREATE TABLE production_info (
    show_id INT,
    director VARCHAR(500),
    country VARCHAR(500),
    date_added DATE,
    release_year INT,
    categery VARCHAR(500),
    CONSTRAINT fk_netflix_show 
        FOREIGN KEY (show_id) 
        REFERENCES content_details_netflix(show_id)
);
Copy production_info from 'C:\Users\QC#\production_info.csv'
CSV Header 
Delimiter ','
;
SElect * from production_info;

--TV show vs MOVIES
SELECT type,count(*) as TOTAL_COUNT
from content_details_netflix                      --(IN my data set there are total 6126 movies and 2664 are TV Show)
group by type;
--- data after 2020 
Select c.type,p.release_year,count(*) as total_count from content_details_netflix as c
JOIN production_info as p
ON c.show_id=p.show_id                                      --(277 movies and 315 Tv Show)
where  p.release_year>2020
group by c.type,p.release_year;

--Short_content

SELECT title,movie_duration_minute from content_details_netflix    --(486 of the total these are short_content)   
where movie_duration_minute between 1 and 60;

--Rating count
SELECT rating,count(*) as rating_count from 
content_details_netflix                         ---(higest rating is TV-MA and TV-14)
group by rating
order by rating_count desc;

--rare conent like TV-17
select c.title,c.rating,p.director,p.categery,p.country
from content_details_netflix as c                ---(NC-17 is globall contect with three tiles and these are comady and dramas with country#
JOIN production_info as p                        ---LIKE  canada ,france, USA)
ON c.show_id=p.show_id    
WHERE rating='NC-17';

--TOP 5 country most movie and TV_show
select p.country,c.type,count(c.show_id) as total_count
FROM content_details_netflix as c             
JOIN production_info as p                        
ON c.show_id=p.show_id                   --(uk,usa ,india have big content on netflix
WHERE p.country !='Unknown'              -- uk is big producer of both movies and tv show  with 2395 tiles in movies and 845 tv show 
group by p.country,c.type                --- india is on second rank with movies .movies totle=976
ORDER BY total_count DESC LIMIT 10;      ---- pakistan is on 5th rank with Tv show title =350)


-- PAK vs India
select categery,country,count(*) as total_count
FROM production_info
where country IN('India','Pakistan')        ---(in india most data contains dramas,comendies,Action & Adventure
group by categery,country                   --- but data of pakistan contains International TV Shows,Kids' TV,Docuseries)
order by  country,total_count desc;

--UK vs USA
select categery,country,count(*) as total_count
FROM production_info
where country IN('United Kingdom','United States')       
group by categery,country                                 ---(UK DATA CONTAIN  British TV Shows,Documentaries,Dramas CONTENT
order by  country,total_count desc;     
                                                            ---USA data contain content Dramas,Documentaries,Comedies,Children & Family Movies,
                                                             ---- Action & Adventure,Stand-Up Comedy.)  












