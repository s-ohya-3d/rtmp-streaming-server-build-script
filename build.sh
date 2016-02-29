#!/bin/bash

# A rtmp-streaming-Server module for nginx/tengine/openResty.
# CopyRight: losywee@gmail.com
# Version: 0.1
# Support: Ubuntu/Centos/Debian/freeBSD etc.


base_dir=$(cd "$(dirname "$0")";pwd);

#You can change the version of nginx/tengine/openresty version.
nginxVer="1.8.0";
tengineVer="2.1.1";
openrstyVer="1.9.3.2";

nginxPkg="nginx-$nginxVer";
tenginePkg="tengine-$tengineVer";
openRestyPkg="ngx_openresty-$openrstyVer";
pkgEndRs=".tar.gz";

rtmpMdul="$base_dir/nginx-rtmp-module";
rtmpRepo="https://github.com/arut/nginx-rtmp-module";

#You can change the build path.
buildPath="/opt/local";

function extractPkg(){

	packageName=$1;
	tar -xvzf  "$packageName$pkgEndRs";

}

function buildType(){

	echo "1. Nginx-with-rtmp";
	echo "2. Tengine-with-rtmp";
	echo "3. Openresty-with-rtmp";
	echo "First: you must install PCRE library and wget";
	echo "---------------------------------------------------------------------------------";
	echo "CentOS: yum -y pcre-devel"
	echo "Ubuntu: apt-get install libpcre3 libpcre3-dev"
	echo "---------------------------------------------------------------------------------";
	echo "Author: losywee@gmail.com"
	echo "---------------------------------------------------------------------------------";
	echo "---------------------------------------------------------------------------------";
	echo "Please Select build type ( 1 2 3 ) >";
	read types;
	echo "You had entered: ( $types )"

	if [[ "$types"="1" ]] || [[ "$types"=" " ]]; then

		echo "Use  option ( $types )";
		curDir=$(cd "$base_dir/nginx-$nginxVer";pwd);
		#do build
		execBuild $nginxPkg;
	fi

	if [[ "$types"="2" ]]; then

		echo "Use  option ( $types )";
		curDir=$(cd "$base_dir/tengine-$tengineVer";pwd);
		#do build
		execBuild $tenginePkg;
	fi
	
	if [[ "$types"="3" ]]; then
		echo "Use  option ( $types )";
		curDir=$(cd "$base_dir/ngx_openresty-$openrstyVer";pwd);
		#do build
		execBuild $openRestyPkg;
	fi
}

function initEnv(){
	mkdir  "$buildPath";
	if [[ ! -f "$nginxPkg$pkgEndRs" ]]; then
		wget "http://nginx.org/download/$nginxPkg$pkgEndRs";
	fi
	if [[ ! -f "$tenginePkg$pkgEndRs" ]]; then
		wget "http://tengine.taobao.org/download/$tenginePkg$pkgEndRs";
	fi
	if [[ ! -f "$openRestyPkg$pkgEndRs" ]]; then
		wget "https://openresty.org/download/$openRestyPkg$pkgEndRs";
	fi

	if [[ ! -d "$rtmpMdul" ]]; then
		wget "$rtmpRepo/archive/master.tar.gz";
		tar -xvzf "master.tar.gz";
		mv nginx-rtmp-module-master nginx-rtmp-module;
	fi
}

function execBuild(){
	pkgname=$1;
           initEnv;
	extractPkg $pkgname;
	cd $pkgname;
           buildProgram;
}

function buildProgram(){
	./configure --prefix=$buildPath --add-module=$rtmpMdul;
	make && make install;
}

buildType;


