cmake_minimum_required(VERSION 3.28)
project(tada VERSION 0.1.0 LANGUAGES C CXX ASM)

set(FLTK_USE_SYSTEM_LIBPNG OFF CACHE BOOL " " FORCE)
set(FLTK_USE_SYSTEM_LIBJPEG OFF CACHE BOOL " " FORCE)
set(FLTK_USE_SYSTEM_ZLIB OFF CACHE BOOL " " FORCE)
set(CFLTK_USE_OPENGL OFF CACHE BOOL " " FORCE)
set(FLTK_BUILD_EXAMPLES OFF CACHE BOOL " " FORCE)
set(FLTK_BUILD_TEST OFF CACHE BOOL " " FORCE)
set(OPTION_LARGE_FILE ON CACHE BOOL " " FORCE)
set(FLTK_BUILD_HTML_DOCS OFF CACHE BOOL " " FORCE)
set(FLTK_BUILD_PDF_DOCS OFF CACHE BOOL " " FORCE)
set(FLTK_BUILD_FLUID OFF CACHE BOOL " " FORCE)
set(FLTK_BUILD_FLTK_OPTIONS OFF CACHE BOOL " " FORCE)

include(FetchContent)

FetchContent_Declare(
  cfltk
  GIT_REPOSITORY https://github.com/MoAlyousef/cfltk.git
  GIT_TAG        1.5.18
  GIT_SHALLOW    TRUE
)
FetchContent_MakeAvailable(cfltk)

add_executable(tada)
target_sources(tada PRIVATE
  src/main.S
)
target_link_libraries(tada PRIVATE cfltk fltk::fltk fltk::gl fltk::images)
