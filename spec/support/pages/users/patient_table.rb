# frozen_string_literal: true
require './spec/support/pages/users/navigation'
require './spec/support/pages/users/patient_dashboard/phq_assessments'

module Users
  # page object for the patient table
  # this is the patient list where you select the patient for viewing dashboard
  class PatientTable
    include Capybara::DSL
    include Users::PatientDashboards::PHQAssessments

    def initialize(patient_table)
      @participant = patient_table[:participant]
      @date = patient_table[:date]
      @total_logins = patient_table[:total_logins]
      @most_recent_phq_score = patient_table[:most_recent_phq_score]
    end

    def open
      click_on 'Patient Dashboard'
      # The PHQ group takes a long time to load
      # using `find('foo', match: :first)` / `find('foo', count: 1)` didn't help
      sleep(1) if ENV['tfd']
      find('h1', text: 'Patient Dashboard')
    end

    def has_participant_visible?
      find('#patients').has_text? @participant
    end

    def navigate_to_inactive_patients
      click_on 'Inactive Patients'
    end

    def terminate_access
      within patient_row do
        user_navigation.confirm_with_js unless driver_is_firefox
        click_on 'Terminate Access'
        sleep(1)
        accept_alert 'Are you sure you would like to terminate access ' \
                     'to this membership? This option should also be ' \
                     'used before changing membership of the patient to ' \
                     'a different group or to completely revoke access ' \
                     'to this membership. You will not be able to undo ' \
                     'this.' if driver_is_firefox
      end
    end

    def has_withdrawal_date?
      find('.inactive', text: @participant).has_text? "Withdrawn #{@date}"
    end

    def select_patient
      click_on_patient_name
      sleep(1) # expecting something on the next page fails
    end

    def has_login_info?
      within patient_row do
        has_text?("#{@participant} 0 6") &&
          has_text?("#{@total_logins} #{long_date(@date)}")
      end
    end

    private

    def user_navigation
      @user_navigation ||= Users::Navigation.new
    end

    def patient_row
      patient_table = find('#patients')
      if @participant == 'PHQ-1'
        patient_table.first('tr', text: @participant)
      else
        patient_table.find('tr', text: @participant)
      end
    end

    def click_on_patient_name
      tries ||= 2
      within(patient_row) { click_on @participant }
    rescue Selenium::WebDriver::Error::UnknownError
      user_navigation.scroll_down
      retry unless (tries -= 1).zero?
    end

    def driver_is_firefox
      return true unless ENV['safari'] || ENV['chrome']
    end
  end
end
