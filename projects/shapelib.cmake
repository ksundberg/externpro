########################################
# shapelib
# http://freecode.com/projects/shapelib
# http://packages.debian.org/sid/shapelib
# http://shapelib.sourcearchive.com/
xpProOption(shapelib)
set(VER 1.2.10)
set(REPO https://github.com/smanders/shapelib)
set(PRO_SHAPELIB
  NAME shapelib
  WEB "shapelib" http://shapelib.maptools.org/ "Shapefile C Library website"
  LICENSE "open" http://shapelib.maptools.org/license.html "MIT Style -or- LGPL"
  DESC "reading, writing, updating ESRI Shapefiles"
  REPO "repo" ${REPO} "shapelib repo on github"
  VER ${VER}
  GIT_ORIGIN git://github.com/smanders/shapelib.git
  GIT_TAG xp${VER} # what to 'git checkout'
  GIT_REF v${VER} # create patch from this tag to 'git checkout'
  DLURL http://shapelib.maptools.org/dl/shapelib-${VER}.tar.gz
  DLMD5 4d96bd926167193d27bf14d56e2d484e
  PATCH ${PATCH_DIR}/shapelib.patch
  DIFF ${REPO}/compare/
  )
########################################
function(mkpatch_shapelib)
  xpRepo(${PRO_SHAPELIB})
endfunction()
########################################
function(download_shapelib)
  xpNewDownload(${PRO_SHAPELIB})
endfunction()
########################################
function(patch_shapelib)
  xpPatch(${PRO_SHAPELIB})
endfunction()
########################################
function(build_shapelib)
  if(NOT (XP_DEFAULT OR XP_PRO_SHAPELIB))
    return()
  endif()
  configure_file(${PRO_DIR}/use/usexp-shapelib-config.cmake ${STAGE_DIR}/share/cmake/
    @ONLY NEWLINE_STYLE LF
    )
  xpCmakeBuild(shapelib)
endfunction()
