/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_births >= '2016-01-01' AND date_of_births <= '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_births FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- TRANSACIONS

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
COMMIT;

BEGIN;
UPDATE animals SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon'
WHERE species IS NULL OR species = '';
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals
WHERE date_of_births > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

-- QUERIES 
-- How many animals are there?
SELECT COUNT(*)
FROM animals;

-- 2.How many animals have never tried to escape?
SELECT COUNT(*)
FROM animals
WHERE escape_attempts = 0;

-- 3.What is the average weight of animals?
SELECT AVG(weight_kg)
FROM animals;

-- 4.Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

-- 5.What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

-- 6.What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) 
FROM animals
WHERE date_of_births BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- MULTIPLE TABLES
-- 
-- 1.What animals belong to Melody Pond?
SELECT * FROM animals LEFT JOIN owners 
ON  owner_id = owners.id
WHERE full_name = 'Melody Pond';

-- 2.List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals LEFT JOIN species
ON species_id = species.id
WHERE species.name = 'Pokemon';

-- 3.List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.id AS id, owners.full_name AS full_name, owners.age AS age, animals.name AS animal_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

-- 4.How many animals are there per species?
SELECT species.name AS species_name, COUNT(animals.id) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.id, species.name;

-- 5.List all Digimon owned by Jennifer Orwell.
SELECT owners.full_name AS owner_name, COUNT(animals.id) AS digimon_count
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell'
GROUP BY owners.full_name;

-- 6.List all animals owned by Dean Winchester that haven't tried to escape.
SELECT owners.full_name AS owner_name, COALESCE(COUNT(animals.id), 0) AS animal_count
FROM owners
LEFT JOIN animals ON animals.owner_id = owners.id AND animals.escape_attempts = 0
WHERE owners.full_name = 'Dean Winchester'
GROUP BY owners.full_name;

-- 7.Who owns the most animals?
SELECT owners.full_name AS owner_name, COUNT(animals.id) AS animal_count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;