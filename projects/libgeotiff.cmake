########################################
# libgeotiff
xpProOption(libgeotiff)
# http://packages.debian.org/sid/libgeotiff-dev
# http://libgeotiff-dfsg.sourcearchive.com/
set(VER 1.2.4)
set(REPO https://github.com/smanders/libgeotiff)
set(PRO_LIBGEOTIFF
  NAME libgeotiff
  WEB "libgeotiff" http://trac.osgeo.org/geotiff/ "GeoTIFF trac website"
  LICENSE "open" http://trac.osgeo.org/geotiff/ "trac site states it is an open source library (no specific license mentioned)"
  DESC "georeferencing info embedded within TIFF file"
  REPO "repo" ${REPO} "libgeotiff repo on github"
  VER ${VER}
  GIT_ORIGIN git://github.com/smanders/libgeotiff.git
  GIT_TAG xp${VER} # what to 'git checkout'
  GIT_REF v${VER} # create patch from this tag to 'git checkout'
  #DLURL http://libgeotiff-dfsg.sourcearchive.com/downloads/${VER}/libgeotiff-dfsg_${VER}.orig.tar.gz
  #DLMD5 35dca74146d6168bc5adcf3495d7546c
  # NOTE: version 1.2.4 appears to be no longer available to download
  # from sourcearchive.com (26 byte invalid file)
  DLURL ${REPO}/archive/v${VER}.tar.gz
  DLMD5 4bef0cc5f066a5f3c0b2352f39bbf140
  DLNAME libgeotiff-v${VER}.tar.gz
  PATCH ${PATCH_DIR}/libgeotiff.patch
  DIFF ${REPO}/compare/
  )
########################################
function(mkpatch_libgeotiff)
  xpRepo(${PRO_LIBGEOTIFF})
endfunction()
########################################
function(download_libgeotiff)
  xpNewDownload(${PRO_LIBGEOTIFF})
endfunction()
########################################
function(patch_libgeotiff)
  xpPatch(${PRO_LIBGEOTIFF})
endfunction()
########################################
function(build_libgeotiff)
  if(NOT (XP_DEFAULT OR XP_PRO_LIBGEOTIFF))
    return()
  endif()
  if(NOT (XP_DEFAULT OR XP_PRO_WX))
    message(FATAL_ERROR "libgeotiff.cmake: requires wx")
  endif()
  set(wxver 30) # specify the wx version to build libgeotiff against
  if(NOT TARGET wx${wxver}_stage_hdrs)
    build_wx()
  endif()
  ExternalProject_Get_Property(wx${wxver}_stage_hdrs INSTALL_DIR)
  ExternalProject_Get_Property(wx${wxver}_stage_hdrs SOURCE_DIR)
  set(XP_CONFIGURE
    -DWX_INCLUDE:PATH=${INSTALL_DIR}
    -DWX_SOURCE:PATH=${SOURCE_DIR}
    )
  configure_file(${PRO_DIR}/use/usexp-geotiff-config.cmake ${STAGE_DIR}/share/cmake/
    @ONLY NEWLINE_STYLE LF
    )
  xpCmakeBuild(libgeotiff wx${wxver}_stage_hdrs "${XP_CONFIGURE}")
endfunction()
