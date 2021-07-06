# YouTube: Robot Framework Beginner Tutorial 5 | How to create First Robot Test
#          Robot Framework Beginner Tutorial 6 | First Selenium Test
#          Robot Framework Beginner Tutorial 7 | Sample Selenium Login Test
#          Robot Framework Beginner Tutorial 8 | Variables
#          Robot Framework Beginner Tutorial 9 | Keywords
#          Robot Framework Beginner Tutorial 10 | Setup And Teardown
#          Robot Framework Beginner Tutorial 11 | TAGS
#          Robot Framework Beginner Tutorial 12 | How to run from CommandLine
#          Robot Framework Beginner Tutorial 13 | GIT
# By: Automation Step by Step

# Robot Documentation
# https://robotframework.org/

# Command Line
# E:\ProgrammingTutorialsYouTube\Eclipse_2021\RobotProject1>robot test\TestSuite1.robot
# E:\ProgrammingTutorialsYouTube\Eclipse_2021\RobotProject1>robot -t FirstRobotTest test\TestSuite1.robot
# E:\ProgrammingTutorialsYouTube\Eclipse_2021\RobotProject1>robot -t FirstRobotTest -t FirstSeleniumTest test\TestSuite1.robot

# Command Line - Set tags
# E:\ProgrammingTutorialsYouTube\Eclipse_2021\RobotProject1>robot -t FirstSeleniumTest --settag=regression1 test\TestSuite1.robot

# Command Line - Run tests with tags
# E:\ProgrammingTutorialsYouTube\Eclipse_2021\RobotProject1>robot --include smoke test\TestSuite1.robot
# E:\ProgrammingTutorialsYouTube\Eclipse_2021\RobotProject1>robot -i sanity -i smoke test\TestSuite1.robot
# E:\ProgrammingTutorialsYouTube\Eclipse_2021\RobotProject1>robot -i s* test\TestSuite1.robot

# Command Line - Run tests with excluding tags
# E:\ProgrammingTutorialsYouTube\Eclipse_2021\RobotProject1>robot --exclude smoke test\TestSuite1.robot
# E:\ProgrammingTutorialsYouTube\Eclipse_2021\RobotProject1>robot -e smoke test\TestSuite1.robot

# Command Line - Run tests with combination of including and excluding tags
# E:\ProgrammingTutorialsYouTube\Eclipse_2021\RobotProject1>robot --include sanity --exclude smoke test\TestSuite1.robot
# E:\ProgrammingTutorialsYouTube\Eclipse_2021\RobotProject1>robot -i sanity -e smoke test\TestSuite1.robot

*** Settings ***
Library    SeleniumLibrary    

Suite Setup       TestSuiteSetup
Suite Teardown    TestSuiteTeardown

Test Setup        TestSetup
Test Teardown     TestTeardown

Default Tags    sanity

*** Variables ***
# Scalar
${URL}            https://opensource-demo.orangehrmlive.com/
# List
@{CREDENTIALS}    Admin             admin123
# Dictionary
&{LOGINDATA}      username=Admin    password=admin123

*** Keywords ***
# User
LoginKW
    Input Text                   id=txtUsername        ${CREDENTIALS}[0]
    Input Text                   id=txtPassword        ${LOGINDATA.password}
    Click Button                 id=btnLogin

TestSuiteSetup
    Log    I am inside Test Suite Setup
    
TestSetup
    Log    I am inside Test Setup

TestSuiteTeardown
    Log    I am inside Test Suite Teardown
    
TestTeardown
    Log    I am inside Test Teardown
    
*** Test Cases ***
FirstRobotTest
    [Tags]    smoke
    Log       Hello World...
    
FirstSeleniumTest
    Open Browser                 https://google.com    chrome
    Set Browser Implicit Wait    5
    Input Text                   name=q                Automation step by step
    Press Keys                   name=q                ENTER
    Sleep                        2    
    Close Browser
    Log                          Test Completed
    Set Tags                     regression1
    Remove Tags                  regression1

SecondSeleniumTest
    Log    I am inside second selenium test

SampleLoginTest1
    [Documentation]    This is a sample login test
    Open Browser                 ${URL}                chrome
    Set Browser Implicit Wait    5
    Input Text                   id=txtUsername        ${CREDENTIALS}[0]
    Input Text                   id=txtPassword        ${LOGINDATA.password}
    Click Button                 id=btnLogin
    Sleep                        2
    Click Element                id=welcome
    Sleep                        2
    Click Element                link=Logout           
    Close Browser
    Log                          Test Completed
    Log                          Test was executed by %{username}

SampleLoginTest2
    [Documentation]    This is an updated sample login test
    Open Browser                 ${URL}                chrome
    Set Browser Implicit Wait    5
    LoginKW
    Sleep                        2
    Click Element                id=welcome
    Sleep                        2
    Click Element                link=Logout           
    Close Browser
    Log                          Test Completed
    Log                          Test was executed by %{username}