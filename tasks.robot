*** Settings ***
Documentation   Desktop Automation
Library    RPA.Excel.Files
Resource  ./desktop_automation.robot


*** Tasks ***
Main task
    ${status}    ${application}=    Start Application
    Run Keyword If  ${status}  Navigate To New Order
    ${table}=    Read Product Data  ./Data/ProductDetails.xlsx
    Open Workbook  ./Data/ProductDetails.xlsx
    Create Worksheet  name=Output
    FOR   ${row}    IN    @{table}
        ${total_price}    ${order_num}=    Create New Order  ${row}[ProductCode]  ${row}[NumberRequired]  ${row}[UnitPrice]  ${row}[CostCentre]
        ${new_row}=  Create Dictionary
        ...    ProductCode=${row}[ProductCode]
        ...    NumberRequired=${row}[NumberRequired]
        ...    UnitPrice=${row}[UnitPrice]
        ...    CostCentre=${row}[CostCentre]
        ...    TotalPrice=${total_price}
        ...    OrderNumber=${order_num}
        
        Sleep  5
        Click    image:.images\\image-go_btn2.png
        Sleep  5
        Append Rows To Worksheet  ${new_row}  header=True
        Save Workbook
    END
    Close Workbook
    [Teardown]  Quit My Application    ${application} 

