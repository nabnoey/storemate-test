*** Settings ***
Library    Browser
Test Setup    Start Browser Session
Test Teardown    Close Browser With Failure Screenshot

*** Variables ***
${BASE_URL}    https://storemate-final.vercel.app/
${LOGIN_EMAIL}    eyejang1@gmail.com
${LOGIN_PASSWORD}    Eyejang1234
${HEADLESS}    ${True}
${NEW_ADDRESS}    12/2 หมู่3

*** Test Cases ***
TC-005-ตรวจสอบการปิดใช้งาน Dropdown อำเภอเมื่อยังไม่ได้เลือกจังหวัด
    [Documentation]    ตรวจสอบการปิดใช้งาน Dropdown อำเภอเมื่อยังไม่ได้เลือกจังหวัด
    [Tags]    TC-005    US-ADDR-02
    Login With Account    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}    Button
    Go To Address Management
    Click    css=[data-test="btn-add-address"]
    Fill Text    role=textbox[name="บ้านเลขที่ / ถนน / ซอย"]    ${NEW_ADDRESS}
    ${district_states}=    Get Element States    css=select[name="district"]
    Should Contain    ${district_states}    disabled

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
