defmodule WordCounterAdvanced do
  # Function to count words, lines, or characters in a file
  def count_words_in_file do
    # Prompt the user for the file name
    file_name = prompt_user("Please enter the file name: ")

    # Use `with` for cleaner file handling and resource cleanup
    with {:ok, content} <- File.read(file_name) do
      # Get the counting option from the user
      option = get_counting_option()

      # Count based on the chosen option
      count = count_based_on_option(option, content)

      # Print the result
      IO.puts("The file contains #{count} #{option}")
    else
      # Handle errors
      {:error, reason} -> IO.puts("Error reading file: #{reason}")
    end
  end

  # Function to prompt the user for input
  defp prompt_user(prompt) do
    # Read user input and remove leading/trailing whitespace
    IO.gets(prompt) |> String.trim()
  end

  # Function to get the counting option from the user
  defp get_counting_option do
    # Prompt the user for the option
    option = prompt_user("Do you want to count words, lines, or characters? ")
             |> String.downcase()

    # Use pattern matching for cleaner option handling
    case option do
      option when option in ["words", "word", "w"] -> "words"
      option when option in ["lines", "line", "l"] -> "lines"
      option when option in ["characters", "character", "chars", "c"] -> "characters"
      _ ->
        # Handle invalid options
        IO.puts("Invalid option. Please try again.")
        get_counting_option()
    end
  end

  # Function to count words based on the provided option and content
  defp count_based_on_option("words", content) do
    content
    |> String.split(~r/\W+/) # Split on non-word characters
    |> Enum.filter(&(&1 != "")) # Filter out empty words
    |> Enum.count() # Count the remaining words
  end

  # Function to count lines based on the provided option and content
  defp count_based_on_option("lines", content) do
    String.split(content, ~r/\r\n|\r|\n/) # Split on line breaks
    |> Enum.count() # Count the lines
  end

  # Function to count characters based on the provided option and content
  defp count_based_on_option("characters", content) do
    String.length(content) # Get the length of the content string
  end
end

# Call the main function to start the counting process
WordCounterAdvanced.count_words_in_file()
