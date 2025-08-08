require "test_helper"

class VaccinationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vaccination = vaccinations(:one)
  end

  test "should get index" do
    get vaccinations_url
    assert_response :success
  end

  test "should get new" do
    get new_vaccination_url
    assert_response :success
  end

  test "should create vaccination" do
    assert_difference("Vaccination.count") do
      post vaccinations_url, params: { vaccination: { animal_id: @vaccination.animal_id, application_date: @vaccination.application_date, batch_number: @vaccination.batch_number, company_id: @vaccination.company_id, next_dose_date: @vaccination.next_dose_date, observations: @vaccination.observations, user_id: @vaccination.user_id, vaccine_brand: @vaccination.vaccine_brand, vaccine_name: @vaccination.vaccine_name, veterinarian_name: @vaccination.veterinarian_name } }
    end

    assert_redirected_to vaccination_url(Vaccination.last)
  end

  test "should show vaccination" do
    get vaccination_url(@vaccination)
    assert_response :success
  end

  test "should get edit" do
    get edit_vaccination_url(@vaccination)
    assert_response :success
  end

  test "should update vaccination" do
    patch vaccination_url(@vaccination), params: { vaccination: { animal_id: @vaccination.animal_id, application_date: @vaccination.application_date, batch_number: @vaccination.batch_number, company_id: @vaccination.company_id, next_dose_date: @vaccination.next_dose_date, observations: @vaccination.observations, user_id: @vaccination.user_id, vaccine_brand: @vaccination.vaccine_brand, vaccine_name: @vaccination.vaccine_name, veterinarian_name: @vaccination.veterinarian_name } }
    assert_redirected_to vaccination_url(@vaccination)
  end

  test "should destroy vaccination" do
    assert_difference("Vaccination.count", -1) do
      delete vaccination_url(@vaccination)
    end

    assert_redirected_to vaccinations_url
  end
end
