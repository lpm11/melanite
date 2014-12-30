#!/bin/env python
# -*- coding: utf-8 -*-
import re

# single line comment.
"""
Here is multiple line comment.
"""

class ClassA:
    def __init__(self, arg1, arg2=1, arg3=None):
        self.value = arg1 + arg2
        if (arg3 is not None):
            self.value += arg3

class ClassB(ClassA):
    def __init__(self):
        super(ClassB, self).__init__(1, 2, 3)

    def function(self):
        return 6


var = ClassB()
print(str(var.value))

if (not (var.value == var.function())):
    raise

if (re.search(r"^m([itlane]+e)$", "melanite")):
    print("matched")

try:
    x = 1 / 0
except ZeroDivisionError as e:
    print(e)
