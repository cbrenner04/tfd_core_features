# frozen_string_literal: true
module Participants
  module PracticeModules
    # page object for the Reappraisals module
    class Reappraisals
      include Capybara::DSL

      def initialize(reappraisal)
        @description ||= reappraisal[:description]
        @stressor ||= reappraisal[:stressor]
        @reappraisal ||= reappraisal[:reappraisal]
        @reflection ||= reappraisal[:reflection]
        @created_at ||= reappraisal[:created_at]
      end

      def open
        click_on 'New Reappraisal'
      end

      def open_review
        click_on 'View Reappraisals'
      end

      def has_review_visible?
        has_css?('#reappraisals')
      end

      def view_perspective_examples
        click_on 'Think about the other person\'s perspective'
      end

      def has_perspective_examples?
        find('#collapse-perspective-examples', match: :first)
        has_css?('#collapse-perspective-examples',
                 text: 'Did someone annoy you, frustrate you, or treat you ' \
                       'badly? Think about reasons someone might act that ' \
                       'way. Have you ever been rude to someone because you ' \
                       'were having a bad day, or done something ' \
                       'inconsiderate because you were just forgetful? This ' \
                       'doesn\'t mean their behavior is okay. And you ' \
                       'definitely don\'t need to let someone be mean or ' \
                       'abusive. But if it was something small, being ' \
                       'understanding can make things less stressful for you!')
      end

      def view_it_could_be_worse_examples
        click_on '"It could be worse!"'
      end

      def has_it_could_be_worse_examples?
        find('#collapse-worse-examples', match: :first)
        has_css?('#collapse-worse-examples',
                 text: 'Can you think of a way that even though something ' \
                       'went wrong, something else went right? (for example,' \
                       ' I tripped and spilled my coffee, but at least I ' \
                       'didn\'t hurt myself!) Taking a second to feel ' \
                       'grateful can help reduce your stress over your ' \
                       'problems.')
      end

      def view_got_through_it_examples
        click_on 'What got you through it?'
      end

      def has_got_through_it_examples?
        find('#collapse-reflection-examples', match: :first)
        has_css?('#collapse-reflection-examples',
                 text: 'Did you use your skills or personal strengths to ' \
                       'make the problem better? Did someone help you when ' \
                       'you were having trouble? Do you have a friend who ' \
                       'helped distract you, or at least listened to you ' \
                       'complain? Sometimes you can take a negative event ' \
                       'and use it to call attention to what\'s positive in ' \
                       'your life.')
      end

      def enter_description
        fill_in 'reappraisal[description]', with: @description
      end

      def has_description_alert?
        has_css?('.alert', text: 'Description can\'t be blank')
      end

      def enter_stressor
        fill_in 'reappraisal[stressful_cause]', with: @stressor
      end

      def has_stressor_alert?
        has_css?('.alert', text: 'Stressful cause can\'t be blank')
      end

      def enter_reappraisals
        fill_in 'reappraisal[reappraisal_action]', with: @reappraisal
      end

      def has_reappraisal_alert?
        has_css?('.alert', text: 'Reappraisal action can\'t be blank')
      end

      def enter_reflection
        fill_in 'reappraisal[reflection]', with: @reflection
      end

      def has_reflection_alert?
        has_css?('.alert', text: 'Reflection can\'t be blank')
      end

      def complete
        enter_description
        enter_stressor
        enter_reappraisals
        enter_reflection
      end

      def has_reappraisal?
        has_css?('tr',
                 text: "#{@description} #{@stressor} #{@reappraisal} " \
                       "#{@reflection} #{long_date_with_hour(@created_at)}")
      end
    end
  end
end
