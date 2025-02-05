# Backend code exercise

Hi there!

If you're reading this, it means you're now at the coding exercise step of the engineering hiring process. We're really happy that you made it here and super appreciative of your time!

In this exercise you're asked to implement some features in an existing Phoenix application and find and fix a bug.

> 💡 The Phoenix application is an API

If you have any questions, don't hesitate to reach out directly to code_exercise@remote.com.

## Expectations

* It should be production-ready code - the code will show us how you ship things to production and be a mirror of your craft.
  * Just to be extra clear: We don't actually expect you to deploy it somewhere or build a release. It's meant as a statement regarding the quality of the solution.
* Use your best judgement when modelling the data and relationships.
* Take whatever time you need - we won’t look at start/end dates, you have a life besides this and we respect that! Moreover, if there is something you had to leave incomplete or there is a better solution you would implement but couldn’t due to personal time constraints, please try to walk us through your thought process or any missing parts, using the “Implementation Details” section below.

## About the challenge

You will be working on an existing [Phoenix](https://www.phoenixframework.org/) application that needs some functionality added.

This exercise requires you to:

1. 🔧 Fix existing bugs in the application
2. 📑 Create an employee resource, implement default CRUD operations and seed the database.
3. 🧮 Implement an endpoint to provide salary metrics about employees

### 🔧 1.Fix existing bugs in the application

Unfortunately the application is not behaving as expected and it can use some fixing. Find the issues and correct them.

> 💡 Tests will help you find what is broken

### 📑 2.Create an employee resource, implement default CRUD operations and seed the database.

The application already has two resources: `country` and `currency`. You will have to create an `employee` resource and implement default [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) operations.

There are a few requirements for the info captured by the `employee` resource:

* It must have a full name
* It must have a job title
* It must have a country
* It must have a salary
* It must have a currency in which the salary is paid

After creating the resource please add the logic to seed 10 000 employees into the database. Seed data lives on the `./priv/repo/seeds.exs` file.

For the seeds, the following data fields have data that must be used for their generation:
* full name to be generated by reading and combining data found in `./priv/data/first_names.txt` and `./priv/data/last_names.txt`
* job title to be generated from a subset of values found in `./priv/data/job_titles.txt` - please use a subset of 100 job titles from the provided list

There is no defined logic to what first name should go with what last name, job title, country etc. Assign them as you see fit.

You do not need to add pagination for the index endpoint.

Assume that engineers need to seed their databases regularly, so the performance of the seed script matters. Feel free to update the existing code if you consider it necessary.

### 🧮 3.Implement an endpoint to provide salary metrics about employees

Create a new endpoint(s) to provide data about salaries:

* Given a country, the minimum, maximum, and average salary in that country.
* Given a job title, the average salary for all the employees with that job title.

### When you're done

- Complete the "Implementation Details" section at the bottom of this README.
- Open a Pull Request in this repo and send the link to code_exercise@remote.com.
- You can also send some feedback about this exercise. Was it too short/big? Boring? Let us know!

---

## How to run the existing application

To run the application you will need the following:

* Elixir 1.15.5
* Erlang 26.0.2
* Postgres >= 11.9

Check out the `.tool-versions` file for a concrete version combination we ran the application with. Using [asdf](https://github.com/asdf-vm/asdf) you can install their plugins and then run `asdf install`.

### Starting the application

No matter which method you chose to run your application the commands to start the application are similar.

### To start your Phoenix server

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.setup`
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000/api/currencies`](http://localhost:4000/api/currencies) from your browser, to see that everything works.

> 💡 An `env` directory is provided along with values for environment variables for running the application with dev and test settings. Feel free to use whatever method you prefer to set environment variables.

## Useful Resources

* [Phoenix Official Website](https://www.phoenixframework.org/)
* [Phoenix Guides](https://hexdocs.pm/phoenix/overview.html)
* [Phoenix Docs](https://hexdocs.pm/phoenix)
* [Elixir Website](https://elixir-lang.org/)
* [Elixir Guides](https://elixir-lang.org/getting-started/introduction.html)
* [Elixir Docs](https://elixir-lang.org/docs.html)

## Implementation details
### Not complete
All Tasks are complete, but improvements lie in:
- Tests are mainly on the happy path only. I didn't find coverage reporting and I was tripping myself up on the edge cases and ExUnit.
- Inconsistent formatting and patterns. For example, sometimes I used "verified routes" rather than a route path while I was learning. I am not going to revisit this.

### Domain modelling
Following Domain-driven design principles in the context of Remote.com's operations.

Contexts setup.
- Countries
  - Countries
  - Currencies
- [*New] Talent
  - Employee

To explain the thinking future, the separation of concerns can be more easily seen with some illustrative use cases:
`Countries`
- Responsibilities: Managing data related to countries, currencies, tax rates, and labour laws.
- Justification: This context is essential for any global system dealing with international operations. Managing country-specific data separately makes the system flexible and extensible, allowing easy updates to laws, currencies, and other locale-specific data without impacting other parts of the system.
`Talent`
- Responsibilities: Handling everything related to the individuals employed or contracted by the organisation, including salaries, benefits, and potentially tools for calculating taxes (income tax computations).
- Justification: This is the human resource aspect of the system. Keeping it separate from organizational and country-specific contexts helps focus on employee-specific operations and data management.
`Organizations`
- Responsibilities: Managing data about the company itself, such as its locations, industry classifications, types of employment contracts, asset management, organizational tax calculations, job vacancies etc.
- Justification: This context encapsulates corporate-level data and operations, which are distinct from the individual employee or country-specific regulations. It would handle the broader aspects of business operations and structural data.

### Seeds
The `seeds.exs` script was refactored to separate out concerns of
- obtaining fake data with a FakeData module (inspired by Faker)
- interacting with the database to populate tables
- running the script and giving feedback to developers (since this is framed as a repetitive activity)

### Salary statistics
- the stats are modelled as a resource, that is searched against by either a country or a job_title.
- There is a single endpoint to expose this, and interacting with the Talent context, since these stats are based on employee salaries (as opposed to salary ranges of job specs which would be implemented in a differnt context).


## Notes on thinking and decision-making during the activity

### Feedback
Hi there, 

Thanks for taking the time to review this take home assignment. I'm new to Elixir and Phoenix but have read the docs and have tried to apply best practice. In the hopes of getting richer feedback while learning, I've explained my thinking below. Please share on the PR directly if you are willing. I'd really appreciate it.

The assigment was a good forcing function to learn Elixir and Phoenix concepts. It gives me a better understanding of the tech stack I'd be joining, rather than only assessing technical ability in an abstract way. The tasks cover the basics of software dev activities and has been a good way for me to get a lay of the land of the framework.

### Task 1 Notes
My thinking here was to follow elixir practices:
- Documentation of the convert function. I followed similar copy used in `h File.read`
- Simple approach using a case statement and pattern matching to return the tuple and get the test passing.
- I decided to rather handle a nil (or other non-numeric types) `amount` input by returning an error tuple. Elixir docs describe "let it crash" being commonplace. However, in this case, I thought an amount field could be undefined so I have handled the case and updated the test suite accordingly.
- I added a few more data points for the testing. This may be 

### Task 2 Notes
- Assumption: it's common for people to be paid in a different currency to that of their country of residence, due to either employer or employee preference. Sounds obvious now, but I had a slow moment. This domain context wasn't obvious to me at first when the currency on the employee (I thought it would always be the same as the specified country).
- I used the Json generator for the Talent context but then noticed the current codebase followed a different pattern, so I adapted the solution to follow the existing style.
- Seeding: 
  - I preferred to separate out the concerns.
  - There is some flexibility in the utilities for changing the volumes of data
  - for performance, I was attempting to limit duplicating data and calling the db. 
  - data integrity checks are done in memory for enforcing country_id and currency_id to be valid and set.
  - batched and bulk inserts write the data, meaning that app level validation checks are skipped.
  - currencies and countries are bounded. so the selects are ok

### Task 3 Notes
- Followed the aggregation functions in the ecto docs.
- Used the Talent context to expose this rather than the Employee directly.
- I chose to use a single get endpoint with query parameters
