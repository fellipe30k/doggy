require "application_system_test_case"

class AnimalsTest < ApplicationSystemTestCase
  setup do
    @animal = animals(:one)
  end

  test "visiting the index" do
    visit animals_url
    assert_selector "h1", text: "Animals"
  end

  test "should create animal" do
    visit animals_url
    click_on "New animal"

    fill_in "Birth date", with: @animal.birth_date
    fill_in "Breed", with: @animal.breed
    fill_in "Color", with: @animal.color
    fill_in "Company", with: @animal.company_id
    fill_in "Microchip", with: @animal.microchip
    fill_in "Name", with: @animal.name
    fill_in "Owner email", with: @animal.owner_email
    fill_in "Owner name", with: @animal.owner_name
    fill_in "Owner phone", with: @animal.owner_phone
    fill_in "Species", with: @animal.species
    fill_in "User", with: @animal.user_id
    fill_in "Weight", with: @animal.weight
    click_on "Create Animal"

    assert_text "Animal was successfully created"
    click_on "Back"
  end

  test "should update Animal" do
    visit animal_url(@animal)
    click_on "Edit this animal", match: :first

    fill_in "Birth date", with: @animal.birth_date
    fill_in "Breed", with: @animal.breed
    fill_in "Color", with: @animal.color
    fill_in "Company", with: @animal.company_id
    fill_in "Microchip", with: @animal.microchip
    fill_in "Name", with: @animal.name
    fill_in "Owner email", with: @animal.owner_email
    fill_in "Owner name", with: @animal.owner_name
    fill_in "Owner phone", with: @animal.owner_phone
    fill_in "Species", with: @animal.species
    fill_in "User", with: @animal.user_id
    fill_in "Weight", with: @animal.weight
    click_on "Update Animal"

    assert_text "Animal was successfully updated"
    click_on "Back"
  end

  test "should destroy Animal" do
    visit animal_url(@animal)
    accept_confirm { click_on "Destroy this animal", match: :first }

    assert_text "Animal was successfully destroyed"
  end
end
