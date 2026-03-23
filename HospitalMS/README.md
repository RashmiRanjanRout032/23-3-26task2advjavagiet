# 🏥 Hospital Management System

A Spring Boot + JPA + Lombok + JSP web application with **role-based access control** for Admin and Receptionist.

---

## 🧱 Tech Stack

| Layer        | Technology                     |
|--------------|-------------------------------|
| Backend      | Spring Boot 3.2, Spring MVC   |
| Security     | Spring Security (BCrypt)      |
| Persistence  | Spring Data JPA + Hibernate   |
| Database     | MySQL 8                       |
| View Layer   | JSP + JSTL                    |
| Boilerplate  | Lombok                        |
| Build Tool   | Maven                         |

---

## 👥 Roles & Permissions

| Feature              | Admin | Receptionist |
|----------------------|:-----:|:------------:|
| Manage Doctors       | ✅    | 👁 View only |
| Manage Patients      | ✅    | 👁 View only |
| Schedule Appointments| ❌    | ✅           |
| Edit Appointments    | ❌    | ✅           |
| Cancel Appointments  | ❌    | ✅           |
| Admin Dashboard      | ✅    | ❌           |
| Receptionist Dashboard| ❌   | ✅           |

---

## ⚙️ Prerequisites

- Java 17+
- Maven 3.8+
- MySQL 8.x running locally

---

## 🚀 Setup & Run

### 1. Create MySQL Database

```sql
CREATE DATABASE hospital_db;
```

### 2. Configure Database Credentials

Edit `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/hospital_db?createDatabaseIfNotExist=true&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=your_password
```

### 3. Build & Run

```bash
mvn clean spring-boot:run
```

### 4. Open in Browser

```
http://localhost:8080
```

---

## 🔐 Default Login Credentials

| Role          | Username       | Password   |
|---------------|----------------|------------|
| Admin         | `admin`        | `admin123` |
| Receptionist  | `receptionist` | `recep123` |

> Credentials are **auto-created** on first startup via `DataInitializer`.

---

## 📁 Project Structure

```
HospitalMS/
├── src/main/java/com/hospital/
│   ├── HospitalApplication.java         ← Entry point
│   ├── config/
│   │   └── SecurityConfig.java          ← Spring Security rules
│   ├── model/
│   │   ├── User.java
│   │   ├── Doctor.java
│   │   ├── Patient.java
│   │   └── Appointment.java
│   ├── repository/
│   │   ├── UserRepository.java
│   │   ├── DoctorRepository.java
│   │   ├── PatientRepository.java
│   │   └── AppointmentRepository.java
│   ├── service/
│   │   ├── CustomUserDetailsService.java
│   │   ├── DoctorService.java
│   │   ├── PatientService.java
│   │   ├── AppointmentService.java
│   │   └── DataInitializer.java
│   └── controller/
│       ├── AuthController.java
│       ├── AdminController.java
│       └── ReceptionistController.java
├── src/main/webapp/WEB-INF/
│   ├── web.xml
│   └── views/
│       ├── login.jsp
│       ├── layout/
│       │   ├── header.jsp
│       │   └── footer.jsp
│       ├── admin/
│       │   ├── dashboard.jsp
│       │   ├── doctors.jsp
│       │   ├── doctorForm.jsp
│       │   ├── doctorView.jsp
│       │   ├── patients.jsp
│       │   ├── patientForm.jsp
│       │   └── patientView.jsp
│       └── receptionist/
│           ├── dashboard.jsp
│           ├── appointments.jsp
│           ├── appointmentForm.jsp
│           ├── doctors.jsp
│           └── patients.jsp
└── src/main/resources/
    └── application.properties
```

---

## 🌐 URL Routes

### Admin
| Method | URL                          | Action              |
|--------|------------------------------|---------------------|
| GET    | `/admin/dashboard`           | Dashboard           |
| GET    | `/admin/doctors`             | List doctors        |
| GET    | `/admin/doctors/add`         | Add doctor form     |
| POST   | `/admin/doctors/save`        | Save doctor         |
| GET    | `/admin/doctors/edit/{id}`   | Edit doctor form    |
| GET    | `/admin/doctors/delete/{id}` | Delete doctor       |
| GET    | `/admin/patients`            | List patients       |
| GET    | `/admin/patients/add`        | Add patient form    |
| POST   | `/admin/patients/save`       | Save patient        |
| GET    | `/admin/patients/edit/{id}`  | Edit patient form   |
| GET    | `/admin/patients/delete/{id}`| Delete patient      |

### Receptionist
| Method | URL                                          | Action               |
|--------|----------------------------------------------|----------------------|
| GET    | `/receptionist/dashboard`                    | Dashboard            |
| GET    | `/receptionist/appointments`                 | List appointments    |
| GET    | `/receptionist/appointments/add`             | New appointment form |
| POST   | `/receptionist/appointments/save`            | Save appointment     |
| GET    | `/receptionist/appointments/edit/{id}`       | Edit appointment     |
| GET    | `/receptionist/appointments/delete/{id}`     | Delete appointment   |
| GET    | `/receptionist/appointments/status/{id}/{s}` | Update status        |
| GET    | `/receptionist/doctors`                      | View doctors         |
| GET    | `/receptionist/patients`                     | View patients        |

---

## 📸 Features

- 🔐 Secure login with BCrypt password hashing
- 🏠 Role-based redirect after login (Admin → Admin dashboard, Receptionist → Receptionist dashboard)
- 👨‍⚕️ Full CRUD for Doctors (Admin only)
- 🧑‍🤝‍🧑 Full CRUD for Patients (Admin only)
- 📅 Appointment scheduling with status management (Receptionist)
- 🔍 Search functionality for doctors and patients
- 📊 Dashboard with live statistics
- 🎨 Dark-themed responsive UI built with CSS
