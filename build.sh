#!/bin/zsh

swift create-xcframework --platform ios --zip --xc-setting ENABLE_TESTABILITY=FALSE
