defmodule ExerciseWeb.EmployeeControllerTest do
  use ExerciseWeb.ConnCase
  alias Exercise.Talent.Employee

  @create_attrs %{
    full_name: "some full_name",
    job_title: "some job_title",
    salary: "120.5"
  }
  @update_attrs %{
    full_name: "some updated full_name",
    job_title: "some updated job_title",
    salary: "456.7"
  }
  @invalid_attrs %{full_name: nil, job_title: nil, salary: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup do
      employees = for _ <- 1..3, do: Exercise.TalentFixtures.employee_fixture()
      {:ok, employees: employees}
    end

    test "lists all employees", %{conn: conn, employees: employees} do
      employee_ids = Enum.map(employees, &(&1.id))
      conn = get(conn, ~p"/api/employees")
      response = json_response(conn, 200)["data"]

      assert response |> length() == length(employee_ids)

      Enum.each(response, fn res ->
        assert %{
              "country" => %{"code" => _, "id" => _, "name" => _},
              "full_name" => "some full_name",
              "id" => id,
              "job_title" => "some job_title",
              "payroll_currency" => %{"code" => _, "id" => _, "name" => _, "symbol" => _},
              "salary" => "120.5"
            } = res
        assert id in employee_ids
      end)
    end
  end

  describe "show" do
    test "shows the employee", %{conn: conn} do
      employee = Exercise.TalentFixtures.employee_fixture()
      %{id: employee_id} = employee

      conn = get(conn, ~p"/api/employees/#{employee_id}")
      response = json_response(conn, 200)["data"]

      assert %{
        "country" => %{"code" => _, "id" => _, "name" => _},
        "full_name" => "some full_name",
        "id" => id,
        "job_title" => "some job_title",
        "payroll_currency" => %{"code" => _, "id" => _, "name" => _, "symbol" => _},
        "salary" => "120.5"
      } = response
      assert id == employee_id
    end

    test "handle error gracefully when the employee is not found", %{conn: conn} do
      assert_error_sent 404, fn ->
        get(conn, ~p"/api/employees/#{-1}")
      end
    end
  end

  describe "create employee" do
    test "renders employee when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/employees", employee: create_attrs_with_associations())
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/employees/#{id}")
      assert %{"id" => ^id} = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/employees", employee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update employee" do
    setup do
      employee = Exercise.TalentFixtures.employee_fixture()
      {:ok, employee: employee}
    end

    test "renders employee when data is valid", %{conn: conn, employee: %Employee{id: id} = employee} do
      conn = put(conn, ~p"/api/employees/#{employee}", employee: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/employees/#{id}")

      assert %{
               "id" => ^id,
               "full_name" => "some updated full_name",
               "job_title" => "some updated job_title",
               "salary" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, employee: employee} do
      conn = put(conn, ~p"/api/employees/#{employee}", employee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete employee" do
    setup do
      employee = Exercise.TalentFixtures.employee_fixture()
      {:ok, employee: employee}
    end

    test "deletes chosen employee", %{conn: conn, employee: employee} do
      conn = delete(conn, ~p"/api/employees/#{employee}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/employees/#{employee}")
      end
    end
  end

  defp create_attrs_with_associations do
    country = Exercise.CountryFixtures.country_fixture()
    currency = Exercise.CurrencyFixtures.currency_fixture()

    Map.merge(@create_attrs, %{
      country_id: country.id,
      payroll_currency_id: currency.id
    })
  end
end
