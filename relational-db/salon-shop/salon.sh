#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo "Welcome to My Salon, how can I help you?"

MAIN_MENU() {
  if [[ $1 ]]; then
    echo -e "\n$1"
  fi

  echo -e "\n1) Cut\n2) Color\n3) Perm\n4) Style\n5) Trim"
  read SERVICE_ID_SELECTED
  
  case $SERVICE_ID_SELECTED in
    1) SERVICE_NAME="cut" ;;
    2) SERVICE_NAME="color" ;;
    3) SERVICE_NAME="perm" ;;
    4) SERVICE_NAME="style" ;;
    5) SERVICE_NAME="trim" ;;
    *) MAIN_MENU "I could not find that service. What would you like today?" ; return ;;
  esac

  BOOK_SERVICE
}

BOOK_SERVICE() {
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  CUSTOMER_ID=$(echo "$CUSTOMER_ID" | xargs)

  if [[ -z "$CUSTOMER_ID" ]]; then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    CUSTOMER_ID=$(echo "$CUSTOMER_ID" | xargs)
  else
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id='$CUSTOMER_ID'")
    CUSTOMER_NAME=$(echo "$CUSTOMER_NAME" | xargs)
  fi

  echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME
  
  REGISTER_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}

MAIN_MENU
