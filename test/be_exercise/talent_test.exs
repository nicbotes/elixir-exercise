defmodule Exercise.TalentTest do
  use Exercise.DataCase

  alias Exercise.Talent

  describe "employees" do
    alias Exercise.Talent.Employee

    import Exercise.TalentFixtures

    @invalid_attrs %{full_name: nil, job_title: nil, salary: nil}

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Talent.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Talent.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      valid_attrs = %{full_name: "some full_name", job_title: "some job_title", salary: "120.5"}

      assert {:ok, %Employee{} = employee} = Talent.create_employee(valid_attrs)
      assert employee.full_name == "some full_name"
      assert employee.job_title == "some job_title"
      assert employee.salary == Decimal.new("120.5")
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Talent.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      update_attrs = %{full_name: "some updated full_name", job_title: "some updated job_title", salary: "456.7"}

      assert {:ok, %Employee{} = employee} = Talent.update_employee(employee, update_attrs)
      assert employee.full_name == "some updated full_name"
      assert employee.job_title == "some updated job_title"
      assert employee.salary == Decimal.new("456.7")
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Talent.update_employee(employee, @invalid_attrs)
      assert employee == Talent.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Talent.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Talent.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Talent.change_employee(employee)
    end
  end
end
