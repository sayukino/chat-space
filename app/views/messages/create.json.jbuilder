json.user_name  @message.user.name
json.message_time  @message.created_at.strftime("%Y/%m/%d %H:%M")
json.message_body  @message.body
json.image  @message.image.url

