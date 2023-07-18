UEX Contacts
This project is a demonstration of contact book.

Setup Guide

Follow the steps below to set up the environment for this project using Docker Compose.

Prerequisites

Before proceeding with the setup, make sure you have the following installed:

Docker

Docker Compose or just clone the project run bundle install and then rails db:create db:migrate and rails server

Step 1: Clone the Repository

Clone the repository to your local machine using the following command:

git clone https://github.com/AliniCanedo/uex-api.git

Step 2: Configure the Environment Variables

Create a .env file in the project root directory and provide the necessary environment variables. You can use the .env.example file as a template.

Step 3: Build the Docker Images

Build the Docker images for the project using the following command:

docker-compose build

Step 4: Install Dependencies

Step 5: Start the Application

Start the application by running the following command:

docker-compose up || docker-compose up -d app

Step 6: Access the Application

Access the application by navigating to http://localhost:3000 in your web browser.

Step 7: Postman's Collection

Here is the Postman collection containing the example API calls

Run in Postman

Step 8: Running Tests

bundle exec rspec
