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
TC-007-ตรวจสอบการแสดงปุ่มตั้งเป็นที่อยู่เริ่มต้นหลังแก้ไขที่อยู่จัดส่ง
    [Documentation]    ตรวจสอบการกำหนดที่อยู่ที่แก้ไขเป็นค่าเริ่มต้น
    [Tags]    TC-007    US-ADDR-03
    Login With Account    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}    Button
    Go To Address Management
    Click    css=[data-test^="btn-edit-address-"] >> nth=1
    ${house_number}=    Evaluate    random.randint(1, 999)    modules=random
    ${house_group}=    Evaluate    random.randint(1, 99)    modules=random
    ${village_number}=    Evaluate    random.randint(1, 15)    modules=random
    ${updated_address}=    Catenate    SEPARATOR=    ${house_number}    /    ${house_group}    ${SPACE}หมู่${SPACE}    ${village_number}
    Fill Text    role=textbox[name="บ้านเลขที่ / ถนน / ซอย"]    ${updated_address}
    Select Options By    css=select[name="province"]    value    69
    Select Options By    css=select[name="district"]    value    911
    Select Options By    css=select[name="subDistrict"]    value    8119
    Click    css=[data-test="btn-save-address"]
    Wait For Elements State    text="แก้ไขที่อยู่สำเร็จ"    visible    timeout=10s
    ${save_states}=    Get Element States    text="แก้ไขที่อยู่สำเร็จ"
    Should Contain    ${save_states}    visible
    ${default_button_states}=    Get Element States    css=[data-test="btn-set-default"] >> nth=0
    Should Contain    ${default_button_states}    visible

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
