# rosidl_typesupport_coredds
Typesupport package which generates interfaces used by `rmw_coredds`.

## Requirements
This project requires CoreDDS to be built. You can get trial version of CoreDDS [here](http://www.gurum.cc/?page_id=2150).
To use this, extract the archive to `~/coredds` or any directory you want. After that, move your `coredds.lic` file to where you extracted the archive and set the environment variable `COREDDS_LICENSE_PATH` to your `coredds.lic` file. For example, if you extracted the archive to `~/coredds`, it should be `COREDDS_LICENSE_PATH=~/coredds/coredds.lic`.

## Packages
This project consists of three packages, `coredds_cmake_module`, `rosidl_typesupport_coredds_c`, and `rosidl_typesupport_coredds_cpp`.

### coredds_cmake_module
`coredds_cmake_module` looks for CoreDDS, and provides the information to other packages.  
For `coredds_cmake_module` to work properly, you need to set `COREDDS_HOME` environment variable to where CoreDDS is located.  
For example, if you set `COREDDS_HOME=~/coredds`, the directory `~/coredds` should look like this:
```
coredds
├── coredds.lic
├── coredds.yaml
├── examples
│   └── ...
├── include
│   ├── dds
│   │   ├── dcps.h
│   │   ├── dcpsx.h
│   │   └── typesupport.h
│   └── ddsxml
│       └── ddsxml.h
├── lib
│   └── libdds.so
├── Makefile
└── tool
    └── coreidl
```

### rosidl_typesupport_coredds_c and rosidl_typesupport_coredds_cpp
`rosidl_typesupport_coredds_c` and `rosidl_typesupport_coredds_cpp` generate C and C++ interfaces using CoreIDL, the preprocessor. These interfaces are used by `rmw_coredds`. For more information, see README.md of the [project](https://github.com/gurumnet/rmw_coredds)

## Branches
There are three branches in this project: master, dashing, and crystal.  
New changes made in [ROS2 repository](https://github.com/ros2) will be applied to the mater branch, so this branch might be unstable.
If you want to use this project with ROS2 Dashing Diademata or Crystal Clemmys, please use dashing or crystal branch.

## Implementation Status
Currently some features are not fully implemented.
- WString: `rosidl_typesupport_coredds` converts wstring to string using `std::wstring_convert` so communicating with another rmw implementation may not work as intended.
