*** Settings ***
Documentation     WikipediaSample.apk sample test on BrowserStack App Automate.
...               The BrowserStack SDK injects the app and device capabilities from
...               browserstack.yml; the test only drives the app UI.
Library           AppiumLibrary
Suite Teardown    Close All Applications

*** Variables ***
${REMOTE_URL}     https://hub.browserstack.com/wd/hub

*** Test Cases ***
Search Wikipedia For BrowserStack
    [Documentation]    Tap search, type "BrowserStack", assert result text views appear.
    Open Application    ${REMOTE_URL}    platformName=android    automationName=UiAutomator2
    Wait Until Page Contains Element    accessibility_id=Search Wikipedia    timeout=30
    Click Element    accessibility_id=Search Wikipedia
    Wait Until Page Contains Element    id=org.wikipedia.alpha:id/search_src_text    timeout=30
    Input Text    id=org.wikipedia.alpha:id/search_src_text    BrowserStack
    Sleep    5s
    ${results}=    Get Webelements    class=android.widget.TextView
    Length Should Be Greater Than    ${results}    0

*** Keywords ***
Length Should Be Greater Than
    [Arguments]    ${container}    ${count}
    ${length}=    Get Length    ${container}
    Should Be True    ${length} > ${count}
    ...    msg=Expected more than ${count} TextView elements, found ${length}
