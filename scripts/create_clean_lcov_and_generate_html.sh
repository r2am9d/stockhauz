#!/bin/bash
if [ "$#" -eq  "0" ]
    then
        echo 'Project package name is required.'
        exit 1
    else
        set -e
        sh scripts/import_files_coverage.sh $1
        flutter test --coverage
        lcov -r coverage/lcov.info \
        'lib\app.dart' \
        'lib\main_*.dart' \
        'lib\*\*.g.dart' \
        'lib\*\*.freezed.dart' \
        'lib\*\*.gen.dart' \
        'lib\src\pages\*' \
        'lib\src\utils\*' \
        -o coverage/lcov.info
        genhtml coverage/lcov.info -o coverage/html
        start coverage/html/index.html
fi
