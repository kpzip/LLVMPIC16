add_llvm_component_library(LLVMPIC16Desc
  PIC16MCAsmInfo.cpp
  PIC16MCTargetDesc.cpp
  PIC16InstPrinter.cpp

  LINK_COMPONENTS
  MC
  PIC16Info
  Support
  TargetParser

  ADD_TO_COMPONENT
  PIC16
)

add_dependencies(LLVMPIC16Desc PIC16CommonTableGen)