# 操作系统实战笔记

# 1. 构建基础景象

## 1.1 grub.cfg

```
menuentry 'HelloOS' {
insmod part_msdos
insmod ext2
set root='hd0,msdos1' #我们的硬盘只有一个分区所以是'hd0,msdos1'
multiboot2 /boot/HelloOS.eki #加载boot目录下的HelloOS.eki文件
boot #引导启动
}
set timeout_style=menu
if [ "${timeout}" = 0 ]; then
  set timeout=10 #等待10秒钟自动启动
fi
```

## 1.2 一键脚本 Makefile

```makefile
PHONY:all
OSNAME=HelloOS
IMGNAME=hd
LOOP=loop11
REMOTE=vm
REMOTE_DIR=/home/cal/code/os/cosmos/cal/cal2
all:
	make clean
	make create_os
	make build_os
build_os:
	scp ${REMOTE}:${REMOTE_DIR}/${IMGNAME}.img ./
	VBoxManage convertfromraw ./hd.img --format VDI ./${IMGNAME}.vdi
	VBoxManage storagectl ${OSNAME} --name "SATA" --add sata --controller IntelAhci --portcount 1
	VBoxManage closemedium disk ./${IMGNAME}.vdi
	VBoxManage storageattach ${OSNAME} --storagectl "SATA" --port 1 --device 0 --type hdd --medium ./${IMGNAME}.vdi
create_os:
	VBoxManage createvm --name ${OSNAME} --register
start:
	VBoxManage startvm ${OSNAME}
close:
	VBoxManage controlvm ${OSNAME} poweroff
clean:
	rm -rf ./hd.vdi
	rm -rf ./hd.img
	VBoxManage unregistervm --delete ${OSNAME}
doc:
	echo "https://cloud.tencent.com/developer/article/2030930"
	echo "https://blog.csdn.net/HandsomeHong/article/details/115418206"
build_remote:
	scp Makefile ${REMOTE}:${REMOTE_DIR}/ 
	scp grub.cfg ${REMOTE}:${REMOTE_DIR}
	ssh ${REMOTE} "make --file=${REMOTE_DIR}/Makefile remote"
remote:
	dd bs=512 if=/dev/zero of=${IMGNAME}.img count=204800
	sudo losetup /dev/${LOOP} ${IMGNAME}.img
	sudo mkfs.ext4 -q /dev/${LOOP}
	sudo mkdir ./hdisk
	sudo mount -o loop ./${IMGNAME}.img ./hdisk/
	sudo mkdir ./hdisk/boot/
	sudo grub-install --boot-directory=./hdisk/boot/ --force --allow-floppy /dev/${LOOP}
	sudo cp grub.cfg ./hdist/boot/grub/
```

