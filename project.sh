Menu_Loop () 
{
    select=100 
    while [ $select -gt 0 ]
	do
	    select=$(whiptail --title "Main Program" --menu "Choose an option" 25 78 10 \
	    "1" "Create a database" \
	    "2" "Manage an existing database" \
	    "3" "copy a database" \
	    "4" "Remove a database from system" \
	    "5" "Show the databases" \
	    "6" "Quit from Program" 3>&1 1>&2 2>&3)

	    case "$select" in 
            1)
                name=$(whiptail --inputbox "Enter your database name" 8 39 --title "Create a database" 3>&1 1>&2 2>&3)
                echo>$name 
                whiptail --title "Create a database" --msgbox "! ! Database Created ! !" 8 78
                ;;
            2)
                db=$(whiptail --inputbox "Type your database name" 8 39 --title "Student Database System" 3>&1 1>&2 2>&3)
                menu=100 
                while [ $menu -gt 0 ]
                do
                    menu=$(whiptail --title "Manage an existing database" --menu "Choose an option" 25 78 5 \
                    "1" "Insertion" \
                    "2" "Delete" \
                    "3" "Show Info" \
                    "4" "query" \
                    "5" "jump to home" 3>&1 1>&2 2>&3)
                    case "$menu" in
                        1)
                            num=$(whiptail --inputbox "Number of entries" 8 39 --title "Insertion" 3>&1 1>&2 2>&3)
                            for(( i=0; i<num; i++ ))
                            do
                                id=$(whiptail --inputbox "ID" 8 39 --title "Type your data" 3>&1 1>&2 2>&3)
                                nam=$(whiptail --inputbox "Name" 8 39 --title "Type your data" 3>&1 1>&2 2>&3)
                                gpa=$(whiptail --inputbox "CGPA" 8 39 --title "Type your data" 3>&1 1>&2 2>&3)
                                loc=$(whiptail --inputbox "Location" 8 39 --title "Type your data" 3>&1 1>&2 2>&3)

                                var=" $id $nam $gpa $loc "
                                echo " $var " >>$db
                                whiptail --title "Insertion" --msgbox "! ! Insertion Complete ! !" 8 78
                            done
                            ;;
                        2)
                            ln=$(whiptail --inputbox "Enter the id number" 8 39 --title "Delete" 3>&1 1>&2 2>&3)
                            whiptail --title "ln" --msgbox "$ln" 30 78
                            grep -v " $ln " $db
                            ;;
                        3)
                            #cat $db
                            whiptail --title "Example Dialog" --msgbox "$(cat $db)" 30 78
                            ;;
                        4)
                            que=100
                            while [ $que -gt 0 ]
                            do
					  que=$(whiptail --title "query" --menu "Choose an option" 25 78 6 \
                                "1" "Sort By ID Ascending Order" \
                                "2" "Sort By ID Decending Order" \
                                "3" "Total number of students" \
                                "4" "Search By Name" \
                                "5" "Search By Location" \
                                "6" "Jump to Sub menu" 3>&1 1>&2 2>&3)

                                case "$que" in
                                    1) 
                                        whiptail --title "Query" --msgbox "$(sort $db)" 20 78
                                        ;;
                                    2) 
                                        whiptail --title "Query" --msgbox "$(sort -r $db)" 20 78
                                        ;;
                                    3)
                                        line=`wc -l < $db | tr -d ' ' `
                                        whiptail --title "Query" --msgbox "Total number of students: $line " 8 78
                                        ;;
                                    4) 
                                        en=$(whiptail --inputbox "Enter the name" 8 39 --title "Search By Name" 3>&1 1>&2 2>&3)
                                        whiptail --title "Query" --msgbox "$(grep $en $db)" 20 78
                                        ;;
                                    5)
                                        el=$(whiptail --inputbox "Enter the location" 8 39 --title "Search By Location" 3>&1 1>&2 2>&3)
                                        whiptail --title "Query" --msgbox "$(grep $el $db)" 20 78
                                        ;;
                                    6)
                                        que=0
                                        ;;
                                    esac
                            done
                            ;;
                        5)
                            menu=0
                            ;;
                        esac
                done
                        ;;
            3)
                file=$(whiptail --inputbox "Enter file name" 8 39 --title "copy a database" 3>&1 1>&2 2>&3)
                file1=$(whiptail --inputbox "Enter second file name" 8 39 --title "copy a database" 3>&1 1>&2 2>&3)
                if [ -f $file ]
                then
                    cp $file $file1
                    whiptail --title "copy a database" --msgbox "! ! File Copied ! !" 8 78 
                else
                    whiptail --title "copy a database" --msgbox "! ! File does not exist ! !" 8 78 
                fi
                ;;
            4)
                file=$(whiptail --inputbox "Enter a file name to be removed" 8 39 --title "Remove a database from system" 3>&1 1>&2 2>&3)
                if [ -f $file ]
                then 
                    rm -i $file
                    whiptail --title "Remove a database from system" --msgbox "! ! Database Removed ! !" 8 78 
                else
                    whiptail --title "Remove a database from system" --msgbox "! ! $file does not exist ! !" 8 78 
                fi
                ;;
            5)
                whiptail --title "Show the databases" --msgbox "$(ls {*[!.sh],[0-9]*})" 20 78
                ;;
            6)
                whiptail --title "Quit from Program" --msgbox "! ! Exiting from the program ! !" 8 78 
                exit
                ;;
            esac
    done
}

count=`wc -l < users.txt | tr -d ' '`
arr=( Jahid Taisiq Santo Shahriar )
control=1
while [ $control -gt 0 ]
do
    control=$(whiptail --title "Student Database System" --menu "Choose an option" 25 78 5 \
    "1" "Execute the Program" \
    "0" "Abrot" 3>&1 1>&2 2>&3)
    case "$control" in
        1)
            name=$(whiptail --inputbox "USERNAME" 8 39 --title "USER VEFIFICATION" 3>&1 1>&2 2>&3)
            for (( i=0; i<count; i++ ))
            do
                if [[ $name == "${arr[$i]}" ]]
                then
                    pass="access"
                    new_pass=$(whiptail --passwordbox "please enter your secret password" 8 39 --title "USER VEFIFICATION" 3>&1 1>&2 2>&3)
                    if [[ $new_pass == $pass ]]
                    then
                       {
                           for ((i = 0 ; i <= 100 ; i+=5)); do
                               sleep 0.1
                               echo $i
                           done
                       } | whiptail --gauge "Please wait while we are sleeping..." 6 50 0

                        whiptail --title "USER VEFIFICATION" --msgbox "Access Granted" 8 78
				entry=$(whiptail --title "Student Database System" --menu "Choose an option" 25 78 5 \
                        "1" "Main Program" \
                        "2" "add User" 3>&1 1>&2 2>&3)
                        case "$entry" in
                            1) 
                                Menu_Loop
                                ;;
                            2)
                                n=$(whiptail --inputbox "How many User You Want to Add?" 8 39 --title "Add Temporary Users" 3>&1 1>&2 2>&3)
                                new_count=$(($count+$n))
                                for(( i=$count; i<$new_count; i++ ))
                                do
						m=$(whiptail --inputbox "USERNAME" 8 39 --title "USER VEFIFICATION" 3>&1 1>&2 2>&3)
						echo "$m" >> users.txt
                                    arr=(${arr[0]} "$m")
                                    echo ${arr[0]}
                                done
                                ;;
                            esac
                    else
				whiptail --title "Student Database System" --msgbox "Wrong Password" 8 78
                    fi
                    break;
                else
                    elim=$(($count-1))
                    if [[ $i == $elim ]]
                    then
                       {
                           for ((i = 0 ; i <= 100 ; i+=5)); do
                               sleep 0.1
                               echo $i
                           done
                       } | whiptail --gauge "Please wait while we are sleeping..." 6 50 0
                       whiptail --title "Student Database System" --msgbox "Access Denied" 8 78
                    fi
                fi
            done
            ;;
        2)
            control=0;;
        esac
done
