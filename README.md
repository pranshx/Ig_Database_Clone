#  Instagram Clone Database (SQL Project)

A relational database schema inspired by Instagram, built to practice SQL concepts such as joins, subqueries, window functions, and many-to-many relationships. The project includes analytics queries to study user engagement, growth trends, and content popularity.

## 📂 Project Structure

```
ig_clone_sql_project/
│── schema.sql          # Database schema (tables, relationships)
│── sample_data.sql     # Dummy data for testing
│── queries/
│     ├── beginner_queries.sql
│     ├── intermediate_queries.sql
│     ├── advanced_queries.sql
│── results/
│     ├── query_outputs.png   # screenshots of sample query results
│     └── er-diagram.png      # database ER diagram
│── README.md

```
## 🗂️ Schema Design

The schema includes core entities of an Instagram-like app:

Users – user profiles

Photos – images uploaded by users

Comments – text feedback on photos

Likes – likes on photos (user ↔ photo)

Follows – user relationships (follower ↔ followee)

Tags – hashtags linked to photos (many-to-many)

## 👉 ER Diagram:
![ER Diagram](ER_Ig_Clone.png)
## 👉 Here are some insights we can generate from the database:

 1. Detect inactive users in the last 10 days

 2. Identify the most popular photos and hashtags

 3. Find mutual followers (users who follow each other)

 4. Top 3 most active commenters

 5. Photo that reached 10 likes the fastest

 6. Calculate user engagement rate: (likes + comments) / followers

 ## ⚡ How to Run

#### 1. Clone the repo
```
git clone https://github.com/pranshx/Ig_Database_Clone.git
cd Ig_Database_Clone
```
#### 2. Create the database and load schema
```
mysql -u root -p < Ig_Clone_schema.sql
mysql -u root -p < Ig_Clone_Inserting_Data.sql
```
#### 3. Run queries from the ``` queries/ ``` folder.
