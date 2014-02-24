echo -e "\n"
echo -e "\033[36m********************************************"
echo -e "\033[33m           rake resque:work QUEUE='*'"
echo -e "\033[36m********************************************"
echo -e "\033[0m"
rake resque:work QUEUE='*'
