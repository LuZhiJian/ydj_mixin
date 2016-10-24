var locals = {
    root_path: '../../',

    list: function(startNum, endNum) {
        var a = [];
        for(var i = startNum; i <= endNum; i++) {
            a.push(i);
        }
        return a;
    }
};

module.exports = locals;
