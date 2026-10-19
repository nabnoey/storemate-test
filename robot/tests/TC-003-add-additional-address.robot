*** Settings ***
Library    Browser
Test Setup    Start Browser Session
Test Teardown    Close Browser With Failure Screenshot

*** Variables ***
${BASE_URL}    https://storemate-final.vercel.app/
${LOGIN_EMAIL}    boom1@gmail.com
${LOGIN_PASSWORD}    Boom1234
${HEADLESS}    ${True}
${NEW_ADDRESS}    13/1 หมู่2
${EXPECTED_NEW}    13/1 หมู่2 ต.ห้วยกรด อ.สรรคบุรี จ.ชัยนาท 17140
${EXPECTED_OLD}    20/1 หมู่12 ต.นามะตูม อ.พนัสนิคม จ.ชลบุรี 20140

*** Test Cases ***
TC-003-ตรวจสอบการบันทึกและแสดงที่อยู่ใหม่ร่วมกับที่อยู่เดิม
    [Documentation]    ตรวจสอบการเพิ่มที่อยู่จัดส่งใหม่เมื่อมีที่อยู่เดิม
    [Tags]    TC-003    US-ADDR-02
    Login With Account    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}    Button
    Go To Address Management
    ${address_count_before}=    Get Element Count    css=[data-test="address-detail"]
    Click    css=[data-test="btn-add-address"]
    Fill Text    role=textbox[name="บ้านเลขที่ / ถนน / ซอย"]    ${NEW_ADDRESS}
    Select Options By    css=select[name="province"]    value    9
    Wait For Elements State    css=select[name="district"] >> option[value="119"]    attached    timeout=10s
    Select Options By    css=select[name="district"]    value    119
    Wait For Elements State    css=select[name="subDistrict"] >> option[value="934"]    attached    timeout=10s
    Select Options By    css=select[name="subDistrict"]    value    934
    Click    css=[data-test="btn-save-address"]
    Wait For Elements State    text="เพิ่มที่อยู่สำเร็จ"    visible    timeout=10s
    ${expected_address_count}=    Evaluate    ${address_count_before} + 1
    Wait For Function    () => document.querySelectorAll('[data-test="address-detail"]').length >= ${expected_address_count}    timeout=15s
    Get Text    css=#root    contains    ${EXPECTED_NEW}
    Get Text    css=#root    contains    ${EXPECTED_OLD}
    Click    css=[data-test^="btn-delete-address-"] >> nth=0
    Click    role=button[name="ยืนยัน"]
    Wait For Elements State    text="ลบที่อยู่สำเร็จ"    visible    timeout=10s

*** Keywords ***
Start Browser Session
    New Browser    chromium    headless=${HEADLESS}
    New Context
    New Page
    Set Retry Assertions For    10s

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