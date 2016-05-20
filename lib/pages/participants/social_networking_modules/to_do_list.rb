module Participants
  module SocialNetworkingModules
    # page object for the to do list
    class ToDoList
      include Capybara::DSL

      def initialize(to_do_list)
        @task ||= to_do_list[:task]
      end

      def visible?
        has_css?('.panel-title', text: 'To Do')
      end

      def has_profile_task?
        has_text? 'Create a Profile'
      end

      def select_task
        click_on @task
      end

      def complete?
        has_text? 'You are all caught up! Great work!'
      end
    end
  end
end
