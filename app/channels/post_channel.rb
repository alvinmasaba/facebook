class PostChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'post'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    def receive(data)
      data['user'] = current_user
      
      ActionCable.server.broadcast('post', data)
    end
  end
end
