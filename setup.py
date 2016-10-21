from setuptools import setup, find_packages

setup(name='minecraft-py3',
      version='0.0.1',
      description='Python3 bindings for Malmo',
      url='https://github.com/tambetm/minecraft-py3',
      author='Tambet Matiisen',
      author_email='tambet.matiisen@gmail.com',
      packages=find_packages(),
      include_package_data=True,
      zip_safe=False
)
