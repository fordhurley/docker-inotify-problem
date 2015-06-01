#!/bin/bash

set -e

TIMEOUT=20

echo "Before:"
ls -l
echo

echo "Waiting $TIMEOUT seconds for a change..."
if inotifywait --timeout $TIMEOUT . ; then
    echo "inotifywait detected a change!"
else
    echo "Timed out waiting for change."
fi

echo
echo "After:"
ls -l
