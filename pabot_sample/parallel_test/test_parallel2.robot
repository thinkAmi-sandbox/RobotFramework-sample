*** Settings ***
Library  pabot.PabotLib
Library  DateTime


*** Keywords ***
${timing}時刻を出力する
    ${start} =  Get Current Date  result_format=datetime
    Log To Console  ${\n}${timing}：${start}


*** TestCases ***
並行処理テスト
    開始時刻を出力する
    終了時刻を出力する
