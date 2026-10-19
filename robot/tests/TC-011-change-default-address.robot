*** Settings ***
Library    Browser
Test Setup    Start Browser Session
Test Teardown    Close Browser With Failure Screenshot

*** Variables ***
${BASE_URL}    https://storemate-final.vercel.app/
${LOGIN_EMAIL}    eyejang1@gmail.com
${LOGIN_PASSWORD}    Eyejang1234
${HEADLESS}    ${True}

*** Test Cases ***
TC-011-ตรวจสอบการเปลี่ยนที่อยู่เริ่มต้นและสถานะปุ่มตั้งค่าเริ่มต้น
    [Documentation]    ตรวจสอบการเปลี่ยนที่อยู่เริ่มต้นเป็นที่อยู่อื่นที่บันทึกไว้
    [Tags]    TC-011    US-ADDR-04
    Login With Account    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}    Enter
    Go To Address Management
    ${default_buttons}=    Get Elements    css=[data-test="btn-set-default"]
    ${first_button_states}=    Get Element States    ${default_buttons}[0]
    Should Contain    ${first_button_states}    disabled
    ${second_button_states}=    Get Element States    ${default_buttons}[1]
    Should Contain    ${second_button_states}    enabled
    Click    ${default_buttons}[1]
    ${disabled_button_count}=    Get Element Count    css=[data-test="btn-set-default"]:disabled
    Should Be Equal As Integers    ${disabled_button_count}    1

*** Keywords ***
Start Browser Session
    New Browser    chromium    headless=${HEADLESS}
    New Context
    New Page

Close Browser With Failure Screenshot
    Run Keyword If Test Failed    Take Screenshot
    Close Browser

Login With Account
    [Arguments]    ${email}    ${password}    ${submit_method}
    Go To    ${BASE_URL}
    Click    css=[data-test="login-btn"]
    Fill Text    css=[data-test="email"]    ${email}
    Fill Text    css=[data-test="password"]    ${password}
    IF    '${submit_method}' == 'Enter'
        Press Keys    css=[data-test="password"]    Enter
    ELSE
        Click    css=[data-test="btn-submit"]
    END

Go To Address Management
    Click    css=[data-test="btn-user-profile"]
    Click    css=[data-test="btn-edit-profile"]
    Click    role=button[name="จัดการที่อยู่"]
