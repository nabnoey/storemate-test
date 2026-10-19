*** Settings ***
Library    Browser
Test Setup    Start Browser Session
Test Teardown    Close Browser With Failure Screenshot

*** Variables ***
${BASE_URL}    https://storemate-final.vercel.app/
${LOGIN_EMAIL}    eyejang1@gmail.com
${LOGIN_PASSWORD}    Eyejang1234
${HEADLESS}    ${True}
${UPDATED_ADDRESS}    10/2 หมู่7

*** Test Cases ***
TC-006-ตรวจสอบการบันทึกข้อมูลที่อยู่จัดส่งหลังจากแก้ไขสำเร็จ
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลที่อยู่จัดส่งและบันทึกสำเร็จ
    [Tags]    TC-006    US-ADDR-03
    Login With Account    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}    Button
    Go To Address Management
    Click    css=[data-test^="btn-edit-address-"] >> nth=0
    Fill Text    role=textbox[name="บ้านเลขที่ / ถนน / ซอย"]    ${UPDATED_ADDRESS}
    Select Options By    css=select[name="province"]    value    9
    Select Options By    css=select[name="district"]    value    118
    Select Options By    css=select[name="subDistrict"]    value    931
    Click    css=[data-test="btn-save-address"]
    Wait For Elements State    text="แก้ไขที่อยู่สำเร็จ"    visible    timeout=10s
    ${states}=    Get Element States    text="แก้ไขที่อยู่สำเร็จ"
    Should Contain    ${states}    visible

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
