from rflint.common import KeywordRule, ERROR


class TooShortKeywordRule(KeywordRule):
    severity = ERROR

    def apply(self, keyword):
        if len(keyword.name) < 3:
            self.report(keyword, f'too short keyword name: {keyword.name}', keyword.linenumber)
