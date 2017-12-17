*** Settings ***
Documentation  一つのファイルで重複したテストケースを含むテスト

*** Test Cases ***
一つのファイルでテストケース名が重複
    Log To Console  foo

一つのファイルでテストケース名が重複
    Log To Console  bar
