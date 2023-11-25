#!/bin/bash

echo "----unzip file----"
pwd_path=`pwd`
start_file=$1
s_len_origin=${#start_file}
rsss=4
echo " sdsdadasda $s_len_origin "
s_len=`expr $s_len_origin - $rsss`
file_name=${start_file:0:s_len}

if [[ $1 == /* ]] ;then 
unzip_target=$file_name
else 
unzip_target=$pwd_path"/"$file_name
fi

echo " $unzip_target 长度 $file_name $s_len"
if [ -d $unzip_target ]; then
rm -r $unzip_target
fi

if [[ $1 == *.zip ]]; then
unzip $1 -d ./
fi

# echo "将 $1 目录下的压缩文件逐个解压，解压后存放到目录 $unzip_target 中"

# read

# if [ ! -d $unzip_target ]; then 
# mkdir -p $unzip_target 
# fi

function unzip_file(){
for file in `ls $file_name`
do
if [[ $file_name"/"$file == *.tar ]]; then 
tar -xvf $file_name"/"$file -C $unzip_target/
echo " 需要删除的文件名称 $file"
rm -r $file_name"/"$file
fi
if [[ $file_name"/"$file == *.tar.gz ]]; then 
tar -xzvf $file_name"/"$file -C $unzip_target/
echo " 需要删除的文件名称 $file"
rm -r $file_name"/"$file
fi
if [[ $file_name"/"$file == *.zip ]]; then 
unzip $file_name"/"$file -d $unzip_target/
echo " 需要删除的文件名称 $file"
rm -r $file_name"/"$file
fi
if [[ $file_name"/"$file == *.rar ]]; then 
unrar $unzip_target/ $file_name"/"$file
echo " 需要删除的文件名称 $file"
rm -r $file_name"/"$file
fi
done
}

unzip_file $file_name

cd $file_name
ls

echo "解压版本包完毕 开始处理 backend 的内容"
cd backend
ls

echo "将原始的conf配置放入 conf_origin_all"
mkdir conf_origin_all
mv conf/* conf_origin_all
rm -r conf

echo "移动 conf_sil 文件夹内部的文件到 conf 文件夹内部"
mkdir conf
mv conf_sil/* conf

echo "开始修改 conf_sil 文件中的内容"
cd conf/beu
ls

sed -i 's/localhost/10.50.20.42/g' PVD1.yml

sed -i '2 s/^/#/' passThrough.yml

cat passThrough.yml

read
