defmodule ExerciseWeb.SalaryControllerTest do
  use ExerciseWeb.ConnCase

  alias Exercise.Talent

  setup %{conn: conn} do
    employees = for _ <- 1..10, do: Exercise.TalentFixtures.employee_fixture()

    {:ok, conn: put_req_header(conn, "accept", "application/json"), employees: employees}
  end

  describe "index" do
    test "job_title search finds the correct stats", %{conn: conn, employees: employees} do
      search_term = "some job_title"
      conn = get(conn, Routes.salary_path(conn, :index, job_title: search_term))

      response = json_response(conn, 200)["data"]

      %{
        "search" => %{"term" => jt, "on" => "job_title"},
        "average" => avg,
      } = response
      {avg, _} = Integer.parse(avg)
      assert (avg) == 120
      assert jt == search_term
    end

    test "job_title search finds returns empty schema", %{conn: conn} do
      search_term = "not_a_real_job_title"
      conn = get(conn, Routes.salary_path(conn, :index, job_title: search_term))

      response = json_response(conn, 200)["data"]

      %{
        "search" => %{"term" => jt, "on" => "job_title"},
        "average" => avg,
      } = response
      assert avg == nil
      assert jt == search_term
    end

    test "country search finds the correct stats", %{conn: conn, employees: employees} do
      employee = hd(employees)
      search_term = Exercise.Countries.get_country!(employee.country_id).code
      conn = get(conn, Routes.salary_path(conn, :index, country: search_term))

      response = json_response(conn, 200)["data"]

      %{
        "search" => %{"term" => country_code, "on" => "country"},
        "average" => _, "maximum" => _, "minimum" => _
      } = response
      assert country_code == search_term
    end

    test "invalid search field is a 200", %{conn: conn} do
      search_term = "test"
      conn = get(conn, Routes.salary_path(conn, :index, wrong_field: search_term))

      assert json_response(conn, 200)["data"] == nil
    end
  end
end
