APK2Checkmarx
=============

Usage
-----

    git clone <repo>
    cd apk2cx
    mkdir apk
    docker build -t apk2cx .
    docker run --rm -v /path/to/your/target.apk:/home/cxjadx/apk \
        -e APKPATH="apk/target.apk" \
        -e CX_SERVER="https://checkmarx.local/" \
        -e CX_USER="foobar" \
        -e CX_PASSWORD="FOOBAR" \
        -e CX_TEAM="CxServer\\SP\\Foobar\\Baz" \
        -e CX_PROJECTNAME="FooProject-branch" \
        apk2cx:latest

