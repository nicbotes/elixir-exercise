# Backend code exercise

Hi there!

If you're reading this, it means you're now at the coding exercise step of the engineering hiring process. We're really happy that you made it here and super appreciative of your time!

In this exercise you're asked to implement some features in an existing Phoenix application and find and fix a bug.

> 💡 The Phoenix application is an API

If you have any questions, don't hesitate to reach out directly to paulo@remote.com.

## Expectations

* It should be production-ready code - the code will show us how you ship things to production and be a mirror of your craft.
* Take whatever time you need - we won't look at start/end dates, you have a life besides this and we respect that!

## About the challenge

You will be working on an existing [Phoenix](https://www.phoenixframework.org/) application that needs some functionality added.

This exercise is requires you to:

1. 🔧 Fix existing bugs in the application
2. 📑 Create an employee resource and implement default CRUD operations
3. 🧮 Implement an endpoint to provide salary metrics about employees

### 🔧 1.Fix existing bugs in the application

Unfortunately the application is not behaving as expected and it can use some fixing. Find the issues and correct them.

> 💡 Tests will help you finding what is broken

### 📑 2.Create an employee resource and implement default CRUD operations

The application already has two resources: `country` and `currency`. You will have to create an `employee` resource and implement default [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) operations.

There are a few requirements for the info captured by the `employee` resource:

* It should have a fullname to be generated by reading and combining data found in `.\priv\data\first_names.txt` and `.\priv\data\last_names.txt`
* It should have a job title to be generated from a subset of values found in `.\priv\data\job_titles.txt` - please use a subset of 100 job titles from the provided list
* It should have a country
* It should have a salary
* It should have a currency in which the salary is paid

After creating the resource please add the logic to seed 10.000 employees into the database. Seed data lives on the `.\repo\seeds.exs` file.

### 🧮 3.Implement an endpoint to provide salary metrics about employees

Create a new endpoint(s) to provide data about salaries:

* Minimum, Maximum, and Average salary in a given country
* Average salary per job title

## How to run the existing application

### Using Elixir natively

If you wish to run the application natively you will need the following:

* Phoenix >= 1.5.9
* Elixir >= 1.7
* Postgres >= 11.9

Check out the `.tool-versions` file for a concrete version combination we ran the application with. Using [asdf](https://github.com/asdf-vm/asdf) you could install their plugins and them via `asdf install`.

### If you use Visual Studio Code with the Remote Containers extension

There is a `.devcontainer` folder that should allow you to open the project and develop without the need to have Elixir, Phoenix or Postgres installed in your system.

> 💡 Visual Studio Code [Remote - Containers extension page](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Starting the application

No matter which method you chose to run your application the commands to start the application are similar.

### To start your Phoenix server

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.setup`
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

> 💡 An `env` directory is provided along with values for environment variables for running the application with dev and test settings. Feel free to use whatever method you prefer to set environment variables.

## Useful Resources

* [Phoenix Official Website](https://www.phoenixframework.org/)
* [Phoenix Guides](https://hexdocs.pm/phoenix/overview.html)
* [Phoenix Docs](https://hexdocs.pm/phoenix)
* [Elixir Website](https://elixir-lang.org/)
* [Elixir Guides](https://elixir-lang.org/getting-started/introduction.html)
* [Elixir Docs](https://elixir-lang.org/docs.html)
