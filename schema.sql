/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;
\connect vet_clinic

CREATE TABLE animals (
    id INT not null,
    name varchar(100) not null,
    date_of_births DATE,
    escape_attempts INT,
    neutered boolean,
    weight_kg decimal,
    PRIMARY KEY (id)
);

ALTER TABLE animals
ADD species varchar(100);

-- MULTIPLE TABLES

CREATE TABLE owners (
    id INT not null,
    full_name varchar(100) not null,
    age int not null,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id INT not null,
    name varchar (100) not null,
    PRIMARY KEY (id)
);

ALTER TABLE animals
DROP COLUMN species;

-- JOIN TABLE VETS 

CREATE TABLE vets (
    id INT,
    name varchar(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

CREATE TABLE specializations (
    specialization_id INT,
    species_id INT,
    vet_id INT,
    PRIMARY KEY(specialization_id),
    FOREIGN KEY (species_id) REFERENCES species(id),
    FOREIGN KEY (vet_id) REFERENCES vets(id)
);

CREATE TABLE visits (
    visit_id INT,
    animal_id INT,
    vet_id INT,
    visit_date DATE,
    PRIMARY KEY (visit_id),
    FOREIGN KEY (animal_id) REFERENCES animals(id),
    FOREIGN KEY (vet_id) REFERENCES vets(id)
);