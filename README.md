# rtmp-streaming-server build script
A rtmp streaming server build script for nginx/tengine/openResty.

# System requirement:

1. Debian/Ubuntu
2. CentOS
3. freeBSD

# Usage:

```
#Ubuntu/Debian
sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev
#Centos
yum -y install gcc gcc-c++ make zlib-devel pcre-devel openssl-devel
#FreeBSD
pkg install PCRE
sudo bash ./build.sh
```
