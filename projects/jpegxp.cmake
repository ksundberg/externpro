########################################
# jpegxp
# http://packages.debian.org/sid/libjpeg-dev
# http://libjpeg6b.sourcearchive.com/
# http://libjpeg8.sourcearchive.com/
xpProOption(jpegxp)
set(REPO https://github.com/smanders/jpegxp)
set(PRO_JPEGXP
  NAME jpegxp
  WEB "jpegxp" http://www.ijg.org/ "Independent JPEG Group website"
  LICENSE "open" https://github.com/smanders/libjpeg/blob/upstream/README "libjpeg: see LEGAL ISSUES, in README (no specific license mentioned)"
  DESC "JPEG codec with mods for Lossless, 12-bit lossy (XP)"
  REPO "repo" ${REPO} "jpegxp repo on github"
  VER 15.06.03 # latest sdljxp branch commit date
  GIT_ORIGIN git://github.com/smanders/jpegxp.git
  GIT_TAG sdljxp # what to 'git checkout'
  GIT_REF jxp.130220 # create patch from this tag to 'git checkout'
  PATCH ${PATCH_DIR}/jpegxp.patch
  DIFF ${REPO}/compare/
  )
########################################
function(mkpatch_jpegxp)
  xpRepo(${PRO_JPEGXP})
endfunction()
########################################
function(patch_jpegxp)
  xpPatch(${PRO_JPEGXP})
endfunction()
########################################
function(build_jpegxp)
  if(NOT (XP_DEFAULT OR XP_PRO_JPEGXP))
    return()
  endif()
  configure_file(${PRO_DIR}/use/usexp-jpegxp-config.cmake ${STAGE_DIR}/share/cmake/
    @ONLY NEWLINE_STYLE LF
    )
  set(XP_DEPS jpeglossy8 jpeglossy12 jpeglossless)
  xpCmakeBuild(jpegxp "${XP_DEPS}")
endfunction()
