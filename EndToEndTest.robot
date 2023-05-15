*** Settings ***
Documentation    To validate the login form
Library           SeleniumLibrary
Library         Collections
Library    ../customLibraries/Shop.py
Test Setup      oepn the browser with url
Test Teardown    Close Browser Session
Resource        ../PO/generic.robot
Resource    ../PO/LandingPage.robot
Resource    ../PO/ShopPage.robot
Resource    ../PO/CheckoutPage.robot
Resource    ../PO/ConfirmationPage.robot
#selenium
*** Variables ***
@{listofproduct}=   Samsung Note 8  Nokia Edge
${country}=     India

*** Test Cases ***
Vaidate UnSucccesful Login
    [Tags]          SMOKE
    LandingPage.Fill the login form       ${username}        ${invalid_pass}
    LandingPage.Wait until it check and display error message
    LandingPage.Verify error messsage is correct

Validate cards display in the shoping page
    [Tags]          REGRESSION
    LandingPage.Fill The Login Form     ${username}       ${valid_password}
    ShopPage.Wait Until Element Is Visible in page
    ShopPage.verify card titles shop in page
    Add Items To Cart And Checkout        ${listofproduct}
    ShopPage.wait for few minutes
    CheckoutPage.Verify items in checkout page and procced  ${listofproduct}
    ConfirmationPage.Select the country and terms conditions     ${country}
    ConfirmationPage.Purchase the product and confirm the purchase