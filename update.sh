#!/usr/bin/env bash

dotnet new classlib -n SnapXDummyProj
cd SnapXDummyProj

../deps.sh

dotnet restore --packages ../packages

cd ..

nuget-to-json ./packages/ > ./deps.json

rm -rf packages/ SnapXDummyProj/
