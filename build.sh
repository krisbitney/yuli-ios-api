#!/bin/zsh

swift create-xcframework \
  --platform ios \
  --output ./Frameworks \
  --xc-setting ENABLE_TESTABILITY=FALSE \
  ComposableRequest \
  ComposableStorage \
  ComposableStorageCrypto \
  KeychainAccess \
  SwCrypt \
  Swiftagram \
  SwiftagramCrypto

# Refactor directories
#for arch in "ios-arm64" "ios-arm64_x86_64-simulator"; do
#  mkdir -p "./Frameworks/$arch/Frameworks"
#
#  for framework in yuli_ios ComposableRequest ComposableStorage ComposableStorageCrypto KeychainAccess SwCrypt Swiftagram SwiftagramCrypto; do
#    mv "./Frameworks/$framework.xcframework/$arch/$framework.framework" "./Frameworks/$arch/Frameworks/$framework.framework"
#  done
#done
#
#for framework in yuli_ios ComposableRequest ComposableStorage ComposableStorageCrypto KeychainAccess SwCrypt Swiftagram SwiftagramCrypto; do
#  rm -rf "./Frameworks/$framework.xcframework/"
#done