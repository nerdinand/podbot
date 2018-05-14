defmodule PodBot.DataUtilities do
  def write(timestamp, username, message) do
    link = %PodBot.Link{
      username: username,
      timestamp: timestamp,
      link: message
    }

    PodBot.Repo.insert(link)
  end

  def read do
    PodBot.Repo.all(PodBot.Link)
  end
end
