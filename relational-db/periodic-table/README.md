# Periodic Table Database

## Problem Link

[Link to the problem](https://www.freecodecamp.org/learn/relational-database/build-a-periodic-table-database-project/build-a-periodic-table-database)

## Project Overview

In this project, you will build a Periodic Table Database by fixing errors in the provided database and creating a script that outputs information about chemical elements based on their atomic number, symbol, or name.

---

## Instructions

### Part 1: Fix the Database

There are some issues in the database that need to be fixed. Below is a list of user stories with instructions on what needs to be changed.

1. **Rename Columns:**
   - Rename the `weight` column to `atomic_mass`.
   - Rename `melting_point` to `melting_point_celsius` and `boiling_point` to `boiling_point_celsius`.

2. **Null Constraints:**
   - The `melting_point_celsius` and `boiling_point_celsius` columns should not accept null values.

3. **Constraints:**
   - Add the `UNIQUE` constraint to the `symbol` and `name` columns in the `elements` table.
   - The `symbol` and `name` columns should have the `NOT NULL` constraint.

4. **Foreign Key Relationship:**
   - Set the `atomic_number` column from the `properties` table as a foreign key that references the column of the same name in the `elements` table.

5. **Types Table:**
   - Create a `types` table to store the three types of elements. The table should have:
     - `type_id` column as an integer (primary key).
     - `type` column as a `VARCHAR` (cannot be null) to store the types from the `properties` table.
   - Add three rows to the `types` table, corresponding to the three types in the `properties` table.

6. **Link Properties Table to Types Table:**
   - Add a `type_id` foreign key column to the `properties` table that references the `type_id` column in the `types` table. It should be an `INT` with the `NOT NULL` constraint.
   - Ensure each row in the `properties` table links to the correct type from the `types` table.

7. **Capitalization and Cleanup:**
   - Capitalize the first letter of all the `symbol` values in the `elements` table.
   - Remove trailing zeros after the decimals in the `atomic_mass` column. Consider using a `DECIMAL` data type to achieve this.

8. **Add Elements:**
   - Add the following elements:
     - **Fluorine (F)**: Atomic number 9, mass 18.998, melting point -220, boiling point -188.1, type: nonmetal.
     - **Neon (Ne)**: Atomic number 10, mass 20.18, melting point -248.6, boiling point -246.1, type: nonmetal.

9. **Delete Nonexistent Element:**
   - Delete the element with `atomic_number` 1000 from the two tables.

10. **Remove Column:**
   - Remove the `type` column from the `properties` table.

---

### Part 2: Create Your Git Repository

1. **Initialize Git Repository:**
   - Create a `periodic_table` folder in the project folder and turn it into a git repository with `git init`.
   - Your repository should have a `main` branch with all your commits.
   - The first commit should be: `Initial commit`.
   - The following commits should have messages starting with: `fix:`, `feat:`, `refactor:`, `chore:`, or `test:`.

2. **Make Commits:**
   - Your repository should have at least five commits.

---

### Part 3: Create the Script

1. **Create a Script (element.sh):**
   - The script should be able to handle the following inputs:
     - If no argument is provided, the script should output:
       ```sh
       Please provide an element as an argument.
       ```

     - If an atomic number, symbol, or name of an element is provided, it should output the following format:
       ```sh
       The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
       ```

     - If the provided element doesn't exist, it should output:
       ```sh
       I could not find that element in the database.
       ```

2. **Make the Script Executable:**
   - Ensure the `element.sh` script has executable permissions.

---

## Final Steps

1. **Save Your Progress:**
   - After completing the tasks, save your database dump using the following command:
     ```bash
     pg_dump -cC --inserts -U freecodecamp periodic_table > periodic_table.sql
     ```
   - This will save the commands to rebuild your database in a file named `periodic_table.sql`.

2. **Submit Your Work:**
   - Save the `periodic_table.sql` file, along with the final version of your `element.sh` file, in a public Git repository.
   - Submit the URL of the repository on [freeCodeCamp.org](https://www.freecodecamp.org).

---

### Notes:
- If you leave your virtual machine, your database may not be saved. You can rebuild it using the following command:
  ```bash
  psql -U postgres < periodic_table.sql
