*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
Library           String
Library           OperatingSystem
Library           Process
Library           FakerLibrary

*** Variables ***
${SERVER}         https://automationinterface1.front.staging.optimy.net/en/
${BROWSER}        chrome
${DELAY}          1
${USER}           optimyautomationtester@gmail.com
${PASSWORD}       yRMhojb7
${FileName}       Attachment.png



*** Keywords ***
Open Application in Browser
    Open Browser    ${SERVER}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Allow All cookies
    Click Button    Allow all cookies

Login As User
    Login to MyAccount
    Input Username
    Input Password
    Click Login

Login to MyAccount
    Click Link    Login

Input Username
    Input Text    login-email    ${USER}

Input Password
    Input Text    login-password    ${PASSWORD}

Click Login
    Click Button    Login

Submit a new application
    Click Element               css:a[href="project/new/"]
    Click Element               css:a[href="/en/project/new/controller.php?formId=33094353-3668-5272-97bc-592d0380a9c7&force"]

Fill-Out Required Field
    ${FirstName}    FakerLibrary.First Name
    ${LastName}     FakerLibrary.Last Name
    ${Address}      FakerLibrary.Address
    ${Objective}    FakerLibrary.Words
    Input Text      css:input[aria-label='First name']                   ${FirstName}
    Input Text      css:input[aria-label='Last name']                    ${LastName}
    Input Text      css:textarea[aria-label="Unit no/House no, Street"]   ${Address}
    Input Text      css:input[aria-label="Select postal code"]    1000
    Sleep           1
    Click Element   css:a#ui-id-2
    Select From List By Value    css:select[aria-label="Country"]    PH
    Choose File                  css:input[name="Filedata"]   ${CURDIR}\\${FileName}
    Click Element                css:label[aria-label="Male"]
    #Select Radio Button    4ea18d95-3478-5541-8a78-fca9336f03f5    f3fa11a5-a516-5cec-9025-b940b1b113d0
    Select From List By Index    css:select[class="custom-select"]    2
    #Select Checkbox   css:label[aria-label="Spreadsheet"] input
    Click Element                css:label[aria-label="Spreadsheet"] div[class="custom-control-label radio-checkbox-li-element-label"]
    Select Frame                 css:[class="cke_wysiwyg_frame cke_reset"]
    Scroll Element Into View     css:html[dir="ltr"] 
    Input Text                   css:body[class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders"]      ${Objective}  
    Unselect Frame
    Click Button                 navButtonNext
    Set Suite Variable           ${FirstName}
    Set Suite Variable           ${LastName}
    Set Suite Variable           ${Address}
    Set Suite Variable           ${Objective}
       
Verify Values in Summary Page
    Sleep    5
    Element Should Contain     css:div#container_629d7b5a-f6a1-5a14-ac1d-21b2fafdbdef div    ${FirstName}    Incorrect First Name    ${True}
    Element Should Contain     css:div#container_23e5e47e-bab1-5a1e-9929-f180182bda43 div    ${LastName}     Incorrect Last Name     ${True}
    Element Should Contain     css:div#container_c3f44a2e-72e9-587b-b88c-b5c9fbeed2db        ${Address}      Incorrect Address       ${True}
    Element Should Contain     css:div#container_d370f504-7ff5-509f-babb-d80126387290 a      ${FileName}     Incorrect File Name     ${True}
    Element Should Contain     css:li#container_f3fa11a5-a516-5cec-9025-b940b1b113d0         Male            Incorrect Gender        ${True}
    Element Should Contain     css:div#container_f801d7d8-0762-5407-95f9-b8c3a793157c div p  Automation tester   Incorrect Position     ${True}
    Element Should Contain     css:ul#field_9f5a0b89-6465-5ca8-8a51-11074944b998 li          Spreadsheet         Incorrect Skill        ${True}
    Element Should Contain     css:div#container_91296806-02e6-5bb5-bac0-deb4cbf64a64 div p  ${Objective}        Incorrect Objective    ${True}

Click Validate and Send
    Click Button        css:div[class="d-none d-md-flex justify-content-between align-items-center"] button#submitButton

Validate Thank You Page
    Sleep    5
    Element Should Contain    css:h1[class='h1 text-center']    Thank you for submitting your project 
