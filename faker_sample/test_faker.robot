*** Settings ***
Library  FakerLibrary  locale=ja_JP


*** Test Cases ***
個人のフェイクデータを作成する
    # "FakerLibrary" というプレフィックスがなくても動作する
    ${address} =  FakerLibrary.Address
    ${city} =  FakerLibrary.City
    ${first_name} =  FakerLibrary.First Name
    ${last_name} =  FakerLibrary.Last Name
    ${name} =  FakerLibrary.Name

    Log To Console  ${\n}${address}${\n}${city}${\n}${first_name}${\n}${last_name}${\n}${name}

    ${email} =  FakerLibrary.Email
    ${tel} =  FakerLibrary.Phone Number

    # special_chars, digits, upper_case, lower_case の設定も可能
    ${password} =  FakerLibrary.Password  length=15
    # 郵便番号と思われるが、5桁しかでてこない
    ${postcode} =  FakerLibrary.Postcode
    # ドキュメントにはないが、Zipcodeを使えば日本の郵便番号になる
    ${zipcode} =  FakerLibrary.Zipcode

    Log To Console  ${\n}${email}${\n}${password}${\n}${tel}${\n}${postcode}${\n}${zipcode}


会社のフェイクデータを作成する
    ${company} =  FakerLibrary.Company
    ${email} =  FakerLibrary.Company Email

    # サフィックスはIncであり、(株)などではない
    ${suffix} =  FakerLibrary.Company Suffix

    Log To Console  ${\n}${company}${\n}${email}${\n}${suffix}


適当な文を作成する
    ${paragraph} =  FakerLibrary.Paragraph
    Log To Console  ${paragraph}
