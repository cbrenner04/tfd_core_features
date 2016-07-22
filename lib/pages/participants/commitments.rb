# frozen_string_literal: true
module Participants
  # page object for the Commitments tool in Marigold
  class Commitments
    include Capybara::DSL

    def open
      click_on 'COMMITMENTS'
    end

    def has_summary_cant_be_blank?
      has_css?('.alert', text: 'Summary can\'t be blank')
    end
  end
end
