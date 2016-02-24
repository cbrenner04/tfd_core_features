require './lib/pages/participants/navigation'
require './lib/pages/participants/social_networking'

class Participants
  # page object for Relax tool
  class Relax
    include Capybara::DSL

    def initialize(relax_arry)
      @feed_item ||= relax_arry[:feed_item]
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
      navigation.next
      visible?
    end

    def find_in_feed
      social_networking
        .find_feed_item("Listened to a Relaxation Exercise: #{@feed_item}")
    end

    private

    def navigation
      @navigation ||= Participants::Navigation.new
    end

    def social_networking
      @social_networking ||= Participants::SocialNetworking.new
    end
  end
end
