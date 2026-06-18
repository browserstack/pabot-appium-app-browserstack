*** Settings ***
Documentation     BStackSampleApp.ipa sample test on BrowserStack App Automate.
...               The BrowserStack SDK injects the app and device capabilities from
...               browserstack.yml; the test only drives the app UI.
Library           AppiumLibrary
Suite Teardown    Close All Applications

*** Variables ***
${REMOTE_URL}     https://hub.browserstack.com/wd/hub

*** Test Cases ***
Submit Text And Assert Output
    [Documentation]    Tap Text Button, type an email, assert the output label echoes it.
    Open Application    ${REMOTE_URL}    platformName=ios    automationName=XCUITest
    Wait Until Page Contains Element    accessibility_id=Text Button    timeout=30
    Click Element    accessibility_id=Text Button
    Input Text    accessibility_id=Text Input    hello@browserstack.com\n
    ${output}=    Get Text    accessibility_id=Text Output
    Should Be Equal    ${output}    hello@browserstack.com
