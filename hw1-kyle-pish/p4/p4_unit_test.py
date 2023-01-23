# Header
# Test out the functions in p4_lib.py
# Using the unittest library in Python's standard library

from p4_lib import date_is_before, days_in_month, date_plus, latest_date

import unittest


class LibTestCase(unittest.TestCase):
    def setUp(self):
        self.jan1 = (1, 1)
        self.jan2 = (1, 2)
        self.feb28 = (2, 28)
        self.dec1 = (12, 1)
        self.dec31 = (12, 31)

    def test_date_is_before(self):
        self.assertTrue(date_is_before(self.jan1, self.jan2))
        self.assertTrue(date_is_before(self.jan2, self.feb28))
        self.assertTrue(date_is_before(self.jan2, self.dec1))
        self.assertTrue(date_is_before(self.feb28, self.dec31))

    def test_days_in_month(self):
        self.assertEqual(days_in_month(1), 31)
        self.assertEqual(days_in_month(2), 28)
        self.assertEqual(days_in_month(12), 31)

    def test_date_plus(self):
        self.assertEqual(date_plus(self.jan1, 1), self.jan2)
        self.assertEqual(date_plus(self.feb28, 1), (3, 1))
        self.assertEqual(date_plus(self.dec31, 2), self.jan2)

    def test_latest_date(self):
        self.assertEqual(latest_date([self.jan1, self.jan2]), self.jan2)
        self.assertEqual(latest_date([self.feb28, self.jan1, self.jan2]), self.feb28)
        self.assertEqual(latest_date([self.jan1, self.feb28, self.dec31, self.jan2]), self.dec31)
        self.assertEqual(latest_date([self.jan1, self.feb28, self.dec1, self.jan2]), self.dec1)


if __name__ == '__main__':
    unittest.main()
