#!/bin/zsh

swift create-xcframework \
  --platform ios \
  --output ./Frameworks \
  --xc-setting ENABLE_TESTABILITY=FALSE \
  yuli_ios \
  ComposableRequest \
  ComposableStorage \
  ComposableStorageCrypto \
  KeychainAccess \
  SwCrypt \
  Swiftagram \
  SwiftagramCrypto
