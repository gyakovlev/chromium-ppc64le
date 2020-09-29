# Chromium ppc64le overlay

based on patches found at https://github.com/chromium-ppc64le/chromium-ppc64le


#### This gentoo overlay contains lightly patched ebuild + patchset to compile and run chromium browser on ppc64le installations of gentoo linux running on Raptor Talos II/Blackbird machines

![building-chromium.png](https://github.com/gyakovlev/chromium-ppc64le/blob/master/metadata/building_chromium.png)

### Installation

- using wget
```sh
mkdir -p /etc/portage/repos.conf
wget  -O /etc/portage/repos.conf/chromium-ppc64le.conf https://raw.githubusercontent.com/gyakovlev/chromium-ppc64le/master/scripts/chromium-ppc64le.conf
```

- using curl
```sh
curl -Lo /etc/portage/repos.conf/chromium-ppc64le.conf --create-dirs https://raw.githubusercontent.com/gyakovlev/chromium-ppc64le/master/scripts/chromium-ppc64le.conf
```

- using layman
```sh
layman -o https://raw.githubusercontent.com/gyakovlev/chromium-ppc64le/master/repository.xml -L -a chromium-ppc64le
```

### Sync the repo

```sh
emaint sync -r chromium-ppc64le
```

### Install it

```sh
emerge chromium
```
