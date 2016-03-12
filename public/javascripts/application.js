$(function(){

	if(document.getElementById("body")!=undefined){
      $('#body').editable({inlineMode: false, alwaysBlank: true})
	}

	$("#login_submit").click(function(e){
  		e.preventDefault();
  		var email = $("#email").val(),
  			password = $("#password").val(),
  			token = $("input[name='authenticity_token']").val();
  		$.ajax({
  			url:"/login",
  			type: "POST",
        	data: {'email':email,'password':password,'authenticity_token':token},
        	datatype:'json',
        	success: function (data){
            	if(data.result==1){
            		window.location.reload();
            	}else{
            		$(".alert-danger").show();
            		setTimeout(function(){$(".alert-danger").hide();},2000);
            	}
        	},
        	error: function(data) {
            	console.log("error:"+data.responseText);
        	}
  		});
  	});	

   
});
		