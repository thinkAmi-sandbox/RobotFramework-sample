# Robot Frameworkからインスタンス変数・クラス変数を扱うためには、ファイル名と同じにする必要がある
class variable_file_class:
    class_val = 'python'

    def __init__(self):
        self.instance_val = 'self val'


instance_from_class = variable_file_class()


class diff_variable_file:
    diff_class_val = 'diff class'

    def __init__(self):
        self.diff_instance_val = 'self diff val'
