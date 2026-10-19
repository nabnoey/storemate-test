*** Settings ***
Library    Browser
Test Setup    Start Browser Session
Test Teardown    Close Browser With Failure Screenshot

*** Variables ***
${BASE_URL}    https://storemate-final.vercel.app/
${LOGIN_EMAIL}    num1@gmail.com
${LOGIN_PASSWORD}    Numm1234
${HEADLESS}    ${True}

*** Test Cases ***
TC-010-ตรวจสอบการคงอยู่ของข้อมูลที่อยู่จัดส่งเมื่อยกเลิกการลบ
    [Documentation]    ตรวจสอบการยกเลิกการลบที่อยู่จัดส่ง
    [Tags]    TC-010    US-ADDR-04
    Login With Account    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}    Enter
    Go To Address Management
    Click    css=[data-test="btn-delete-address-504"]
    Click    role=button[name="ยกเลิก"]
    ${page_text}=    Get Text    css=#root
    Should Contain    ${page_text}    10/1 หมู่1 ต.บางหลวง อ.บางเลน จ.นครปฐม 73190

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
