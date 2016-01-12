/**
 * 在指定的元素中显示年份选择列表.
 * 
 * @param Element
 *             calendarDiv 必需. 显示年份列表的元素.
 * @param String
 *             selectedYear 必需. 已选中年份,格式yyyy.
 * @param String
 *             url 必需. 数据加载地址,选择年份后从该地址重新加载数据.
 * @param String
 *             paras 可选. 重新加载数据时传递到服务器的参数,如'name1=value1&name2=value2'.
 * @param String
 *             startYear 可选. 起始年份,可以选择的最早年份,默认2015年.
 * @param String
 *             drawYear 可选. 可以选择的第一个年份,默认2015年.
 * 
 * @requires jQuery,Bootstrap
 */
function drawYearCalendar(calendarDiv, selectedYear, url, paras, startYear, drawYear) {
    var now = new Date();
    if(now.getDate() > 25){
        now.setDate(26);
        now.setMonth(now.getMonth()+1);
    }
    var currentYear = now.getFullYear();
    
	var yearCalendar = $(calendarDiv);
    yearCalendar.empty();
    
    if(paras !== undefined && paras.length > 0) {
        paras = "&" + paras;
    } else {
        paras = "";
    }
    
    if(startYear === undefined) {
        startYear = 2015;
    }
    
    if(drawYear === undefined) {
        drawYear = 2015;
    }
    
    // 上一组年份列表切换按钮
    var item = $("<button type='button' class='btn btn-info btn-sm'></button>");
    item.append("<<");
    if(drawYear > startYear){
        item.click(function(){ drawYearCalendar(calendarDiv, selectedYear, url, paras, startYear, drawYear-10); });
    }
    yearCalendar.append(item);
    
    var yearNum = currentYear-drawYear;
    if(yearNum > 9) {
        yearNum = 9;
    }
    
    // 可选的年份列表
    for(var i=0; i <= yearNum; i++){
        var item = $("<button type='button' class='btn btn-info btn-sm'></button>");
        item.append((drawYear+i)+"年");
        item.click(function(){
            window.location = url + "?year="+$(this).text().substring(0,4) + paras;
        });
        
        if((drawYear+i) == selectedYear){
            item.addClass("active");
        }
        yearCalendar.append(item);
    }
    
    // 下一组年份列表切换按钮
    if(drawYear+9 < currentYear){
        var item = $("<button type='button' class='btn btn-info btn-sm'></button>");
        item.append(">>");
        item.click(function(){ drawYearCalendar(calendarDiv, selectedYear, url, paras, startYear, drawYear+10); });
        yearCalendar.append(item);
    }
}

/**
 * 在指定的元素中显示月份选择列表.
 * 
 * @param Element
 *             calendarDiv 必需. 显示月份列表的元素.
 * @param String
 *             selectedMonth 必需. 已选中月份,格式yyyyMM.
 * @param String
 *             url 必需. 数据加载地址,选择月份后从该地址重新加载数据.
 * @param String
 *             paras 可选. 重新加载数据时传递到服务器的参数键值对,如'name1=value1&name2=value2'.
 * @param String
 *             startYear 可选. 起始年份,可以选择的最早年份,默认2015年.
 * @param String
 *             drawYear 可选. 显示年份,当前显示哪一年的月份列表,默认显示已选中月份所属年的月份列表.
 * 
 * @requires jQuery,Bootstrap
 */
function drawMonthCalendar(calendarDiv, selectedMonth, url, paras, startYear, drawYear) {
    var now = new Date();
    if(now.getDate() > 25){
        now.setDate(26);
        now.setMonth(now.getMonth()+1);
    }
    var currentYear = now.getFullYear();
	var currentMonth = now.getMonth() + 1;
    
	var monthCalendar = $(calendarDiv);
    monthCalendar.empty();
    
    if(paras !== undefined && paras.length > 0) {
        paras = "&" + paras;
    } else {
        paras = "";
    }
    
    if(startYear === undefined) {
        startYear = 2015;
    }
    
    if(drawYear === undefined) {
        drawYear = parseInt(selectedMonth.substring(0,4));
    } else {
        drawYear = parseInt(drawYear);
    }
    
    // 上一年月份列表切换按钮
    var item = $("<button type='button' class='btn btn-info btn-sm'></button>");
    item.append("<<");
    if(drawYear > startYear){
        item.click(function(){ drawMonthCalendar(calendarDiv, selectedMonth, url, paras, startYear, drawYear-1); });
    }
    monthCalendar.append(item);
    
    var monthNum = 12;
    if(drawYear == currentYear){
        monthNum = currentMonth;
    }
    
    // 可选的月份列表
    for(var i=1; i <= monthNum; i++){
        var drawMonth = drawYear+"-"+(i < 10 ? "0":"")+i;
        var item = $("<button type='button' class='btn btn-info btn-sm'></button>");
        item.append(drawMonth);
        item.click(function(){
            window.location = url + "?month="+$(this).text().replace("-","") + paras;
        });
        
        if(drawMonth.replace("-","") == selectedMonth){
            item.addClass("active");
        }
        monthCalendar.append(item);
    }
    
    // 下一年月份列表切换按钮
    if(drawYear < currentYear){
        var item = $("<button type='button' class='btn btn-info btn-sm'></button>");
        item.append(">>");
        item.click(function(){ drawMonthCalendar(calendarDiv, selectedMonth, url, paras, startYear, drawYear+1); });
        monthCalendar.append(item);
    }
}
