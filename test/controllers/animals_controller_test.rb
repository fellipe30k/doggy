require "test_helper"

class AnimalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @animal = animals(:one)
  end

  test "should get index" do
    get animals_url
    assert_response :success
  end

  test "should get new" do
    get new_animal_url
    assert_response :success
  end

  test "should create animal" do
    assert_difference("Animal.count") do
      post animals_url, params: { animal: { birth_date: @animal.birth_date, breed: @animal.breed, color: @animal.color, company_id: @animal.company_id, microchip: @animal.microchip, name: @animal.name, owner_email: @animal.owner_email, owner_name: @animal.owner_name, owner_phone: @animal.owner_phone, species: @animal.species, user_id: @animal.user_id, weight: @animal.weight } }
    end

    assert_redirected_to animal_url(Animal.last)
  end

  test "should show animal" do
    get animal_url(@animal)
    assert_response :success
  end

  test "should get edit" do
    get edit_animal_url(@animal)
    assert_response :success
  end

  test "should update animal" do
    patch animal_url(@animal), params: { animal: { birth_date: @animal.birth_date, breed: @animal.breed, color: @animal.color, company_id: @animal.company_id, microchip: @animal.microchip, name: @animal.name, owner_email: @animal.owner_email, owner_name: @animal.owner_name, owner_phone: @animal.owner_phone, species: @animal.species, user_id: @animal.user_id, weight: @animal.weight } }
    assert_redirected_to animal_url(@animal)
  end

  test "should destroy animal" do
    assert_difference("Animal.count", -1) do
      delete animal_url(@animal)
    end

    assert_redirected_to animals_url
  end
end
