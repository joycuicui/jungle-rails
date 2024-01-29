require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    let(:user_attributes) do
      {
        first_name: "Jane",
        last_name: "Doe", 
        email: "jane@email.com",
        password: "123456",
        password_confirmation: "123456"
      }
    end

    let(:user) { User.new(user_attributes) }

    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "requires a first name" do
      user.first_name = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it "requires a last name" do
      user.last_name = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it "requires an email" do
      user.email = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    context "password validations" do
    
      it "requires a password" do
        user.password = nil
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      it "is not valid when password and password_confirmation do not match" do
        user.password_confirmation = "654321"
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "is not valid when password length is less than 6" do
        user.password = "123"
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
    
    end

    context "email should be unique" do

      it "is not valid when the email already exist" do
        user.save()
        another_user = User.new(
          first_name: "John",
          last_name: "Doe", 
          email: "jane@email.com",
          password: "123456",
          password_confirmation: "123456"
        )
        expect(another_user).to_not be_valid
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it "is not case sensitive" do
        user.save()
        another_user = User.new(
          first_name: "John",
          last_name: "Doe", 
          email: "JANE@EMAIL.COM",
          password: "123456",
          password_confirmation: "123456"
        )
        expect(another_user).to_not be_valid
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
    
    end

  end

  describe ".authenticate_with_credentials" do
    let(:user_attributes) do
      {
        first_name: "Dave",
        last_name: "David", 
        email: "dave@email.com",
        password: "password",
        password_confirmation: "password"
      }
    end

    it "returns user if authenticate with correct credentials" do
      user = User.create(user_attributes)
      authenticated_user = User.authenticate_with_credentials("dave@email.com", "password")
      expect(authenticated_user).to eq(user)
    end

    it "return nil if email is not found" do
      user = User.create(user_attributes)
      authenticated_user = User.authenticate_with_credentials("some@email.com", "password")
      expect(authenticated_user).to be_nil
    end

    it "returns nil if password is incorrect" do
      user = User.create(user_attributes)
      authenticated_user = User.authenticate_with_credentials("dave@email.com", "7password")
      expect(authenticated_user).to be_nil
    end

    it "ignores spaces before and/or after email" do
      user = User.create(user_attributes)
      authenticated_user = User.authenticate_with_credentials("  dave@email.com  ", "password")
      expect(authenticated_user).to eq(user)
    end

    it "is not case sensitive for email" do
      user = User.create(user_attributes)
      authenticated_user = User.authenticate_with_credentials("DAVE@email.com", "password")
      expect(authenticated_user).to eq(user)
    end

  end

end
