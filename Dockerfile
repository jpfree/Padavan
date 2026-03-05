name: Padavan Docker Build

on:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-22.04

    steps:
    - name: Checkout
      uses: actions/checkout@v4

    - name: Build Docker image
      run: docker build -t padavan-docker .

    - name: Start container with tmate
      run: |
        docker run -d --name padavan \
          -v ${{ github.workspace }}:/opt/padavan \
          -w /opt/padavan \
          padavan-docker tail -f /dev/null

    - name: SSH into container
      uses: mxschmitt/action-tmate@v3
      with:
        limit-access-to-actor: true
        ssh-command: docker exec -it padavan bash

    - name: Build firmware inside Docker
      run: |
        docker exec padavan bash -c "
          cd trunk &&
          fakeroot ./build_firmware_modify YK-L1
        "

    - name: Upload firmware
      uses: actions/upload-artifact@v4
      with:
        name: firmware-YK-L1
        path: trunk/images/*.trx
