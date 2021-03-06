# ThinkFeelDo Core Features

This is a test suite that can be pointed at any of the ThinkFeelDo host apps:

* [ThinkFeelDo](https://github.com/cbitstech/think_feel_do)
* [ThinkFeelDoSo](https://github.com/cbitstech/think_feel_do_so)
* [SunnySide](https://github.com/cbitstech/sunnyside)
* [Marigold](https://github.com/NU-CBITS/marigold)

## Information for running this test suite

This test suite is written using Capybara with RSpec. It uses Selenium
WebDriver to drive the tests. It is set up to be configured to use Safari,
Chrome, or Firefox as the browser. It can also be pointed at Sauce Labs for
even more environment possibilities. For general information on this set up,
see this [guide](https://github.com/cbitstech/guides/tree/master/testing/selenium/selenium_webdriver).

Due to dependency issues with versions of selenium-webdriver and Firefox, I
have different versions of Firefox running on my machine. The version used for
this suite is 33.0. I would suggest downloading this version of Firefox to the
same directory specified in the `spec_helper`. You can download version 33.0
[here](https://ftp.mozilla.org/pub/firefox/releases/33.0/mac/en-US/).

You will need to set up the following participants and users in the host app.
You can use the fixtures in the host app to seed this data. See the
corresponding rake file (under `./lib/tasks/`) for the tasks that make sense
to the environment in which you are testing.

* Participants: `participant1` - `participant5`, `participant_grp1_moderator`,
  `participant_background`, `inactive_participant`, `active_participant`,
  `participant_for_withdraw_test`, `participant_for_group5`,
  `participant_is_complete`, `participant_mobile_complete`, `participant_phq`,
  `participant61` - `participant65`
* Users: `admin1`, `clinician1`, `user2`, `content_author1`, `researcher1`

See [TFD Selenium Fixtures](https://github.com/cbrenner04/tfd_selenium_fixtures)
for more details on the data that these participants and users need. Not every
host app needs every participant and user:

You will need a file called `env_variables.rb`, which is required in the
`.rspec` file, that houses the following environment variables. These
correspond with the data for the above participants and users seeded in the
host app.

The  `Participant_Phone_Number` variable is formatted 18885559999 while the
`Participant_Phone_Number_1` is formatted 1(888) 555-9999. The `Audio_File`
variable is a URL specific to the host app.

    Base_URL; Participant_Email; Participant_Password; Participant_2_Email;
    Participant_2_Password; PT61_Email; PT61_Password; Old_Participant_Email;
    Old_Participant_Password; Alt_Participant_Email; Alt_Participant_Password;
    NS_Participant_Email; NS_Participant_Password; Completed_Pt_Email;
    Completed_Pt_Password; Mobile_Comp_Pt_Email; Mobile_Comp_Pt_Password;
    PT61_Email; PT61_Password; Participant_4_Email; Participant_4_Password;
    Participant_5_Email; Participant_5_Password; PTBackground_Email;
    PTBackground_Password; User_Email; User_Password; Clinician_Email;
    Clinician_Password; Researcher_Email; Researcher_Password;
    Content_Author_Email; Content_Author_Password; Participant_Phone_Number;
    Participant_Phone_Number_1; Audio_File

To run on Sauce Labs you will need to set the following environment variables,
otherwise you can run it locally on your machine:

    SAUCE_USERNAME; SAUCE_ACCESS_KEY

Once you have the data seeded in the app and the env_variables.rb file
configured, run the following to see what rake tasks apply to particular suite
you are looking to run:

    rake -T

Note: it is probably best to run this suite near midday. I like to set my
system time to 2 pm.
