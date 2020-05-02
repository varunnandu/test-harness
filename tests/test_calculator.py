from module import Calculator

c = Calculator()


def test_add():
    assert c.add(2, 3) == 5


def test_subtract():
    assert c.subtract(5, 2) == 3
