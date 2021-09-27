class DocumentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "documents"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
