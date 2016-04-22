require './lib/pages/users/navigation'

class Users
  # page object for Participants
  class ResearcherParticipants
    include RSpec::Matchers
    include Capybara::DSL

    def initialize(participants)
      @study_id ||= participants[:study_id]
      @updated_study_id ||= participants[:updated_study_id]
      @email ||= participants[:email]
      @phone_number ||=
        participants.fetch(:phone_number, ENV['Participant_Phone_Number'])
      @contact_preference ||= participants[:contact_preference]
      @coach ||= participants.fetch(:coach, ENV['Clinician_Email'])
      @display_name ||= participants[:display_name]
      @start_date ||= participants[:start_date]
      @end_date ||= participants[:end_date]
    end

    def landing_page
      "#{ENV['Base_URL']}/think_feel_do_dashboard/participants"
    end

    def visible?
      has_css?('h1', text: 'Participants')
    end

    def create
      click_on 'New'
      fill_in_study_id_email_phone_number
      select @contact_preference, from: 'participant_contact_preference'
      click_on 'Create'
    end

    def created_successfully?
      has_css?('.alert', text: 'Participant was successfully created.') &&
        has_participant?
    end

    def open
      user_navigation.scroll_to_bottom
      click_on @study_id
    end

    def update
      click_on 'Edit'
      fill_in_study_id_email_phone_number(@updated_study_id)
      click_on 'Update'
    end

    def updated_successfully?
      has_css?('.alert', text: 'Participant was successfully updated.') &&
        has_participant?(@updated_study_id)
    end

    def has_no_coach_assigned?
      has_text? 'Current Coach/Moderator: None'
    end

    def unable_to_take_coach_assignment?
      has_coach_assignment_error? && has_text?('* Please assign Group first')
    end

    def has_coach_assignment?
      has_text? "Current Coach/Moderator: #{@coach}"
    end

    def assign_group
      click_on 'Assign New Group'
      select "Group #{group_num}", from: 'membership_group_id'
      fill_in 'membership_display_name', with: @display_name unless ENV['tfd']
      fill_in 'membership_start_date', with: start_date
      fill_in 'membership_end_date', with: end_date
      check_standard_week_and_end_date
      click_on 'Assign'
    end

    def has_invalid_membership_alert?
      has_text? 'Memberships is invalid'
    end

    def has_blank_start_date_alert?
      has_text? 'Start date can\'t be blank'
    end

    def has_blank_end_date_alert?
      has_text? 'End date can\'t be blank'
    end

    def has_end_date_in_the_past?
      has_text? 'End date must not be in the past'
    end

    def has_group_assigned_successfully?
      has_text?('Group was successfully assigned') &&
        has_text?('Membership Status: Active' \
                  "\nCurrent Group: Group #{group_num}")
    end

    private

    def user_navigation
      @user_navigation ||= Users::Navigation.new
    end

    def fill_in_study_id_email_phone_number(id = @study_id)
      fill_in 'participant_study_id', with: id
      fill_in 'participant_email', with: @email
      fill_in 'participant_phone_number', with: @phone_number
    end

    def has_participant?(id = @study_id)
      has_text? "Study Id: #{id}" \
                "\nEmail: #{@email}" \
                "\nPhone Number: #{@phone}" \
                "\nContact Preference: #{@contact_preference}"
    end

    def has_coach_assignment_error?
      expect { click_on 'Assign Coach/Moderator' }
        .to raise_error(Capybara::ElementNotFound)
    end

    def group_number
      @group_number ||= ENV['tfd'] ? 5 : 1
    end

    def start_date
      @start_date.is_a?(String) ? @start_date : @start_date.strftime('%Y-%m-%d')
    end

    def end_date
      @end_date.is_a?(String) ? @end_date : @end_date.strftime('%Y-%m-%d')
    end

    def check_standard_week_and_end_date
      weeks_later = ENV['tfd'] ? (20 * 7) : 56
      week_num = ENV['tfd'] ? 20 : 8
      expect(page)
        .to have_content "Standard number of weeks: #{week_num}, Projected" \
                         ' End Date from today: ' \
                         "#{(Date.today + weeks_later).strftime('%m/%d/%Y')}"
    end
  end
end
