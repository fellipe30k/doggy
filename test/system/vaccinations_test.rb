require "application_system_test_case"

class VaccinationsTest < ApplicationSystemTestCase
  setup do
    @vaccination = vaccinations(:one)
  end

  test "visiting the index" do
    visit vaccinations_url
    assert_selector "h1", text: "Vaccinations"
  end

  test "should create vaccination" do
    visit vaccinations_url
    click_on "New vaccination"

    fill_in "Animal", with: @vaccination.animal_id
    fill_in "Application date", with: @vaccination.application_date
    fill_in "Batch number", with: @vaccination.batch_number
    fill_in "Company", with: @vaccination.company_id
    fill_in "Next dose date", with: @vaccination.next_dose_date
    fill_in "Observations", with: @vaccination.observations
    fill_in "User", with: @vaccination.user_id
    fill_in "Vaccine brand", with: @vaccination.vaccine_brand
    fill_in "Vaccine name", with: @vaccination.vaccine_name
    fill_in "Veterinarian name", with: @vaccination.veterinarian_name
    click_on "Create Vaccination"

    assert_text "Vaccination was successfully created"
    click_on "Back"
  end

  test "should update Vaccination" do
    visit vaccination_url(@vaccination)
    click_on "Edit this vaccination", match: :first

    fill_in "Animal", with: @vaccination.animal_id
    fill_in "Application date", with: @vaccination.application_date
    fill_in "Batch number", with: @vaccination.batch_number
    fill_in "Company", with: @vaccination.company_id
    fill_in "Next dose date", with: @vaccination.next_dose_date
    fill_in "Observations", with: @vaccination.observations
    fill_in "User", with: @vaccination.user_id
    fill_in "Vaccine brand", with: @vaccination.vaccine_brand
    fill_in "Vaccine name", with: @vaccination.vaccine_name
    fill_in "Veterinarian name", with: @vaccination.veterinarian_name
    click_on "Update Vaccination"

    assert_text "Vaccination was successfully updated"
    click_on "Back"
  end

  test "should destroy Vaccination" do
    visit vaccination_url(@vaccination)
    accept_confirm { click_on "Destroy this vaccination", match: :first }

    assert_text "Vaccination was successfully destroyed"
  end
end
