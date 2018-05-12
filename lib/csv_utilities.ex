defmodule CsvUtilities do
  @csv_file_name "data/data.csv"

  def write_to_csv(timestamp, user, message) do
    file = File.open!(@csv_file_name, [:append, :utf8])

    [[DateTime.to_iso8601(timestamp), user, message]]
    |> CSV.encode()
    |> Enum.each(&IO.write(file, &1))
  end

  def read_from_csv do
    File.read!(@csv_file_name)
  end
end
