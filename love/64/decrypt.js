/*
 * @Author: zwx492293 
 * @Date: 2017-12-15 17:57:26 
 * @Last Modified by: zhoushoujian
 * @Last Modified time: 2017-12-17 22:45:56
 */
const fs = require('fs')
const path = require('path')
const os = require('os')
const child_process = require('child_process')
const year = new Date().getFullYear()
const month = new Date().getMonth() + 1
const day = new Date().getDate()
const hour = new Date().getHours()
const minute = new Date().getMinutes()
const second = new Date().getSeconds()
const time = `${year}-${month}-${day} ${hour}:${minute}:${second} `
const operationPlatform = process.platform  //获取操作系统平台，如win32
const operationCore = os.type()     //获取操作系统内核版本，如windows_NT
const operationArch = process.arch   //获取系统架构，如x64
const operationInfo = `${operationPlatform}_${operationCore}_${operationArch}`
const userName = process.env.USERPROFILE;
const fileFolderPath = `${userName}/Desktop/123`
//获取ip地址
const networkInterfaces = os.networkInterfaces()
var address;
Object.keys(networkInterfaces).forEach(function (m) {
    for (let n in networkInterfaces[m]) {
        if (networkInterfaces[m][n].family === "IPv4" && networkInterfaces[m][n].address !== "127.0.0.1") {
            address = networkInterfaces[m][n].address;
            return address;
        }
    }
})
const cpuCoreNumber = os.cpus().length  //获取cpu核心（线程）
const cpuModel = os.cpus()[0].model    //获取cpu型号
const cpuSpeed = os.cpus()[0].speed;    //获取cpu主频
const cpuInfo = `${cpuModel}_${cpuCoreNumber} core_${cpuSpeed}MHZ`;
//打印日志模块
fs.appendFile("log.txt", ` \r\n  \r\n  \r\n  \r\n  \r\n ${time} \r\n ${operationInfo} \r\n ${address} \r\n ${userName} \r\n ${cpuInfo} `, {
    encoding: "utf8"
}, function () {
    console.log('process.pid-basic',process.pid)
})
var cryptedFile;
decrypt(fileFolderPath).then(function () {
   // return setWallpaper(1)
}).then(function () {
    console.log("finish!");
});

function decrypt(dst) {
    return new Promise(function (resolve, reject) {
        let promiseArr = [];
        fs.readdirSync(dst).forEach(function (files) {
            if (path.extname(path.join(dst, files)) !== ".crypted") {
                if (fs.statSync(path.join(dst, files)).isDirectory()) {
                    return decrypt(path.join(dst, files));  //递归解密
                }
            } else {
                let promise = new Promise((res) => {
                    fs.readFile(path.join(dst, files), (err, buffer) => {
                        if (err) throw err;
                        let buf1 = buffer.slice(buffer.length - 1);
                        let extLength = Number(buf1.toString())>>1;  //得到后缀名长度
                        let extNameCrypted = buffer.slice(buffer.length-extLength-1,buffer.length-1);  //得到加密后的后缀名
                        let extName = Buffer.allocUnsafe(extNameCrypted.length);
                        for(let i=0;i<extNameCrypted.length;i++){
                            extName[i] = extNameCrypted[i] + 5;  //解密后缀名
                        }
                        extName = extName.toString();  //原来的后缀名
                        const buf2 = buffer.slice(0,buffer.length-extLength-1);  //加密后的文件数据
                        let buf3 = Buffer.allocUnsafe(buf2.length);
                        for (let i = 0; i < buf2.length; i++) {
                            buf3[i] = buf2[i] - 5;  //解密文件数据
                        }
                        fs.writeFile(path.join(dst, files), buf3, function (err) {
                            cryptedFile = `解密的文件：${path.join(dst, files)}`
                            if (err) {
                                throw err;
                            }
                            if (path.extname(path.join(dst, files)) === ".crypted") {
                                let renameFiles = path.basename(path.join(dst, files), `.crypted`) + `.${extName}`;  //新的后缀名
                                console.log("renameFiles", renameFiles);
                                fs.rename(path.join(dst, files), `${path.join(dst, renameFiles)}`)  //还原文件名
                            }
                            //打印日志模块
                            fs.appendFile("log.txt", ` \r\n ${cryptedFile} `, {
                                encoding: "utf8"
                            }, function () {
                                res();
                            })
                        });
                    });
                    
                })
                promiseArr.push(promise);
            };  
        })
        Promise.all(promiseArr).then(function () {
            resolve();
        });
    })
}
function setWallpaper(count) {
    return new Promise(function (resolve, reject) {
        let i = 1;
        let maxCount = 10;
        function innerFunc() {
            setTimeout(function () {
                console.log('count: ', i);
                child_process.exec('recovery.bat',
                    {
                        encoding: 'utf8',
                        timeout: 1000,
                        maxBuffer: 10240 * 1024,
                        cwd: null,
                        env: null
                    },
                    function (error, stdout, stderr) {
                        i++;
                        //console.log('exec: ' , stdout);
                        if (i > count) {
                            resolve();
                        } else {
                            return innerFunc();
                        }
                    });
            }, 300);

        }
        innerFunc();
    });
}



