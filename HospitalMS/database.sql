-- ============================================
-- Hospital Management System - Database Setup
-- ============================================

CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

-- Users Table (Admin & Receptionist)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'RECEPTIONIST') NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Doctors Table
CREATE TABLE IF NOT EXISTS doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    qualification VARCHAR(100),
    experience INT DEFAULT 0,
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Patients Table
CREATE TABLE IF NOT EXISTS patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender ENUM('MALE', 'FEMALE', 'OTHER'),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    blood_group VARCHAR(5),
    medical_history TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Appointments Table
CREATE TABLE IF NOT EXISTS appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('SCHEDULED','COMPLETED','CANCELLED') DEFAULT 'SCHEDULED',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE
);

-- ============================================
-- Default Users (passwords are plain for demo)
-- In production, use BCrypt hashed passwords
-- ============================================
INSERT INTO users (username, password, role, full_name, email) VALUES
('admin', 'admin123', 'ADMIN', 'System Administrator', 'admin@hospital.com'),
('receptionist', 'recep123', 'RECEPTIONIST', 'Jane Receptionist', 'reception@hospital.com');

-- Sample Doctors
INSERT INTO doctors (name, specialization, phone, email, qualification, experience) VALUES
('Dr. Rajesh Kumar', 'Cardiology', '9876543210', 'rajesh@hospital.com', 'MBBS, MD', 12),
('Dr. Priya Sharma', 'Orthopedics', '9876543211', 'priya@hospital.com', 'MBBS, MS', 8),
('Dr. Anita Verma', 'Neurology', '9876543212', 'anita@hospital.com', 'MBBS, DM', 15),
('Dr. Suresh Patel', 'Pediatrics', '9876543213', 'suresh@hospital.com', 'MBBS, MD', 6),
('Dr. Meera Nair', 'Dermatology', '9876543214', 'meera@hospital.com', 'MBBS, DVD', 9);

-- Sample Patients
INSERT INTO patients (name, age, gender, phone, email, address, blood_group) VALUES
('Amit Bose', 45, 'MALE', '8765432100', 'amit@email.com', '12 Park Street, Kolkata', 'O+'),
('Sunita Roy', 32, 'FEMALE', '8765432101', 'sunita@email.com', '34 Lake Rd, Kolkata', 'A+'),
('Rajan Das', 60, 'MALE', '8765432102', 'rajan@email.com', '56 Salt Lake, Kolkata', 'B+'),
('Kavitha Menon', 28, 'FEMALE', '8765432103', 'kavitha@email.com', '78 Gariahat, Kolkata', 'AB-');
