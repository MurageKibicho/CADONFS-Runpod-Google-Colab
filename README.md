# Solving Discrete Logarithm Problems with CADO-NFS either on Google Colab or Runpod Cloud

CADO-NFS is the world’s best factoring and discrete logarithm problem (DLP) solver. However, the documentation is scarce.

These are my personal scripts to get CADO-NFS running on Google Colab or Runpod.

- Absolute beginners should follow the Google Colab notebook.
- 10x gigachad devs follow the Runpod/Local Ubuntu path.

The article [CADO-NFS DLP Comprehensive Tutorial](https://leetarxiv.substack.com/p/cado-nfs-dlp-comprehensive-tutorial) is an extremely deep guide to what each script does.

Outside Google Colab these are commmon errors encountered with CADO-NFS:
1. g++ version errors.
2. cmake version errors.
3. Python Flask venv errors.
4. Localhost 404's CADO-NFS errors.
5. Failed individual logarithm errors.
6. MySQL may be absent or turned off.
7. Distributed computing in the relation collection phase.

I demonstrate workarounds in the [CADO-NFS DLP article](https://leetarxiv.substack.com/p/cado-nfs-dlp-comprehensive-tutorial).

### Important note
The 256-bit bitcoin field characteristic prime takes:
- 1hr 20 minutes to generate logs on Google Colab.
- 40 minutes on Runpod and it costs 0.06$/hr for the 2core, 4GB RAM machine.
- 4 hours on my personal computer (fml)

## Getting Started
Absolute beginners should follow the Google Colab notebook. 

Non-noobs who want complete control should follow the Runpod/local installation approach.

### Local Installation / Runpod Approach
Do NOT clone the repo. The bash installation script may fail due to lots of subtle installation gotchas.

I suggest following the [step-by-step installation guide](https://leetarxiv.substack.com/p/cado-nfs-dlp-comprehensive-tutorial) but if you're feeling lucky then this works on Runpod:

It takes ~25 minutes for a clean Runpod installation.

1. Enter the home directory
```
cd /home
```
2. Download the raw installation bash script
```
wget https://raw.githubusercontent.com/MurageKibicho/CADONFS-Runpod-Google-Colab/refs/heads/main/InstallCADO_Runpod_Ubuntu.sh
```
3. Make `InstallCADO_Runpod_Ubuntu.sh` executable
```
chmod +x InstallCADO_Runpod_Ubuntu.sh
```
4. Run `InstallCADO_Runpod_Ubuntu.sh` executable
```
./InstallCADO_Runpod_Ubuntu.sh
```

The installation will pause during g++ installation. You need to key in 0 and press enter to proceed.

## Running a DLP Relation Collection Instance for Bitcoin's prime

1. Enter the cado-nfs directory
```
cd /home/cado-nfs
```
2. Activate the venv
```
source cado-nfs.venv/bin/activate
```
3. Download our sample parameters file
```
wget https://raw.githubusercontent.com/MurageKibicho/CADONFS-Runpod-Google-Colab/refs/heads/main/MurageKibicho_Bitcoin.params
```
4. You need to copy the inner folder name from the `build` directory.
```
#Enter build folder
cd build
#Check the folder name. I got 9f46df7e9cee
ls
```
5. Go back to the root cado-nfs folder and modify `MurageKibicho_Bitcoin.params`.
```
cd /home/cado-nfs
nano MurageKibicho_Bitcoin.params
```
You need to change the `builddir` line at the beginning to sth like `builddir= /home/cado-nfs/build/9f46df7e9cee`

6. If everything is working correctly then this command should start collecting relations
```
./cado-nfs.py -dlp --parameters MurageKibicho_Bitcoin.params --ell 205115282021455665897114700593932402728804164701536103180137503955397371
```

## Importing Logarithms







