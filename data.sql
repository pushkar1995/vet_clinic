/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_births, escape_attempts, neutered, weight_kg) VALUES 
  (1, 'Agumon', '2020-02-03', 0, true, 10.23),
  (2, 'Gabumon', '2018-11-15', 2, true, 8),
  (3, 'Pikachu', '2021-01-07', 1, false, 15.04),
  (4, 'Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (id, name, date_of_births, escape_attempts, neutered, weight_kg) VALUES 
  (5, 'Charmander', '2020-02-08', 0, false, -11),
  (6, 'Plantmon', '2021-11-15', 2, true, -5.7),
  (7, 'Squirtle', '1993-04-02', 3, false, -12.13),
  (8, 'Angemon', '2005-06-12', 1, true, -45),
  (9, 'Boarmon', '2005-06-07', 7, true, 20.4),
  (10, 'Blossom', '1998-10-13', 3, true, 17),
  (11, 'Ditto', '2022-05-14', 4, true, 22);

  INSERT INTO owners (id, full_name, age) VALUES 
  (100, 'Sam Smith', 34),
  (101, 'Jennifer Orwell', 19),
  (102, 'Bob', 45),
  (103, 'Melody Pond', 77),
  (104, 'Dean Winchester', 14),
  (105, 'Jodie Whittaker', 38);

  INSERT INTO species (id, name) VALUES
  (001, 'Digimon'),
  (002, 'Pokemon');

-- Updating species_id from species table according to the names
UPDATE animals AS a
SET species_id = s.id
FROM species AS s
WHERE a.name LIKE '%mon' AND s.name = 'Digimon';

UPDATE animals AS a
SET species_id = s.id
FROM species AS s
WHERE a.species_id IS NULL AND s.name = 'Pokemon';

-- MULTIPLE TABLES
-- Updating owners_id

-- 1.Update for Sam Smith owning Agumon
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

-- 2.Update for Jennifer Orwell owning Gabumon and Pikachu
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

-- 3.Update for Bob owning Devimon and Plantmon
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

-- 4.Update for Melody Pond owning Charmander, Squirtle, and Blossom
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- 5.Update for Dean Winchester owning Angemon and Boarmon
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

-- JOIN TABLE VETS 

INSERT INTO vets (id, name, age, date_of_graduation)
VALUES
    (1, 'William Tatcher', 45, '2000-04-23'),
    (2, 'Maisy Smith', 26, '2019-01-17'),
    (3, 'Stephanie Mendez', 64, '1981-05-04'),
    (4, 'Jack Harkness', 38, '2008-06-08');

-- Add data to specializations table

INSERT INTO specializations (specialization_id, species_id, vet_id)
SELECT
    1,
    species.id AS species_id,
    vets.id AS vet_id
FROM vets
JOIN species
ON vets.name = 'William Tatcher' AND species.name = 'Pokemon';

INSERT INTO specializations (specialization_id, species_id, vet_id)
SELECT
    2,
    species.id AS species_id,
    vets.id AS vet_id
FROM vets
JOIN species
ON vets.name = 'Stephanie Mendez' AND species.name = 'Pokemon';

INSERT INTO specializations (specialization_id, species_id, vet_id)
SELECT
    3,
    species.id AS species_id,
    vets.id AS vet_id
FROM vets
JOIN species
ON vets.name = 'Stephanie Mendez' AND species.name = 'Digimon';

INSERT INTO specializations (specialization_id, species_id, vet_id)
SELECT
    4,
    species.id AS species_id,
    vets.id AS vet_id
FROM vets
JOIN species
ON vets.name = 'Jack Harkness' AND species.name = 'Digimon';

-- Add data to visit table

-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    1,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2020-05-24' AS visit_date
FROM animals
JOIN vets ON vets.name = 'William Tatcher'
WHERE animals.name = 'Agumon';


-- Plantmon visited William Tatcher on Aug 10th, 2020.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    2,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2020-08-10' AS visit_date
FROM animals
JOIN vets ON vets.name = 'William Tatcher'
WHERE animals.name = 'Plantmon';


-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    3,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2021-01-11' AS visit_date
FROM animals
JOIN vets ON vets.name = 'William Tatcher'
WHERE animals.name = 'Blossom';

-- Agumon visited Stephanie Mendez on Jul 22nd, 2020.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    4,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2020-07-22' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Stephanie Mendez'
WHERE animals.name = 'Agumon';

-- Devimon visited Stephanie Mendez on 2021-05-04.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    5,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2021-05-04' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Stephanie Mendez'
WHERE animals.name = 'Devimon';

-- Squirtle visited Stephanie Mendez on 2019-09-29.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    6,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2019-09-29' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Stephanie Mendez'
WHERE animals.name = 'Squirtle';

-- Blossom visited Stephanie Mendez on 2020-05-24.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    7,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2020-05-24' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Stephanie Mendez'
WHERE animals.name = 'Blossom';

-- Gabumon visited Jack Harkness on 2021-02-02.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    8,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2021-02-02' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Jack Harkness'
WHERE animals.name = 'Gabumon';

-- Charmander visited Jack Harkness on 2021-02-24.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    9,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2021-02-24' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Jack Harkness'
WHERE animals.name = 'Charmander';

-- Angemon visited Jack Harkness on 2020-10-03.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    10,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2020-10-03' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Jack Harkness'
WHERE animals.name = 'Angemon';

-- Angemon visited Jack Harkness on 2020-11-04.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    11,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2020-11-04' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Jack Harkness'
WHERE animals.name = 'Angemon';

-- Pikachu visited Maisy Smith on 2020-01-05.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    12,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2020-01-05' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Maisy Smith'
WHERE animals.name = 'Pikachu';

-- Pikachu visited Maisy Smith on 2020-03-08.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    13,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2020-03-08' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Maisy Smith'
WHERE animals.name = 'Pikachu';

-- Pikachu visited Maisy Smith on 2020-05-14.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    14,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2020-05-14' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Maisy Smith'
WHERE animals.name = 'Pikachu';

-- Plantmon visited Maisy Smith on 2019-12-21.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    15,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2019-12-21' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Maisy Smith'
WHERE animals.name = 'Plantmon';

-- Plantmon visited Maisy Smith on 2021-04-07.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    16,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2021-04-07' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Maisy Smith'
WHERE animals.name = 'Plantmon';

-- Boarmon visited Maisy Smith on 2019-01-24.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    17,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2019-01-24' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Maisy Smith'
WHERE animals.name = 'Boarmon';

-- Boarmon visited Maisy Smith on 2019-05-15.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    18,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2019-05-15' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Maisy Smith'
WHERE animals.name = 'Boarmon';

-- Boarmon visited Maisy Smith on 2020-02-27.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    19,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2020-02-27' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Maisy Smith'
WHERE animals.name = 'Boarmon';

-- Boarmon visited Maisy Smith on 2020-08-03.
INSERT INTO visits (visit_id, animal_id, vet_id, visit_date)
SELECT
    20,
    animals.id AS animal_id,
    vets.id AS vet_id,
    '2020-08-03' AS visit_date
FROM animals
JOIN vets ON vets.name = 'Maisy Smith'
WHERE animals.name = 'Boarmon';

-- QUERIES from 4th part (add "join table" for visits)

-- Who was the last animal seen by William Tatcher?
SELECT animals.name AS last_animal_seen
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT aNIMALS.id) AS different_animals_seen
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet_name, species.name AS specialty_name
FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vet_id
LEFT JOIN species
ON specializations.species_id = species.id
ORDER BY vets.name, species.name;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT DISTINCT animals.name AS animal_name, visits.visit_date AS visit_date
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez'
  AND visits.visit_date >= '2020-04-01'
  AND visits.visit_date <= '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name AS animal_name, COUNT(*) AS visit_count
FROM visits
JOIN animals
ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY visit_count DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name AS first_visit_animal
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
    animals.name AS animal_name,
    vets.name AS vet_name,
    visits.visit_date AS visit_date
FROM visits
JOIN vets
ON visits.vet_id = vets.id
JOIN animals
ON visits.animal_id = animals.id
ORDER BY visits.visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS visits_without_specialty
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
LEFT JOIN specializations ON vets.id = specializations.vet_id AND animals.species_id = specializations.species_id
WHERE specializations.vet_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS potential_specialty, COUNT(*) AS visit_count
FROM visits
JOIN vets
ON visits.vet_id = vets.id
JOIN animals
ON visits.animal_id = animals.id
JOIN species
ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY visit_count DESC
LIMIT 1;

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
-- this line of code inserted 11 times to reach 1000ms 


-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';