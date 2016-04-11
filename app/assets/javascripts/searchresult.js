function init(){
  page = new Page();
}

function Page(listlength){
  this.rowCount = listlength;
  k = listlength%10;
  if(k == 0){
    this.pageCount = listlength/10;
  }
  else{
    this.pageCount = listlength/10 + 1;
  }

  this.currentPage = 1;   //initial current_page is default at 1
}

Page.updateData = funtion(){
  var j = this.currentPage;
  var str="";
  str +="<% i= "+(j)+"%> ";
  str +="<% @results[i..i+9].each do |book| %>";
  document.getElementById("loopshow").innerHTML = str;
  return this.currentPage;
}

Page.nextPage = function(){
  if(this.currentPage + 1 <= this.pageCount){
    this.currentPage += 1;
    this.updateData();
  }
}

Page.prePage = function(){
  if(this.currentPage >= 2){
    this.currentPage -= 1;
    this.updateData();
  }
}
