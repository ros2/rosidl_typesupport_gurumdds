# rosidl_typesupport_gurumdds
Typesupport package which generates interfaces used by `rmw_gurumdds`.

## Requirements
This project requires GurumDDS to be built. You can get trial version of GurumDDS [here](http://www.gurum.cc/?page_id=2150).
To use this, extract the archive to `~/gurumdds` or any directory you want. After that, move your `gurumdds.lic` file to where you extracted the archive and set the environment variable `GURUMDDS_LICENSE_PATH` to your `gurumdds.lic` file. For example, if you extracted the archive to `~/gurumdds`, it should be `GURUMDDS_LICENSE_PATH=~/gurumdds/gurumdds.lic`.

## Packages
This project consists of three packages, `gurumdds_cmake_module`, `rosidl_typesupport_gurumdds_c`, and `rosidl_typesupport_gurumdds_cpp`.

### gurumdds_cmake_module
`gurumdds_cmake_module` looks for GurumDDS, and provides the information to other packages.  
For `gurumdds_cmake_module` to work properly, you need to set `GURUMDDS_HOME` environment variable to where GurumDDS is located.  
For example, if you set `GURUMDDS_HOME=~/gurumdds`, the directory `~/gurumdds` should look like this:
```
gurumdds
├── gurumdds.lic
├── gurumdds.yaml
├── examples
│   └── ...
├── include
│   └── gurumdds
│       ├── dcps.h
│       ├── dcpsx.h
│       ├── typesupport.h
│       └── xml.h
├── lib
│   └── libgurumdds.so
├── Makefile
└── tool
    └── gurumidl
```

### rosidl_typesupport_gurumdds_c and rosidl_typesupport_gurumdds_cpp(deprecated)
~~`rosidl_typesupport_gurumdds_c` and `rosidl_typesupport_gurumdds_cpp` generate C and C++ interfaces using GurumIDL, the preprocessor. These interfaces are used by `rmw_gurumdds`. For more information, see README.md of the [project](https://github.com/ros2/rmw_gurumdds)~~

## Branches
There are four active branches in this project: master, humble, galactic and foxy.
New changes made in [ROS2 repository](https://github.com/ros2) will be applied to the master branch, so this branch might be unstable.
If you want to use this project with ROS2 Humble Hawksbill, Galactic Geochelone or Foxy Fitzroy, please use humble, galactic or foxy branch, respectively.
