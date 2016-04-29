var pusher = new Pusher('fc4ded0fd159951bdc56', {
  encrypted: true
});

var channel = pusher.subscribe('test_channel');
channel.bind('my_event', function(data) {
  console.log(data.coms);
  document.getElementById("comment_list").innerHTML = "<%= render 'comment_list'%>";
});


// var pusher = new Pusher('5e157d0652d97d9fa6d4');
// var channel = pusher.subscribe('formdemo_channel');
// channel.bind('comment_event', function(data) {
// 	var elt_id = 'comment-count-'+data.item_id;
// 	document.getElementById(elt_id).innerHTML = data.count;
// });
