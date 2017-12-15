*** Settings ***
Library  pabot.PabotLib
Library  DateTime


*** Keywords ***
${timing}時刻を出力する
    ${start} =  Get Current Date  result_format=datetime
    Log To Console  ${\n}${timing}：${start}


*** TestCases ***

ロック待ちをするテスト
    Acquire Lock   MyLock1
    開始時刻を出力する
    sleep  5s
    終了時刻を出力する
    Release Lock   MyLock1
