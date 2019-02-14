# packer-ami-fedora

## Choices
I Initially went with the kickstart-virtualbox-amazon import path. This would allow me build from scratch and control the end result very minutely.
I ended up going the ebs builder route for reasons listed under Pitfalls. 
ebs builder is much faster.

## Pitfalls
amazon import only supports much older kernels that are not supported by Fedora 29. For fedora only 19-21 is currently available due to kernel version.
amazon import since it is from scratch is much slower
The EBS builder route, needs an initial ami layer, this significantly increases footprint and attack vector.

## Usage
```bash
build-aws-ebs 
```
