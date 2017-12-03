from selenium.webdriver import Chrome
from selenium.webdriver.common.keys import Keys
import unittest

class TestGoogle(unittest.TestCase):
    def test_GoogleでSeleniumLibraryを検索する(self):
        browser = Chrome()
        browser.get('https://google.co.jp')
        query_input = browser.find_element_by_name('q')
        query_input.send_keys('SeleniumLibrary' + Keys.ENTER)
        # 結果出力と検証
        links = browser.find_elements_by_css_selector('h3 > a')
        for link in links:
            print(link.text)
        self.assertEqual(len(links), 10)
        browser.quit()
