defmodule PodBot.SlackUtilities do
  def private_conversation?(message) do
    String.starts_with?(message.channel, "D")
  end

  def mentioned?(message, slack) do
    String.contains?(safe_access_text(message), mention_string(slack))
  end

  def safe_access_text(message) do
    if is_nil(message[:text]) do
      ""
    else
      message[:text]
    end
  end

  def mention_string(slack) do
    "<@#{slack.me.id}>"
  end
end
