"""
Test fixtures to share across tests.

Reference the name of the fixture as an argument in the test. For example,

def test_my_class(my_class_obj):
    ...
"""
import os
import pytest
import sys

# Needed if not running tests through scripts that define PYTHONPATH
sys.path.insert(1, os.path.join(sys.path[0], ".."))
from src.my_class import MyClass


@pytest.fixture(scope = "session")
def my_class_obj():
    return MyClass()

