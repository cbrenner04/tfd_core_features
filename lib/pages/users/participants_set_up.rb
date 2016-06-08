# frozen_string_literal: true
require './lib/pages/users/navigation'

module Users
  # page object for Participants
  class ParticipantsSetUp
    include RSpec::Matchers
    include Capybara::DSL

    def initialize(participants)
      @study_id ||= participants[:study_id]
      @updated_study_id ||= participants[:updated_study_id]
      @email ||= participants[:email]
      @phone_number ||=
        participants.fetch(:phone_number, ENV['Participant_Phone_Number'])
      @alt_phone ||=
        participants.fetch(:alt_phone, ENV['Participant_Phone_Number_1'])
      @contact_preference ||= participants[:contact_preference]
      @coach ||= participants.fetch(:coach, ENV['Clinician_Email'])
      @display_name ||= participants.fetch(:display_name, 'Tester')
      @start_date ||= participants[:start_date]
      @end_date ||= participants[:end_date]
      @group_number ||= participants[:group_number]
    end

    def landing_page
      "#{ENV['Base_URL']}/think_feel_do_dashboard/participants"
    end

    def visible?
      has_css?('h1', text: 'Participants')
    end

    def create
      click_on 'New'
      fill_in_study_id_email_phone_number(@study_id)
      select @contact_preference, from: 'participant_contact_preference'
      click_on 'Create'
    end

    def created_successfully?
      has_css?('.alert', text: 'Participant was successfully created.') &&
        has_participant?(@study_id)
    end

    def open
      user_navigation.scroll_to_bottom
      click_on @study_id
    end

    def update
      click_on 'Edit'
      fill_in_study_id_email_phone_number(@updated_study_id)
      user_navigation.scroll_down
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
      user_navigation.scroll_down
      click_on 'Assign New Group'
      select "Group #{group_number}", from: 'membership_group_id'
      fill_in 'membership_display_name', with: @display_name unless ENV['tfd']
      fill_in 'membership_start_date', with: @start_date unless ENV['chrome']
      fill_in 'membership_end_date', with: @end_date unless ENV['chrome']
      has_standard_week_and_end_date?
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

    def has_display_name_needed_alert?
      has_text? "Group #{@group_number} is part of a social arm. " \
                'Display name is required for social arms.'
    end

    def has_group_assigned_successfully?
      has_text?('Group was successfully assigned') &&
        has_text?('Membership Status: Active' \
                  "\nCurrent Group: Group #{group_number}")
    end

    def assign_coach
      sleep(0.25)
      user_navigation.scroll_down
      click_on 'Assign Coach/Moderator'

      if ENV['tfd']
        select @coach, from: 'coach_assignment_coach_id'
        click_on 'Assign'
      end
    end

    def has_coach_assigned_successfully?
      has_css?('.alert-success',
               text: 'Coach/Moderator was successfully assigned') &&
        has_text?("Current Coach/Moderator: #{@coach}")
    end

    def destroyed_successfully?
      has_css?('.alert-success',
               text: 'Participant was successfully destroyed.') &&
        has_no_text?(@study_id)
    end

    private

    def user_navigation
      @user_navigation ||= Users::Navigation.new
    end

    def fill_in_study_id_email_phone_number(pt_id)
      fill_in 'participant_study_id', with: pt_id
      fill_in 'participant_email', with: @email
      fill_in 'participant_phone_number', with: @phone_number
    end

    def has_participant?(pt_id)
      has_text? "Study Id: #{pt_id}" \
                "\nEmail: #{@email}" \
                "\nPhone Number: #{@alt_phone}" \
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
      @start_date.is_a?(String) ? @start_date : iso_date(@start_date)
    end

    def end_date
      @end_date.is_a?(String) ? @end_date : iso_date(@end_date)
    end

    def has_standard_week_and_end_date?
      weeks_later = ENV['tfd'] ? (20 * 7) : 56
      week_num = ENV['tfd'] ? 20 : 8
      has_text? "Standard number of weeks: #{week_num}, Projected" \
                " End Date from today: #{short_date(today + weeks_later)}"
    end
  end
end
