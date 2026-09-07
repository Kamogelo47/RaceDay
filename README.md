# RaceDay – Event Management System

## System Description

RaceDay is a road running, walking and cycling event management system designed to support the planning and management of sporting events. The system allows organisers to manage events, event categories, participant enrolments, event course details and results.

Part 1 of the project focuses on the system planning, database design and API endpoint planning. The project includes an Entity Relationship Diagram (ERD), an API Endpoint Plan and a SQL Server database implementation.

## User Roles

### Organiser

Organisers manage the events and event-related information within RaceDay. Their responsibilities include creating and updating events, managing event categories, viewing participant enrolments, managing course details and managing race results.

### Participant

Participants use RaceDay to view available events, select event categories, enrol in events and view their enrolment and result information.

## Part 1 Documentation

The `/docs` folder contains the main Part 1 planning and database documentation:

- **ERD Diagram** – Entity Relationship Diagram showing the database entities, attributes and relationships.
- **API Endpoint Plan** – Planned REST API endpoints supporting the Organiser and Participant roles.
- **SQL Script** – SQL Server database creation and sample data script for the RaceDay database.

## Database

The RaceDay database is implemented using Microsoft SQL Server and was tested using SQL Server Management Studio (SSMS).

The database contains the following main entities:

- Users
- Organisers
- Events
- EventCategories
- Enrolments
- Results
- EventCourseDetails

The SQL script includes primary keys, foreign keys, NOT NULL constraints, UNIQUE constraints, DEFAULT values, validation constraints and realistic sample data.

## API Endpoint Planning

The API Endpoint Plan defines the planned endpoints for:

- Authentication
- User profiles
- Events
- Event categories
- Enrolments
- Results
- Event course details

The endpoint plan was aligned with the entities and attributes represented in the ERD and SQL database.

## GitHub Actions / CI Validation

GitHub Actions is used to automatically validate the required Part 1 documentation structure.

The workflow checks that:

- The `docs` folder exists.
- The ERD image exists.
- The API Endpoint Plan exists.
- The SQL script exists.

A successful workflow run confirms that the required Part 1 documentation structure is present in the repository.

### Successful CI Build

![Successful GitHub Actions Build](docs/github-actions-success.png)

## Project Structure

```text
RaceDay
│
├── .github
│   └── workflows
│       └── validate-raceday.yml
│
├── docs
│   ├── ERD Diagram.png
│   ├── RaceDay_API_Endpoint_Plan_Section_B_Corrected.docx
│   ├── RaceDay_Part1_Section_C_SQL_Final.sql
│   └── github-actions-success.png
│
└── README.md

## Part 1 Video

An unlisted YouTube video demonstrating the Part 1 planning documents, ERD decisions, API endpoint planning and live SQL execution in SSMS will be provided here:

**YouTube Video:** ## Part 1 Video

An unlisted YouTube video demonstrating the Part 1 planning documents, ERD decisions, API endpoint planning and live SQL execution in SSMS will be provided here:

**YouTube Video:** https://youtu.be/Ltz-TJ72mwk
