# frozen_string_literal: true
require './spec/support/pages/participants/navigation'
require './spec/support/pages/participants/social_networking'

module Participants
  # page object for Relax tool
  class Relax
    include Capybara::DSL

    def initialize(relax)
      @feed_item ||= relax[:feed_item]
    end

    def landing_page
      "#{ENV['Base_URL']}/navigator/contexts/RELAX"
    end

    def visible?
      has_text? 'RELAX Home'
    end

    def open_autogenic_exercises
      click_on 'Autogenic Exercises'
    end

    def play_audio
      find('.jp-controls').find('.jp-play').click
    end

    def finish
      participant_navigation.next
      find('h1', text: 'RELAX Home')
    end

    def find_in_feed
      social_networking
        .find_feed_item("Listened to a Relaxation Exercise: #{@feed_item}")
    end

    private

    def participant_navigation
      @participant_navigation ||= Participants::Navigation.new
    end

    def social_networking
      @social_networking ||= Participants::SocialNetworking.new
    end
  end
end
