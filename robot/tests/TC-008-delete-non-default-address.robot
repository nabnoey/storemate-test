*** Settings ***
Library    Browser
Test Setup    Prepare New Address For Deletion
Test Teardown    Close Browser With Failure Screenshot

*** Variables ***
${BASE_URL}    https://storemate-final.vercel.app/
${LOGIN_EMAIL}    makwid@gmail.com
${LOGIN_PASSWORD}    Makwid1234
${HEADLESS}    ${True}
${ADDRESS_ITEM}    css=[data-test="address-detail"]
${DELETE_BUTTONS_JS}    () => Array.from(document.querySelectorAll('[data-test^="btn-delete-address-"]')).map(el => el.getAttribute('data-test'))

*** Test Cases ***
TC-008-ตรวจสอบการลบที่อยู่จัดส่งที่ไม่ใช่ค่าเริ่มต้นสำเร็จและคงสถานะที่อยู่เริ่มต้นไว้
    [Documentation]    ตรวจสอบการลบที่อยู่จัดส่งที่ไม่ใช่ค่าเริ่มต้น
    [Tags]    TC-008    US-ADDR-04
    Click    css=[data-test="${NEW_ADDRESS_ID}"]
    Click    role=button[name="ยืนยัน"]
    Wait For Elements State    text="ลบที่อยู่สำเร็จ"    visible    timeout=10s
    Wait For Elements State    css=[data-test="${NEW_ADDRESS_ID}"]    detached    timeout=10s
    Get Element Count    ${ADDRESS_ITEM}    ==    ${COUNT_BEFORE}
    Get Element Count    text="ค่าเริ่มต้น"    ==    1

*** Keywords ***
Prepare New Address For Deletion
    New Browser    chromium    headless=${HEADLESS}
    New Context
    New Page
    Set Retry Assertions For    10s
    Login With Account    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}    Enter
    Go To Address Management
    # รอให้รายการที่อยู่โหลดเสร็จก่อนนับ (จุดที่ทำให้ตกเดิม)
    Wait For Elements State    ${ADDRESS_ITEM} >> nth=0    visible    timeout=15s
    ${count_before}=    Get Element Count    ${ADDRESS_ITEM}
    ${old_ids}=    Evaluate JavaScript    ${None}    ${DELETE_BUTTONS_JS}
    # เพิ่มที่อยู่ใหม่
    Click    css=[data-test="btn-add-address"]
    ${house_number}=    Evaluate    random.randint(1, 9999)    modules=random
    Fill Text    role=textbox[name="บ้านเลขที่ / ถนน / ซอย"]    ${house_number} หมู่ 5
    Select Options By    css=select[name="province"]    value    69
    Wait For Elements State    css=select[name="district"] >> option[value="912"]    attached    timeout=10s
    Select Options By    css=select[name="district"]    value    912
    Wait For Elements State    css=select[name="subDistrict"] >> option[value="8129"]    attached    timeout=10s
    Select Options By    css=select[name="subDistrict"]    value    8129
    Click    css=[data-test="btn-save-address"]
    Wait For Elements State    text="เพิ่มที่อยู่สำเร็จ"    visible    timeout=10s
    # รอจนจำนวนเพิ่มขึ้น 1 (retry ได้)
    ${expected_count}=    Evaluate    ${count_before} + 1
    Get Element Count    ${ADDRESS_ITEM}    ==    ${expected_count}    timeout=15s
    # หา id ของที่อยู่ที่เพิ่งสร้าง
    ${new_ids}=    Evaluate JavaScript    ${None}    ${DELETE_BUTTONS_JS}
    ${added_ids}=    Evaluate    list(set($new_ids) - set($old_ids))
    Should Not Be Empty    ${added_ids}    ไม่พบที่อยู่ที่สร้างใหม่
    ${new_address_id}=    Evaluate    $added_ids[0]
    Set Test Variable    ${COUNT_BEFORE}    ${count_before}
    Set Test Variable    ${NEW_ADDRESS_ID}    ${new_address_id}

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

Close Browser With Failure Screenshot
    Run Keyword If Test Failed    Take Screenshot
    Close Browser