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