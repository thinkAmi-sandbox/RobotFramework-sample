*** Settings ***
Library  pabot.PabotLib
Library  DateTime


*** Keywords ***
${timing}時刻を出力する
    ${start} =  Get Current Date  result_format=datetime
    Log To Console  ${\n}${timing}：${start}


*** TestCases ***
ハローワールドする
    ${valueset_name} =  Acquire Value Set
    開始時刻を出力する

    ${hello} =  Get Value From Set  hello
    Log To Console  ${hello}

    Release Value Set
    終了時刻を出力する
