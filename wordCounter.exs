defmodule WordCounter do
    def count_words_in_file do
        # ask for the file name
        IO.puts("Please enter the file name:")
        file_name = IO.gets("> ") |> String.trim()

        # read the file content
        case File.read(file_name) do
        {:ok, content} ->
            # split the content into words using a regular expression
            words = String.split(content, ~r/\W+/)

            # filter out non-words
            words = Enum.filter(words, fn word -> word != "" end)

            # count the words
            word_count = Enum.count(words)

            IO.puts("the file contains #{word_count} words")

        {:error, reason} ->
            IO.puts("Error: #{reason}")
        end
    end
end

WordCounter.count_words_in_file()
