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
TC-012-ตรวจสอบจำนวนป้ายสถานะที่อยู่เริ่มต้นว่ามีเพียงหนึ่งรายการ
    [Documentation]    ตรวจสอบว่าระบบแสดงที่อยู่เริ่มต้นเพียงรายการเดียว
    [Tags]    TC-012    US-ADDR-04
    Login With Account    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}    Enter
    Go To Address Management
    ${current_url}=    Get Url
    Should Be Equal    ${current_url}    ${BASE_URL}address-profile
    Wait For Elements State    css=[data-test="address-detail"] >> nth=0    visible    timeout=10s
    Wait For Elements State    text="ค่าเริ่มต้น"    visible    timeout=10s
    ${default_badge_count}=    Get Element Count    text="ค่าเริ่มต้น"
    Should Be Equal As Integers    ${default_badge_count}    1

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
