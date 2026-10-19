*** Settings ***
Library    Browser
Test Setup    Start Browser Session
Test Teardown    Close Browser With Failure Screenshot

*** Variables ***
${BASE_URL}    https://storemate-final.vercel.app/
${LOGIN_EMAIL}    jaturong1@gmail.com
${LOGIN_PASSWORD}    Jaturong1234
${HEADLESS}    ${True}

*** Test Cases ***
TC-002-ตรวจสอบการแสดงข้อความแจ้งเตือนเมื่อไม่มีข้อมูลที่อยู่จัดส่ง
    [Documentation]    ตรวจสอบการแสดงผลเมื่อผู้ใช้งานไม่มีที่อยู่จัดส่ง
    [Tags]    TC-002    US-ADDR-02
    Login With Account    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}    Button
    Go To Address Management
    Wait For Elements State    text="ไม่มีข้อมูลที่อยู่ของคุณ"    visible    timeout=10s

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
