#Set variables
export CMAKE_VERSION=4.2.1
export MPFR_VERSION=4.2.1
export PREFIX=/usr/local
#Enter home directory
cd home

#Clone CADO-NFS GitHub
git clone https://github.com/cado-nfs/cado-nfs.git

#Install build tools
apt-get update
apt-get install -y build-essential cmake libgmp-dev libmpfr-dev libmpc-dev libboost-all-dev

#Remove default cmake
apt remove cmake -y

#Download cmake version $CMAKE_VERSION
wget https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/cmake-$CMAKE_VERSION.tar.gz

#Extract files
tar zxvf cmake-$CMAKE_VERSION.tar.gz

#Build cmake using bootstrap
cd cmake-$CMAKE_VERSION
sudo ./bootstrap


#Run make
sudo make
sudo make install

#Back to home
cd /home

#Install g++ 10
sudo apt install g++-10 -y

#Configure update alternatives
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 40
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 60
sudo update-alternatives --config g++

#Python pip and venv install
apt update
apt install -y python3-venv python3-pip

#Download and build MPFR
wget https://www.mpfr.org/mpfr-$MPFR_VERSION/mpfr-$MPFR_VERSION.tar.gz
tar -xzf mpfr-$MPFR_VERSION.tar.gz
cd mpfr-$MPFR_VERSION
./configure --prefix=/usr/local
make -j$(nproc)
make install
ldconfig

#Install mysql
sudo apt install mysql-server -y

#Start mysql service
sudo /usr/sbin/mysqld &

#cd cado-nfs folder
cd /home/cado-nfs
#create venv and activate
python3 -m venv cado-nfs.venv
source cado-nfs.venv/bin/activate

#Run venv setup script
bash ./scripts/setup-venv.sh

#Remove build directory if it exists
rm -rf build
#Run make
make -j$(nproc)






