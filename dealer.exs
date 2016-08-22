defmodule DeckOfCards do
  def suits, do: ["Clubs", "Hearts", "Spades", "Diamonds"]
  def ranks, do: ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]

  def deck do
    for suit <- suits, rank <- ranks, do: %{rank: rank, suit: suit}
  end
end
