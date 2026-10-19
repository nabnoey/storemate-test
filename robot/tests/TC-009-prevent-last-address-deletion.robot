*** Settings ***
Library    Browser
Test Setup    Start Browser Session
Test Teardown    Close Browser With Failure Screenshot

*** Variables ***
${BASE_URL}    https://storemate-final.vercel.app/
${LOGIN_EMAIL}    ployy@gmail.com
${LOGIN_PASSWORD}    Ploy1234
${HEADLESS}    ${True}

*** Test Cases ***
TC-009-ตรวจสอบการแจ้งเตือนเมื่อพยายามลบที่อยู่เริ่มต้นรายการสุดท้าย
    [Documentation]    ตรวจสอบการป้องกันการลบที่อยู่สุดท้ายของผู้ใช้งาน
    [Tags]    TC-009    US-ADDR-04
    Login With Account    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}    Enter
    Go To Address Management
    Click    css=[data-test="btn-delete-address-459"]
    Wait For Elements State    role=status    visible    timeout=10s
    ${status_text}=    Get Text    role=status
    Should Contain    ${status_text}    ไม่สามารถลบได้ เนื่องจากต้องมีที่อยู่เริ่มต้นอย่างน้อย 1 รายการ

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
