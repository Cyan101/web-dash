function update_memory(){
var req = new XMLHttpRequest();
req.open('GET', '/update/memory', false);   
req.send(null);  
if(req.status == 200) {  
   var info = req.responseText;
   document.getElementById("memory").innerHTML = info;
   }
}

function update_cpu(){
var req = new XMLHttpRequest();
req.open('GET', '/update/cpu', false);   
req.send(null);  
if(req.status == 200) {  
   var info = req.responseText;
   document.getElementById("cpu").innerHTML = info;
   }
}

function update_top(){
var req = new XMLHttpRequest();
req.open('GET', '/update/top', false);   
req.send(null);  
if(req.status == 200) {  
   var info = req.responseText;
   document.getElementById("top").innerHTML = info;
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
  update_memory();
  update_cpu();
  update_bar("cpu");
  update_bar("memory");
  update_top();
 }

setInterval(update_page, 4000);
