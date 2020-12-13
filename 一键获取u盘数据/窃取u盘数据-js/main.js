//解决无法读取u盘根目录的问题
//使用dir命令，控制台显示乱码
//接收端一定要关闭防火墙,用于接收远端传来的数据
//开启防火墙的命令 sc sconfig MpsSvc start= auto    sc cstart MpsSvc
//若对方要传输过来的文件名和自己仓库里的文件名相同，则不进行传输
//execFile调用命令行传参的时候一定要把要传入的变量写在后面

//加载控制台颜色
{
  let colors = {
    Reset: "\x1b[0m",
    FgRed: "\x1b[31m",
    FgGreen: "\x1b[32m",
    FgYellow: "\x1b[33m",
    FgBlue: "\x1b[34m"
  };
  var length = 0;
  "info::FgGreen,warn: 警告:FgYellow,error: error:FgRed".split(",").forEach(function (logcolor) {
    var [log, info, color] = logcolor.split(':');
    var logger = function (...args) {
      var message = args.join(" ");
      process.stdout.write("\b \b".repeat(length) + message);
      length = message.length;
    } || console[log] || console.log;
    console[log] = (...args) => logger.apply(null, [`${colors.Reset}${colors[color]}${info}`, ...args,colors.Reset]);
  });
}

//轮询并读取u盘内容
let {
  exec,
  execFile,
  execSync
} = require("child_process"),
  path = require("path"),
  fs = require("fs");
let iconv = require('iconv-lite');
let encoding = 'cp936';
let binaryEncoding = 'binary';
let child;
let timer = setInterval(function () {
  //时间函数
  function getTime() {
    let year = new Date().getFullYear(),
      month = new Date().getMonth() + 1,
      day = new Date().getDate(),
      hour = new Date().getHours(),
      minute = new Date().getMinutes(),
      second = new Date().getSeconds(),
      mileSecond = new Date().getMilliseconds();
    if (hour < 10) {
      hour = "0" + hour
    }
    if (minute < 10) {
      minute = "0" + minute
    }
    if (second < 10) {
      second = "0" + second
    }
    if (mileSecond < 10) {
      second = "00" + mileSecond
    }
    if (mileSecond < 100) {
      second = "0" + mileSecond
    }
    time = `${year}-${month}-${day} ${hour}:${minute}:${second}.${mileSecond}`; //获取时间信息
    return time;
  }
  child = exec(path.join(__dirname, "getUDiskName.exe"), {
    encoding: binaryEncoding,
    timeout: 0,
    maxBuffer: 1024 * 1024,
    cwd: null,
    env: null
  });
  child.stdout.on("data", function (data) {
    try {
      if (iconv.decode(new Buffer(data, binaryEncoding), encoding) === "ECHO 处于关闭状态。") console.info("ECHO 处于关闭状态。");
      execFile(path.join(__dirname, "getUDiskFiles.exe"), [data], {
        encoding: binaryEncoding,
        timeout: 0,
        maxBuffer: 1024 * 1024,
        cwd: null,
        env: null
      }, function (err, stdout, stderr) {
        if (err) {
          console.log("\n U disk not found")
          return;
        }
        let result;
        if (stderr) {
          console.warn("获取u盘文件时发生了异常：", iconv.decode(new Buffer(stderr, binaryEncoding), encoding))
        }
        // execSync(`(net start|find "Windows Firewall" >nul)&&(net stop MpsSvc>nul&sc config MpsSvc start= disabled>nul)||((sc qc mpssvc|find /i "START_TYPE"|find /i "DISABLED">nul)||sc config MpsSvc start= disabled)`,{
        //   encoding: binaryEncoding
        // })
        console.info(`[${getTime()}]  child stdout => 发现u盘 => 盘符为`, iconv.decode(new Buffer(data, binaryEncoding), encoding));
        result = (iconv.decode(new Buffer(stdout, binaryEncoding), encoding));
        let result_array = result.split("\r\n");
        console.info(`[${getTime()}]  发现u盘的文件总数量`, result_array.length);
        if (result_array.length) {
          clearInterval(timer);
        }
        for (let i = 0, l = result_array.length; i < l; i++) {
          if (!result_array[i]) continue;
          if (fs.statSync(result_array[i]).isFile()) {
            let filename = result_array[i].split("\\")[result_array[i].split("\\").length - 1];
            console.log(`[${getTime()}] filename`, filename)
            exec(`net use \\\\192.168.1.107\\ipc$ "789" /user:zhou`, {
              encoding: binaryEncoding
            }, function (err, stdout, stderr) {
              console.info(`[${getTime()}] net use stdout`, iconv.decode(new Buffer(stdout, binaryEncoding), encoding));
              exec(`xcopy ${result_array[i]} \\\\192.168.1.107\\C$\\test /D /Y /k`, {
                encoding: binaryEncoding
              }, function (err, stdout, stderr) {
                console.log(`[${getTime()}] result_array[${i}]`, result_array[i]);
                console.info(`[${getTime()}] xcopy stdout`, iconv.decode(new Buffer(stdout, binaryEncoding), encoding));
              })
            })
          }
        }
      });
    } catch (e) {
      console.error("e", e)
    }
  });
  child.stderr.on("data", function (data) {
    console.warn(`[${getTime()}]  child stderr`, data)
  });
  child.on("exit", function (code) {
    if (code) {
      console.error(`[${getTime()}]  child exit code`, code);
    } else {
      console.info(`[${getTime()}]  child exit code`, code);
    }
  })
}, 2500)