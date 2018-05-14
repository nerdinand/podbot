defmodule PodBot do
  use Slack

  def handle_connect(slack, state) do
    IO.puts("Connected as #{slack.me.name}")
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    cond do
      PodBot.SlackUtilities.mentioned?(message, slack) ->
        handle_mentioned(message, slack, state)

      PodBot.SlackUtilities.private_conversation?(message) ->
        handle_private(message, slack, state)

      true ->
        {:ok, state}
    end
  end

  def handle_event(_message, _slack, state) do
    {:ok, state}
  end

  def handle_private(message, slack, state) do
    if String.contains?(PodBot.SlackUtilities.safe_access_text(message), "magic word") do
      links = PodBot.DataUtilities.read() |> Enum.map(&thing/1) |> Enum.join("\n")
      send_message("```#{links}```", message.channel, slack)
    end

    {:ok, state}
  end

  def thing(link) do
    "#{link.username}, #{link.timestamp}, #{link.link}"
  end

  def handle_mentioned(message, slack, state) do
    message_content =
      message.text
      |> String.replace("#{PodBot.SlackUtilities.mention_string(slack)} ", "")
      |> String.trim_leading("<")
      |> String.trim_trailing(">")

    user_name = lookup_user_name(message.user, slack)

    timestamp =
      message.ts
      |> String.to_float()
      |> Kernel.trunc()
      |> DateTime.from_unix!()

    PodBot.DataUtilities.write(timestamp, user_name, message_content)

    {:ok, state}
  end

  def handle_info(_, _, state), do: {:ok, state}
end
