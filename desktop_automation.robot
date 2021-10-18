*** Settings ***
Library  RPA.Desktop
Library  RPA.Excel.Files
Library  OcrLibrary.py

# +
*** Keywords ***
Start Application
    ${app1}=    RPA.Desktop.Open Application    C:\\Users\\91836\\Desktop\\TrainingOrderSystem.exe
    LOG  ${app1}
    Sleep  5
    ${username_ele}=    Find Element    alias:username
    LOG  ${username_ele}
    ${region1}=    Move Region    ${username_ele}    left=-20    top=0
    Type Text Into    locator=${region1}   text=admin    clear=True
    Press Keys    tab
    Type Text    admin
    Click    locator=alias:SignIn
    Sleep  2
    ${status}=    Run Keyword And Return Status    Find Element    alias:go_btn
    [Return]  ${status}    ${app1}

Quit My Application
    [Arguments]  ${app}
    Close Application  ${app}

Navigate To New Order
    Sleep  2
    Type Text Into    locator=alias:option_num    text=1    clear=True
    Click    alias:go_btn
    Sleep  2
    ${status}=    Run Keyword And Return Status    Find Element    alias:submit_order
    [Return]  ${status}

Create New Order
    [Arguments]  ${ProductCode}  ${NumberRequired}  ${UnitPrice}  ${CostCentre}
    Sleep    5
    ${productCode_ele}=    Find Element    alias:product_code
    LOG  ${productCode_ele}
    Click With Offset    locator=${productCode_ele}    x=20
    Type Text    ${ProductCode}
    Press Keys    tab
    Type Text    ${NumberRequired}
    Press Keys    tab
    Type Text    ${UnitPrice}
    Press Keys    tab
    Type Text    ${CostCentre}
    Sleep  2
    ${totalPrice_ele}=    Find Element    alias:totalPrice
    LOG  ${totalPrice_ele}
    ${region}=    Resize Region    ${totalPrice_ele}    right=100
    Take Screenshot   path=total_price.png  locator=${region}
    ${total_amt}=    Read Text    ${region}
    LOG  ${total_amt}
    ${total_price_custom}=  Read Text From Image  total_price.png  Total price
    LOG  ${total_price_custom}
    Click    alias:submit_order
    Sleep  5
    ${region_ref_num}=   Find Element    alias:ref_num
    LOG  ${region_ref_num}
    ${region_ref_num_resized}=    Resize Region  ${region_ref_num}    right=50
    Take Screenshot   path=ref_num.png  locator=${region_ref_num_resized}
    ${ref_num}=    Read Text    locator=${region_ref_num_resized}
    LOG  ${ref_num}
    ${ref_num_custom}=  Read Text From Image  ref_num.png  :
    LOG  ${ref_num_custom}
    Sleep  1
    Click    alias:continue_btn
    [Return]  ${total_price_custom}  ${ref_num_custom}
    

Read Product Data
    [Arguments]  ${filepath}
    Open Workbook    ${filepath}
    ${data}=  Read Worksheet As Table  name=Product  header=True
    Close Workbook
    LOG  ${data}
    [Return]  ${data}
    
    
    
    
    
    
# -


