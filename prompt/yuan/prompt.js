const child_process = require('child_process')
Exclamation(6,350).then(() => Information(3,300))
                  .then(() => Critical(5,200)).then(() => Exclamation(3,300))
                  .then(() => Information(2,250)).then(() => Critical(8,120))
                  .then(() => Critical(6,80)).then(() => Critical(5,50))
                  .then(() => Critical(6,30)).then(() => Critical(5,10))
                  .then(() => Exclamation(1,5000)).then(() => Information(1,250))
                  .then(() => Exclamation(1,250)).then(() => Information(1,250))
                  .then(() => Exclamation(4,250)).then(() => Information(4,50))
                  .then(() => Critical(1,250)).then(() => Critical(1,250))
                  .then(() => Critical(1,50)).then(() => Exclamation(3,100))
                  .then(() => Critical(3,80)).then(() => Information(3,100))
                  .then(() => Critical(3,80)).then(() => Exclamation(2,250))
                  .then(() => Information(2,250)).then(() => Exclamation(2,250))
                  .then(() => Information(2,250)).then(() => Exclamation(2,250))
                  .then(() => Information(1,200)).then(() => Exclamation(1,200))
                  .then(() => Information(1,150)).then(() => Exclamation(1,150))
                  .then(() => Information(1,120)).then(() => Exclamation(1,150))
                  .then(() => Information(1,100)).then(() => Exclamation(1,100))
                  .then(() => Information(1,70)).then(() => Exclamation(1,70))
                  .then(() => Information(1,50)).then(() => Exclamation(1,50))
                  .then(() => Critical(25,30)).then(() => Critical(3,100))
                  .then(() => Critical(8,180)).then(() => Critical(10,250))
                  .then(() => Critical(8,220)).then(() => Critical(8,280))
                  .then(() => Critical(18,300)).then(() => Critical(18,320))
                  .then(() => clear())

function Information(count,t){
        return new Promise(function(resolve,reject){
            let i=1;
            let maxCount=30;
            function innerFunc(){
                setTimeout(function(){
                    console.log('count: ' ,i);
                    child_process.exec('VbInformation.bat',
                    {
                        encoding: 'utf8',
                        timeout: 300, 
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
                },t);                 
            }
            innerFunc();		
    });  
}

function Exclamation(count,t){
    return new Promise(function(resolve,reject){
        let i=1;
        let maxCount=30;
        function innerFunc(){
            setTimeout(function(){
                console.log('count: ' ,i);
                child_process.exec('VbExclamation.bat',
                {
                    encoding: 'utf8',
                    timeout: 300, 
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
            },t);                 
        }
        innerFunc();		
});  
}

function Critical(count,t){
    return new Promise(function(resolve,reject){
        let i=1;
        let maxCount=30;
        function innerFunc(){
            setTimeout(function(){
                console.log('count: ' ,i);
                child_process.exec('VbCritical.bat',
                {
                    encoding: 'utf8',
                    timeout: 300, 
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
            },t);                 
        }
        innerFunc();		
});  
}

function clear(){
    return new Promise(function(resolve,reject){
                child_process.exec('clear.bat',
                {
                    encoding: 'utf8',
                    timeout: 300, 
                    maxBuffer: 10240 * 1024, 
                    cwd: null,
                    env: null
                },
                function (error, stdout, stderr) {
                        resolve(); 
                });
    })
}