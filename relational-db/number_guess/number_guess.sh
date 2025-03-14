#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess -t --tuples-only -c"

USER() {
  RAND_NUM=$(( $RANDOM % 1000 + 1 ))
  echo -e "\nEnter your username: "
  read UN
  USER=$($PSQL "SELECT username, games, best FROM games WHERE username = '$UN'")
  
  if [[ -z $USER ]]; then
    echo -e "\nWelcome, $UN! It looks like this is your first time here."
    echo -e "\nGuess the secret number between 1 and 1000:\n"
    PLAY $RAND_NUM $UN
  else
    echo $USER | while read USERNAME BAR GAMES BAR BEST; do
      echo -e "\nWelcome back, $UN! You have played $GAMES games, and your best game took $BEST guesses."
    done
    echo -e "\nGuess the secret number between 1 and 1000:\n"
    PLAY $RAND_NUM $UN
  fi
}

PLAY() {
  local RAND_NUM=$1
  local UN=$2
  local C=1
  while true; do
    read NUMBER
    if [[ ! $NUMBER =~ ^[0-9]+$ ]]; then
      echo -e "\nThat is not an integer, guess again:\n"
    else
      if [[ "$NUMBER" -lt $RAND_NUM ]]; then
        echo -e "\nIt's higher than that, guess again:\n"
      elif [[ "$NUMBER" -gt $RAND_NUM ]]; then
        echo -e "\nIt's lower than that, guess again:\n"
      else      
        echo -e "\nYou guessed it in $C tries. The secret number was $RAND_NUM. Nice job!"
        INSERT $UN $C
        break  # Exit the loop when the correct number is guessed
      fi
      ((C++))  # Increment the counter before the next loop
    fi
  done
}

INSERT() {
  local UN=$1
  local C=$2
  # Check if the user already exists in the database
  USER_DATA=$($PSQL "SELECT username, games, best FROM games WHERE username = '$UN'")

  if [[ -z $USER_DATA ]]; then
    # If user does not exist, insert new user with 1 game and best guess count
    INSERT_NEW=$($PSQL "INSERT INTO games(username, games, best) VALUES('$UN', 1, $C)")
  else
    # If user exists, update games played and best guess count
    echo $USER_DATA | while read USERNAME BAR GAMES BAR BEST; do
      if [[ $BEST -gt $C ]]; then
        # Update only if the current best is worse than the new guess
        INSERT_GAME=$($PSQL "UPDATE games SET games = games + 1, best = $C WHERE username = '$UN'")
      else
        # Update games played and set the new best guess
        INSERT_NEW_RECORD=$($PSQL "UPDATE games SET games = games + 1 WHERE username = '$UN'")
      fi
    done
  fi
}

USER