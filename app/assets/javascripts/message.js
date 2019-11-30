

$(function(){
  function buildHTML(message){
      var addImage = (message.image !== null) ? `<img class = "message__text__image", src="${message.image}">` : ''; 
  
      var html = `<div class="message">
                    <div class="message__upper-info">
                      <div class="message__upper-info__talker">
                        ${message.user_name}
                      </div>
                      <div class="message__upper-info__date">
                        ${message.message_time}
                      </div>
                    </div>
                    <div class="message__text">
                      <p class="message__text__body">
                        ${message.message_body}
                      </p>
                    <div class='message__text__image'>
                      ${addImage}
                    </div>
                  </div>
                </div>` 
    return html;
  }
  $('#message-form').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url, 
      type: 'POST',  
      data: formData,  
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data); // buildHTMLで送られてきたdataを元にclassに追加するためのHTMLを作成。
      $(".messages").append(html);
      $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight});
      $('#message-form')[0].reset();
      $('.form__submit').prop('disabled', false);
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
    })
  })
})

