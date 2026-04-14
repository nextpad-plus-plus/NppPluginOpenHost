cmake_minimum_required(VERSION 3.20)
project(NppPluginOpenHost LANGUAGES CXX OBJCXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_OBJCXX_STANDARD 17)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64")
set(CMAKE_OSX_DEPLOYMENT_TARGET "11.0")

# Path to the Notepad++ macOS port for shared headers (Scintilla is vendored
# inside notepad-plus-plus-macos/scintilla since the v1.0.1 restructure).
set(NPP_MACOS_DIR "${CMAKE_SOURCE_DIR}/../../notepad-plus-plus-macos")
set(SCINTILLA_INCLUDE "${NPP_MACOS_DIR}/scintilla/include")
set(NPP_PLUGIN_INCLUDE "${NPP_MACOS_DIR}/src")

add_library(NppPluginOpenHost SHARED src/NppPluginOpenHost.mm)
target_include_directories(NppPluginOpenHost PRIVATE
    ${NPP_PLUGIN_INCLUDE}
    ${SCINTILLA_INCLUDE})
target_link_libraries(NppPluginOpenHost PRIVATE "-framework Cocoa")
set(PLUGIN_INSTALL_DIR "$ENV{HOME}/.notepad++/plugins/NppPluginOpenHost")
set_target_properties(NppPluginOpenHost PROPERTIES PREFIX "" SUFFIX ".dylib")
install(TARGETS NppPluginOpenHost DESTINATION "${PLUGIN_INSTALL_DIR}")
