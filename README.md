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


## Here are some insights we can generate from the database:

 Detect inactive users in the last 10 days

 Identify the most popular photos and hashtags

 Find mutual followers (users who follow each other)

 Top 3 most active commenters

 Photo that reached 10 likes the fastest

📊 Calculate user engagement rate: (likes + comments) / followers
