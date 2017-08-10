*** Settings ***

Library  DateTime


*** Keywords ***
現在時刻を出力する
    [Arguments]  ${label}=start
    ${now} =  get current date
    log to console  ${now}${SPACE * 3}[${label}]


*** TestCases ***
引数の秒数のフォーマットを確認する
    log to console  ${SPACE}

    現在時刻を出力する

    sleep  1 seconds
    現在時刻を出力する  label=seconds

    sleep  1 second
    現在時刻を出力する  label=second

    sleep  1 secs
    現在時刻を出力する  label=secs

    sleep  1 sec
    現在時刻を出力する  label=sec

    sleep  1 s
    現在時刻を出力する  label=s

    sleep  1sec
    現在時刻を出力する  label=sec_without_space

    sleep  1s
    現在時刻を出力する  label=s_without_space

    sleep  1.5s
    現在時刻を出力する  label=s_with_dot
