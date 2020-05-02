from setuptools import setup, find_packages

with open("requirements.txt") as requirements_file:
    requirements = requirements_file.read().splitlines()

setup(
    name='test_harness',
    version='1.0.0',
    description='Basic Calculator SDK',
    author='Varun Nandu',
    author_email='varunnandu1992@gmail.com',
    python_requires=">=3.6.0",
    packages=find_packages(exclude='tests'),
    install_requires=requirements,
    test_suite='tests',
)