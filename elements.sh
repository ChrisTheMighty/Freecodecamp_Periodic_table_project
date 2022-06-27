#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
else
  #check if input is an atomic number
  if [[ $1 =~ ^([0-9])([0-9]?)([0-9]?)$ ]]
  #if it is
  then
    # check if atomic number doesn't exist in database
    AN=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
    if [[ -z $AN ]]
    then
      echo "I could not find that element in the database."
    #if it does
    else
      #get name
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
      #get symbol
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
      #get type
      TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING (type_id) FULL JOIN elements USING (atomic_number) WHERE atomic_number = $1")
      #get mass
      MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $1")
      #get MP
      MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $1")
      #get BP
      BP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $1")
      #echo message
      echo -e "The element with atomic number $( echo $AN | sed -r 's/^ *| *$//g') is $( echo $NAME | sed -r 's/^ *| *$//g') ($( echo $SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $MASS | sed -r 's/^ *| *$//g') amu. $(echo $NAME | sed -r 's/^ *| *$//g') has a melting point of $( echo $MP | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $BP | sed -r 's/^ *| *$//g') celsius."
    fi
  #if it isn't
  else
    #check if input is a symbol
    if [[ $1 =~ ^([A-Z])([a-z]?)([a-z]?)$ ]]
    #if it is
    then
      # check if symbol doesn't exist in database
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
      if [[ -z $SYMBOL ]]
      then
        echo "I could not find that element in the database."
      #if it does
      else
        #get AN
        AN=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
        #get name
        NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
        #get type
        TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING (type_id) FULL JOIN elements USING (atomic_number) WHERE symbol = '$1'")
        #get mass
        MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING (atomic_number) WHERE symbol = '$1'")
        #get MP
        MP=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING (atomic_number) WHERE symbol = '$1'")
        #get BP
        BP=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING (atomic_number) WHERE symbol = '$1'")
        #echo message
        echo -e "The element with atomic number $( echo $AN | sed -r 's/^ *| *$//g') is $( echo $NAME | sed -r 's/^ *| *$//g') ($( echo $SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $MASS | sed -r 's/^ *| *$//g') amu. $(echo $NAME | sed -r 's/^ *| *$//g') has a melting point of $( echo $MP | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $BP | sed -r 's/^ *| *$//g') celsius."
      fi  
      #if it isn't
      else
        #check if input is a name
        if [[ $1 =~ ^[A-Z]([a-z]+)$ ]]
        #if it is
        then
          # check if name doesn't exist in database
          NAME=$($PSQL "SELECT NAME FROM elements WHERE NAME = '$1'")
          if [[ -z $NAME ]]
          then
            echo "I could not find that element in the database."
          #if it does
          else
            #get AN
            AN=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
            #get symbol
            SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1'")
            #get type
            TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING (type_id) FULL JOIN elements USING (atomic_number) WHERE name = '$1'")
            #get mass
            MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING (atomic_number) WHERE name = '$1'")
            #get MP
            MP=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING (atomic_number) WHERE name = '$1'")
            #get BP
            BP=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING (atomic_number) WHERE name = '$1'")
            #echo message
            echo -e "The element with atomic number $( echo $AN | sed -r 's/^ *| *$//g') is $( echo $NAME | sed -r 's/^ *| *$//g') ($( echo $SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $MASS | sed -r 's/^ *| *$//g') amu. $(echo $NAME | sed -r 's/^ *| *$//g') has a melting point of $( echo $MP | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $BP | sed -r 's/^ *| *$//g') celsius."
          fi  
        #if it isn't
        else
          echo "I could not find that element in the database."
        fi
      fi
    fi
  fi
  