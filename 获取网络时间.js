function loadPage(url) {
    var http = require('http');
    var pm = new Promise(function (resolve, reject) {
        http.get(url, function (res) {
            var html = '';
            res.on('data', function (d) {
                html += d.toString()
            });
            res.on('end', function () {
                resolve(html);
            });
        }).on('error', function (e) {
            reject(e)
        });
    });
    return pm;
}
loadPage('http://time.tianqi.com/').then(function (d) {
    console.log(d.match(/北京现在时间：.+。查世界各大城市时差/gim)[0].toString().slice(7,26));
    //require('fs').appendFileSync("./html.txt", d, 'utf8')
});
