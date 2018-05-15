clc; clear; close all;

suits = ["Spades", "Hearts", "Clubs", "Diamonds"];
ranks = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"];
pick_cards = input('Enter the number of cards: ');

pick_random = randperm(52, pick_cards);

fprintf('%d cards picked:\n', pick_cards);

i = pick_cards;

while i > 0
  quotient = ceil(pick_random(i) / 13);
  remainder = mod(pick_random(i), 13);
  if remainder == 0
    remainder = 13;
  end
  fprintf('Card number %2d: %s of %s\n', pick_random(i), ranks(remainder), suits(quotient));
  i = i - 1;
end

