function update_stat(type){
var req = new XMLHttpRequest();
req.open('GET', '/update/' + type, false);   
req.send(null);  
if(req.status == 200) {  
   var info = req.responseText;
   document.getElementById(type).innerHTML = info;
   }
}

function update_bar(type){
var req = new XMLHttpRequest();
req.open('GET', '/update/bar-' + type, false);   
req.send(null);  
if(req.status == 200) {  
   var info = req.responseText;
   var bar = document.getElementById("bar-" + type);
   bar.style.width = info;
   }
}

function update_page(){
  update_bar("cpu");
  update_bar("memory");
  update_stat("top");
  update_stat("memory");
  update_stat("cpu");
 }

setInterval(update_page, 4000);
