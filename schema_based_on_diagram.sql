CREATE database clinic;

-- Create patients table.
CREATE TABLE patients
(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    PRIMARY KEY (id)
);

-- Create medical_histories table.
CREATE TABLE medical_histories
(
    id INT GENERATED ALWAYS AS IDENTITY,
    admited_at timestamp,
    patient_id INT,
    status VARCHAR(100),
    CONSTRAINT fk_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(id),
    PRIMARY KEY (id)
);