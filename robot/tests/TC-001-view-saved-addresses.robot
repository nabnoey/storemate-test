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
TC-001-ตรวจสอบการเข้าสู่หน้าจัดการที่อยู่จัดส่งผ่านเมนูโปรไฟล์สำเร็จ
    [Documentation]    ตรวจสอบการแสดงรายการและรายละเอียดที่อยู่จัดส่งที่บันทึกไว้
    [Tags]    TC-001    US-ADDR-01
    Login With Account    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}    Enter
    Go To Address Management
    ${current_url}=    Get Url
    Should Be Equal    ${current_url}    ${BASE_URL}address-profile

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
