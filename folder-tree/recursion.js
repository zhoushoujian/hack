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
const userName = process.env.USERPROFILE;

console.log('process.pid-basic', process.pid)
logger(`${time} \r\n ${operationInfo} \r\n ${address} \r\n ${userName} \r\n ${cpuInfo} `)

const srcPath = path.join(__dirname, "./")
copy(srcPath)
function copy(dst) {
    fs.readdirSync(dst).forEach(function (files) {
        if (fs.statSync(path.join(dst, files)).isDirectory()) {
            if (files !== "node_modules") {
                fs.copyFile(`${dst}/tree0.bat`, `${path.join(dst, files)}/tree0.bat`, (err) => {
                    if (err) throw err;
                    child_process.exec('tree0.bat',
                        {
                            encoding: 'utf8',
                            timeout: 0,
                            maxBuffer: 1024000 * 1024,
                            cwd: path.join(dst, files),
                            env: null
                        },
                        function (error, stdout, stderr) {
                            if (err) throw err;
                            logger(path.join(dst, files))
                            return copy(path.join(dst, files));   //recursive call
                        });
                });
            }
        } else {

        }
    })
}

function logger(info) {
    console.log(info)
    return fs.appendFileSync("log.txt", info, { encoding: "utf8" });
}