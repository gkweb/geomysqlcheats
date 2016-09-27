MySQL Calculation - Geo coords (lng & lat) within a rectangle. 

Both solutions 1 & 2 taken from: 
http://stackoverflow.com/a/20741219
Supported by pre MySQL 5.6


##Solution 1

SELECT * FROM entries WHERE
(CASE WHEN a < c
        THEN lat BETWEEN a AND c
        ELSE lat BETWEEN c AND a
END) 
AND
(CASE WHEN b < d
        THEN lng BETWEEN b AND d
        ELSE lng BETWEEN d AND b
END) 


## solution 2

SELECT * FROM entries WHERE
(a < c AND lat BETWEEN a AND c) OR (c < a AND lat BETWEEN c AND a)
AND 
(b < d AND lng BETWEEN b AND d) OR (d < b AND lng BETWEEN d AND b)

## solution 3 -- Preferred - MySQL 5.6+
# location column as type POINT.

SELECT *, AsText(location) FROM entries 
WHERE Contains(
GeomFromText
(' POLYGON((nelat nelng, nelat swlng, swlat swlng, swlat nelng, nelat nelng))' ), location );

# POLYGON requires 4 points of rectangle with 5th point being the closing point of the polygon. IE: The starting point.
