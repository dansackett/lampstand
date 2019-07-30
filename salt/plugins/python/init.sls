Install Python3:
  pkg.installed:
    - name: python3-dev

Install old pip for Salt:
  pkg.installed:
    - name: python-pip

Install pip3:
  pkg.installed:
    - name: python3-pip
