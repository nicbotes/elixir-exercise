defmodule Exercise.Talent do
  @moduledoc """
  The Talent context.
  """

  import Ecto.Query, warn: false
  alias Exercise.Repo

  alias Exercise.Talent.Employee

  @doc """
  Returns the list of employees.

  ## Examples

      iex> list_employees([:country, :payroll_currency])
      [%Employee{}, ...]

  """
  def list_employees(preload \\ []) do
    Employee
    |> Repo.all()
    |> Repo.preload(preload)
  end

  @doc """
  Gets a single employee.

  Raises `Ecto.NoResultsError` if the Employee does not exist.

  ## Examples

      iex> get_employee!(123, [:country, :payroll_currency])
      %Employee{}

      iex> get_employee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_employee!(id, preload \\ []) do
    Employee
    |> Repo.get!(id)
    |> Repo.preload(preload)
  end

  @doc """
  Creates a employee.

  ## Examples

      iex> create_employee(%{field: value})
      {:ok, %Employee{}}

      iex> create_employee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_employee(attrs \\ %{}) do
    %Employee{}
    |> Employee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a employee.

  ## Examples

      iex> update_employee(employee, %{field: new_value})
      {:ok, %Employee{}}

      iex> update_employee(employee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_employee(%Employee{} = employee, attrs) do
    employee
    |> Employee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a employee.

  ## Examples

      iex> delete_employee(employee)
      {:ok, %Employee{}}

      iex> delete_employee(employee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_employee(%Employee{} = employee) do
    Repo.delete(employee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking employee changes.

  ## Examples

      iex> change_employee(employee)
      %Ecto.Changeset{data: %Employee{}}

  """
  def change_employee(%Employee{} = employee, attrs \\ %{}) do
    Employee.changeset(employee, attrs)
  end

  def employee_salary_stats_by_job_title(field) do
    query = from(e in Employee, where: e.job_title == ^field, select: avg(e.salary))

    stats = %{
        average: Repo.one(query),
    }

    {:ok, %{"#{field}" => stats}}
  rescue
    exception in Ecto.QueryError ->
      {:error, exception.message}
  end

  def employee_salary_stats_by_country(country_code) do
    query = from(e in Employee,
                join: c in assoc(e, :country),
                where: c.code == ^country_code)

    stats = %{
      maximum: Repo.aggregate(query, :max, :salary),
      minimum: Repo.aggregate(query, :min, :salary),
      average: Repo.aggregate(query, :avg, :salary),
    }

    {:ok, %{"#{country_code}" => stats}}
  rescue
    exception in Ecto.QueryError ->
      {:error, exception.message}
  end
end
