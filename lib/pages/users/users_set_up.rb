require './lib/pages/users/navigation'

module Users
  # page object for Users page
  class UsersSetUp
    include Capybara::DSL

    def initialize(users)
      @email ||= users[:email]
      @role ||= users[:role]
    end

    def landing_page
      "#{ENV['Base_URL']}/think_feel_do_dashboard/users"
    end

    def create_researcher
      create_user { check_researcher }
    end

    def create_clinician
      create_user { check_clinician }
    end

    def create_content_author
      create_user { check_content_author }
    end

    def create_super_user
      create_user { check 'user_is_admin' }
    end

    def created_successfully?
      has_css?('.alert', text: 'User was successfully created.') &&
        has_text?("Super User: No\nEmail: #{@email}" \
                  "\nRoles: #{@role}")
    end

    def open
      click_on @email
      find('p', text: "Email: #{@email}")
    end

    def edit
      click_on 'Edit'
    end

    def add_clinician_role
      check_clinician
      click_on 'Update'
    end

    def add_content_author_role
      check_content_author
      click_on 'Update'
    end

    def has_clinician_and_researcher_role?
      has_css?('.alert', text: 'User was successfully updated.') &&
        has_text?('Roles: Clinician and Researcher') ||
        has_text?('Roles: Researcher and Clinician')
    end

    def has_clinician_and_content_author_role?
      has_css?('.alert', text: 'User was successfully updated.') &&
        has_text?('Roles: Content Author and Clinician') ||
        has_text?('Roles: Clinician and Content Author')
    end

    def super_user_with_clinician_role?
      has_css?('.alert', text: 'User was successfully updated.') &&
        has_text?("Super User: Yes\nEmail: #{@email}\nRoles: Clinician")
    end

    def destroy
      user_navigation.confirm_with_js
      click_on 'Destroy'
    end

    def destroyed_successfully?
      has_css?('.alert', text: 'User was successfully destroyed.') &&
        has_no_text?(@email)
    end

    def has_successfully_created_super_user?
      has_css?('.alert', text: 'User was successfully created.') &&
        has_text?("Super User: Yes\nEmail: superuser@test.com")
    end

    private

    def user_navigation
      @user_navigation ||= Users::Navigation.new
    end

    def create_user
      click_on 'New'
      fill_in 'user_email', with: @email
      yield
      click_on 'Create'
    end

    def check_researcher
      check 'user_user_roles_researcher'
    end

    def check_clinician
      check 'user_user_roles_clinician'
    end

    def check_content_author
      check 'user_user_roles_content_author'
    end
  end
end
