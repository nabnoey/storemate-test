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
TC-004-ตรวจสอบการแจ้งเตือนเมื่อบันทึกที่อยู่โดยกรอกข้อมูลไม่ครบ
    [Documentation]    ตรวจสอบการป้องกันการบันทึกเมื่อกรอกข้อมูลที่อยู่ไม่ครบถ้วน
    [Tags]    TC-004    US-ADDR-02
    Login With Account    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}    Button
    Go To Address Management
    Click    css=[data-test="btn-add-address"]
    Select Options By    css=select[name="province"]    value    15
    Select Options By    css=select[name="district"]    value    180
    Select Options By    css=select[name="subDistrict"]    value    1452
    Click    css=[data-test="btn-save-address"]
    Wait For Elements State    text="กรุณากรอกข้อมูลให้ครบถ้วน"    visible    timeout=10s
    ${states}=    Get Element States    text="กรุณากรอกข้อมูลให้ครบถ้วน"
    Should Contain    ${states}    visible
    Click    css=[data-test="btn-cancel-address"]

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
