# RaceDay – Event Management System

## System Description

RaceDay is a road running, walking and cycling event management system designed to support the planning and management of sporting events.

The system allows organisers to manage events, event categories, participant enrolments, event course details and race results.

Part 1 of the project focuses on system planning, database design and API endpoint planning. The project includes an Entity Relationship Diagram (ERD), an API Endpoint Plan and a SQL Server database implementation.

## User Roles

### Organiser

Organisers manage the events and event-related information within RaceDay.

Their responsibilities include:

- Creating and updating events
- Managing event categories
- Viewing participant enrolments
- Managing event course details
- Managing race results

### Participant

Participants use RaceDay to interact with available events and their own participation information.

Their responsibilities include:

- Viewing available events
- Selecting event categories
- Enrolling in events
- Viewing their enrolment information
- Viewing their results

## Part 1 Documentation

The `/docs` folder contains the main Part 1 planning and database documentation:

- **ERD Diagram** – Entity Relationship Diagram showing the database entities, attributes and relationships.
- **API Endpoint Plan** – Planned REST API endpoints supporting the Organiser and Participant roles.
- **SQL Script** – SQL Server database creation and sample data script for the RaceDay database.
- **GitHub Actions Screenshot** – Evidence of a successful automated repository validation build.

## Design Decisions

The RaceDay Part 1 design was based on the entities and relationships identified in the ERD.

### Database Design

The database uses the `Users` table to store common user information for both Organisers and Participants.

The `Organisers` table provides additional organisation-specific information for users who manage events.

The main event-management information is separated into:

- `Events`
- `EventCategories`
- `Enrolments`
- `Results`
- `EventCourseDetails`

This separation keeps event, participant, category, result and course information organised and supports the relationships represented in the ERD.

### Event Course and Weather Information

Weather information is stored as part of `EventCourseDetails` through the `WeatherInfo` attribute.

A separate Weather entity was not introduced because the ERD does not contain a separate Weather entity.

### API Design

The API Endpoint Plan follows REST-style resource naming and uses resource IDs where individual records need to be accessed.

The planned endpoints correspond to the main resources represented in the database design.

The API planning also distinguishes between Organiser and Participant responsibilities.

Organisers manage event-related information, while Participants manage their own enrolments and access their results.

### ERD and SQL Consistency

The SQL database implementation follows the entities and attributes represented in the ERD.

Where relationships could be implemented directly using existing foreign-key attributes, foreign keys were added to maintain referential integrity without introducing unsupported entities or attributes.

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

The SQL script includes:

- Primary keys
- Foreign keys
- NOT NULL constraints
- UNIQUE constraints
- DEFAULT values
- Validation constraints
- Realistic sample data

The SQL script can be found in:

`/docs/RaceDay_Part1_Section_C_SQL_Final.sql`

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

The complete API Endpoint Plan can be found in:

`/docs/RaceDay_API_Endpoint_Plan_Section_B_Corrected.docx`

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


### Then do this

1. Replace:
   ```text
   https://youtu.be/Ltz-TJ72mwk
