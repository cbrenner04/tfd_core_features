# ThinkFeelDo Core Features

This is a test suite that can be pointed at any of the ThinkFeelDo host apps:

* [ThinkFeelDo](https://github.com/cbitstech/think_feel_do)
* [ThinkFeelDoSo](https://github.com/cbitstech/think_feel_do_so)
* [SunnySide](https://github.com/cbitstech/sunnyside)
* [Marigold](https://github.com/NU-CBITS/marigold)

## Information for running this test suite

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

See selenium fixtures in the host app for more details on the data that these
participants and users need. Not every host app needs every participant and
user:

* [ThinkFeelDo](https://github.com/cbitstech/think_feel_do/tree/master/spec/selenium_fixtures)
* [ThinkFeelDoSo](https://github.com/cbitstech/think_feel_do_so/tree/master/spec/selenium_fixtures)
* [SunnySide](https://github.com/cbitstech/sunnyside/tree/master/spec/selenium_fixtures)
* [Marigold](https://github.com/NU-CBITS/marigold/tree/master/spec/selenium_fixtures)

You will need a file called `env_variables.rb`, which is required in the
`.rspec` file, that houses the following environment variable. These correspond
with the data for the above participant and users seeded in the host app.

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
configured, checkout the `./lib/tasks/run.rake` file to find the specific task
for running the suite.
