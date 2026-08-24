# CourseHub

CourseHub is a course management application built with Ruby on Rails. It allows teachers to create and manage courses
and class sessions, while students can browse, view details, enroll in and leave courses.

## Features

- User authentication
- Teacher and student roles (teacher account need to be made manually as a business decision)
- Course creation and management
- Public and invite-only courses
- Invite code enrollment
- Course archiving
- Student enrollment
- Class session creation, editing and deletion
- Upcoming and past class sessions
- Physical and remote class location categories
- UI styling using Tailwind CSS
- Stimulus interactions

## Tech Stack

- Ruby
- Ruby on Rails
- PostgreSQL
- ActiveRecord
- ERB
- Tailwind CSS
- Stimulus
- Importmap

## Development & CI
- Minitest
- RuboCop
- Brakeman
- Bundler Audit
- Importmap Audit
- GitHub Actions

## Running Locally

### Requirements

- Ruby
- PostgreSQL

### Setup

```bash
bundle install
ruby bin/rails db:create
ruby bin/rails db:migrate
ruby bin/rails server
```
The application will be available at http://localhost:3000

### Project

CourseHub was built as a practical Ruby on Rails project to gain hands-on experience with Rails, PostgreSQL,
ActiveRecord, authentication, authorization, CRUD operations and server-rendered views.