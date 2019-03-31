---
title: "Up and Running with Swift for Tensorflow on Ubuntu 18.04 LTS Bionic Beaver"
date: 2019-03-31T10:52:52+05:30
draft: true
---

This blog post will guide through the process of install **Swift for Tensorflow** on Ubuntu 18.04 (Local Machine/VM instance) and Start Coding with **Swift** on the **Jupyter Notebook** like you do in **Python for Tensorflow**.

### Step 01: Installing CUDA
There are several versions of Swift-TF available to install as you prefer. Namely (on 30th March 2019), CPU only version, CUDA 9.2 version and CUDA 10.0 version. This section is only focused on with CUDA installation. You can skip to the next step if you prefer CPU only installation.
<br/>
<br/>
If you have been working on Tensorflow or PyTorch, CUDA might be installed on your ubuntu machine. You can check the installed CUDA version using the below commmand
```console
(base) vkartz@ubuntu-dl:~$ nvcc --version
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2018 NVIDIA Corporation
Built on Sat_Aug_25_21:08:01_CDT_2018
Cuda compilation tools, release 10.0, V10.0.130
```
In my case, CUDA v10.0 is installed on my machine
<br/>
**If you have v9.2 or v10.0 installed, You can go to the next step :smiley:**
<br/>
But sometimes you might get a response like below after executing the above command,
```console
(base) vkartz@ubuntu-dl:~$ nvcc --version
Command 'nvcc' not found, but can be installed with:
apt install nvidia-cuda-toolkit
Please ask your administrator.
```
* This error have two possibilities: 
  1. Your machine **have CUDA installed** but Environment variable is not set.
  2. Your machine **do not have CUDA installed**.

_If Case #1 (Env variable is not set) :_ <br/>
Use the below command to locate your cuda installation on your machine
```console
(base) vkartz@ubuntu-dl:~$ locate cuda | grep /cuda$
/home/vkartz/anaconda3/pkgs/pytorch-1.0.1-py3.7_cuda10.0.130_cudnn7.4.2_2/lib/python3.7/site-packages/
torch/lib/include/ATen/cuda
/home/vkartz/anaconda3/pkgs/pytorch-1.0.1-py3.7_cuda10.0.130_cudnn7.4.2_2/lib/python3.7/site-packages/
torch/lib/include/c10/cuda
/home/vkartz/anaconda3/pkgs/pytorch-1.0.1-py3.7_cuda10.0.130_cudnn7.4.2_2/lib/python3.7/site-packages/
torch/lib/include/torch/csrc/cuda
/usr/local/cuda
/usr/local/cuda-10.0/targets/x86_64-linux/include/thrust/system/cuda
```
**/usr/local/cuda** is the installation location of my machine. <br/>
After you finding the installed location of CUDA, Then Go to **[location]/bin** and run the below command
```console
(base) vkartz@ubuntu-dl:~$ cd /usr/local/cuda/bin/ 
(base) vkartz@ubuntu-dl:/usr/local/cuda/bin$ ./nvcc --version
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2018 NVIDIA Corporation
Built on Sat_Aug_25_21:08:01_CDT_2018
Cuda compilation tools, release 10.0, V10.0.130
```
**If this went fine, You can go to the next step :smiley:** <br/><br/>
_If Case #2 (CUDA not installed) :_ <br/>
To install CUDA on your machine properly, Go to [Tensorflow CUDA installation GUIDE](https://www.tensorflow.org/install/gpu#install_cuda_with_apt) and follow their instructions on CUDA v10.0 installation.<br/>
**If this went fine, You can go to the next step :smiley:** <br/><br/>

### Step 02: Installing Swift for Tensorflow
You can follow the *[Installation Guide](https://github.com/tensorflow/swift/blob/master/Installation.md#installation-1) on docs to install **but,**<br/>
*According to my experience during the process, I suggest to follow below **Modified** steps which will help you in later steps and clean installation.<br/>

* Go to your home directory.

```console
(base) vkartz@ubuntu-dl:~$
```
* Run below command to install required dependencies.

```console
(base) vkartz@ubuntu-dl:~$ sudo apt-get install clang libpython-dev libblocksruntime-dev
```
* Visit Swift for Tensorflow Installation page on GitHub to [download the latest binary release](https://github.com/tensorflow/swift/blob/master/Installation.md#releases) which is compatible with your CUDA version.
Downloaded file looks like <br>_swift-tensorflow-RELEASE-0.2-cuda10.0-cudnn7-ubuntu18.04.tar_
* Then create a directory on your home directory called **swift-toolchain** and extract the downloaded file to that directory. This will create ```~/swift-toolchain/usr``` directory 

```console
(base) vkartz@ubuntu-dl:~$ mkdir swift-toolchain
(base) vkartz@ubuntu-dl:~$ tar -C swift-toolchain -xzf swift-tensorflow-RELEASE-0.2-cuda10.0-cudnn7-ubuntu18.04.tar.gz
```
* To check whether the installation completed. Go ```~/swift-toolchain/usr/bin``` directory and run ```./swift``` REPL like below.

```console
(base) vkartz@ubuntu-dl:~$ cd ~/swift-toolchain/usr/bin
(base) vkartz@ubuntu-dl:~/swift-toolchain/usr/bin$ ./swift
Welcome to Swift version 5.0-dev (LLVM dcb9eb74a7, Clang 95cdf7c9af, Swift 434442b530).
Type :help for assistance.
  1> print("Hello world")
Hello world
  2>
```
**If above steps went fine, You successfully installed swift and you can go to the next step :smiley:** <br/><br/>