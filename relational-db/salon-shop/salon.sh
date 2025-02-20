#! /bin/bash

#LEMBRAR DE ALTERAR USERNAME PARA freecodecamp
PSQL='psql -X --username=gguife --dbname=salon --tuples-only-c'

echo -e "\n~~~~ Salon gguife services ~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "How may I help you?"
  echo -e "\n1) Appointment for a woman's haircut \n2) Appointment for a Man's haircut \n3) Exit"
  read MAIN_MENU_SELECTION


  case $MAIN_MENU_SELECTION in 
    1) SERVICE_SELECTED="Woman Haircut"; BOOK_SERVICE ;;
    2) SERVICE_SELECTED="Man Haircut"; BOOK_SERVICE ;;
    3) EXIT ;;
    *) MAIN_MENU "Please enter a valid option." ;;
  esac


  if [[ $MAIN_MENU_SELECTION -eq 1 || $MAIN_MENU_SELECTION -eq 2 ]] 
  then
      echo "You selected: $SERVICE_SELECTED"
  else
      MAIN_MENU
  fi

}


BOOK_SERVICE() {
  SERVICE_ID_SELECTED=$SERIVICE_SELECTED
  
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE
  


  # Script for verify if register user exist // verify by phone number 
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")


  # When exist user 
  if [[ $CUSTOMER_ID ]]
  then
    echo -e "\nWhat time do you want to book the service?"
    read SERVICE_TIME
    # Register service id in appointments with customer_id


    # Register service time in appointments with customer_id
  fi

  # if user not exist in database
  if [[ -z $CUSTOMER_ID ]]
  then
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME

    # Register user  - name and phone number
    INSERT_CUSTOMER=$($PSQL "INSERT INOT customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")



    echo -e "\nWhat time do you want to book the service?"
    read SERVICE_TIME

    # Register id service
    

    # Register service time 
  fi
}



EXIT() {
  echo -e "\nThank you for sptopping in.\n"
}

MAIN_MENU