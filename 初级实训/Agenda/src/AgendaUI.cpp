/*#ifndef AGENDAUI_H
#define AGENDAUI_H
*/
#include "AgendaUI.hpp"
#include <iostream>

#include <string>
#include <iomanip>
#include <sstream>
#include <vector>
using std::vector;
using std::cin;
using std::cout;
using std::endl;
using std::string;
using std::list;
using std::ios;
using std::setw;
using std::setiosflags;
using std::resetiosflags;

    AgendaUI::AgendaUI(){
    	m_userName = "";
   	 	m_userPassword = "";
  	  	startAgenda();
	}
    void AgendaUI::OperationLoop(void){
    	while(true){
    	for (int i = 1; i <= 37; i++) cout << "-";
        cout << "Agenda";
        for (int i = 1; i <= 37; i++) cout << "-";
        cout <<endl<< "Action :" << endl;
        if (m_userName == "") {
            cout << "l    - log in Agenda by user name and password" << endl;
            cout << "r    - register an Agenda account" << endl;
            cout << "q    - quit Agenda" << endl;
        } else {
            cout << "o    - log out Agenda" << endl;
            cout << "dc   - delete Agenda account" << endl;
            cout << "lu   - list all Agenda user" << endl;
            cout << "cm   - create a meeting" << endl;
            cout << "amp  - add meeting participator"<<endl;//add
            cout << "rmp  - remove meeting participator"<<endl;//remove
            cout << "rqm  - request to quit meeting"<<endl;//quit
            cout << "la   - list all meetings" << endl;
            cout << "las  - list all sponsor meetings" << endl;
            cout << "lap  - list all participator meetings" << endl;
            cout << "qm   - query meeting by title" << endl;
            cout << "qt   - query meeting by time interval" << endl;
            cout << "dm   - delete meeting by title" << endl;
            cout << "da   - delete all meetings" << endl;
        }
    	for (int i = 1; i <= 80; i++) cout << "-";
        cout << endl<<endl;
        if (m_userName == "")cout << "Agenda :~$ ";
        else cout << "Agenda@" << m_userName << " :~# ";
        if (!executeOperation(getOperation())) break;
	}
}


    void AgendaUI:: startAgenda(){
    	system("clear");
	}
    std::string AgendaUI::getOperation(){
    	string name;
    	cin >> name;
    	return name;
	}
    bool AgendaUI::executeOperation(std::string t_operation){
    	string op=t_operation;
    	for (int i = 0; i < op.length(); i++) op[i] = tolower(op[i]);
    	bool flag = true;
    	if (m_userName == "") flag = false;
    	if (op == "l" && !flag) {
       		userLogIn();
        	return true;
    	}
    	if (op == "r" && !flag) {
       		userRegister();
        	return true;
    	}
    	if (op == "dc" && flag) {
        	deleteUser();
        	return true;
    	}
    	if (op == "lu" && flag) {
        	listAllUsers();
        	return true;
    	}
    	if (op == "cm" && flag) {
       		createMeeting();
        	return true;
    	}
    	if (op == "la" && flag) {
        	listAllMeetings();
        	return true;
    	}
    	if (op == "las" && flag) {
        	listAllSponsorMeetings();
        	return true;
    	}
        if(op=="amp" && flag){
			addMeetingPart();
			return true;
		}
		if(op=="rmp" && flag){
			removeMeetingPart();
			return true;
		}
		if(op=="rqm" && flag){
			quitMeeting();
			return true;
		}
    	if (op == "lap" && flag) {
        	listAllParticipateMeetings();
        	return true;
    	}
    	if (op == "qm" && flag) {
        	queryMeetingByTitle();
        	return true;
    	}	
    	if (op == "qt" && flag) {
        	queryMeetingByTimeInterval();
        	return true;
    	}
    	if (op == "dm" && flag) {
        	deleteMeetingByTitle();
        	return true;
    	}
    	if (op == "da" && flag) {
        	deleteAllMeetings();
        	return true;
    	}
    	if (op == "o" && flag) {
        	userLogOut();
        	return true;
    	}
    	if (op == "q" && !flag) {
        	m_agendaService.quitAgenda();
        	return false;
    	}
    	cout << endl;
    	cout << "Please enter correct command!" << endl;
    	cout << endl;
   		return true;
	}
	void AgendaUI::addMeetingPart(){
		cout <<endl;
		cout <<"[add participator] "<<"[meeting title] [participator username]"<<endl;
		cout <<"[add participator] ";
		string meeting;
		string part;
		cin >> meeting >> part;
		if(m_agendaService.addMeetingParticipator(m_userName,meeting,part)){
			cout <<"[add participator] success!"<<endl;
		}
		else{
			cout <<"[add participator] error!"<<endl;
		}
		
	}
	void AgendaUI::removeMeetingPart(){
		cout <<endl;
		cout <<"[remove participator] "<<"[meeting title] [participator username]"<<endl;
		cout <<"[remove participator] ";
		string meeting;
		string part;
		cin >> meeting >> part;
		if(m_agendaService.removeMeetingParticipator(m_userName,meeting,part)){
			cout <<"[remove participator] success!"<<endl;
		}
		else{
			cout <<"[remove participator] error!"<<endl;
		}
	}
	void AgendaUI::quitMeeting(){
		cout <<endl;
		cout <<"[quit participator] "<<"[meeting title]"<<endl;
		cout <<"[quit participator] ";
		string meeting;
		cin >> meeting;
		if(m_agendaService.quitMeeting(m_userName,meeting)){
			cout <<"[quit participator] success!"<<endl;
		}
		else{
			cout <<"[quit participator] error!"<<endl;
		}
	}
    void AgendaUI::userLogIn(void){
    	cout <<endl;
    	cout <<"[log in] "<<"[username] "<<"[password] "<<endl;
    	cout <<"[log in] ";
    	string  name;
    	string password;
    	cin >> name >> password;
    	if(m_agendaService.userLogIn(name,password)){
    		m_userName=name;
    		m_userPassword=password;
    		cout <<"[log in] "<<"success!"<<endl;
		}
		else{
			cout <<"Password error or user doesn't exist"<<endl;
		}
		cout <<endl;
	}
    void AgendaUI::userRegister(void){
    	cout << endl;
    	cout <<"[register] "<<"[username] "<<"[password] "<<"[email] "<<"[phone] "<<endl;
    	cout <<"[register] ";
    	string user;
    	string password;
    	string email;
    	string phone;
    	cin >> user >>password>>email>>phone;
    	if(m_agendaService.userRegister(user,password,email,password)) {
    		cout << "[register] succeed!"<<endl;
		}
		else{
			cout << "[register] This username has been registered!"<<endl;
		}
		cout <<endl;
	}
    void AgendaUI::userLogOut(void){
    	cout<<endl;
    	m_userName="";
    	m_userPassword="";
    	cout <<endl;
	}
    void AgendaUI::quitAgenda(void){
    	m_agendaService.quitAgenda();
	}
    void AgendaUI::deleteUser(void){
    	cout <<endl;
    	cout <<"[delete agenda accout] success!"<<endl;
    	m_agendaService.deleteUser(m_userName,m_userPassword);
    	m_userName="";
    	m_userPassword="";
    	cout <<endl;
	}
    void AgendaUI::listAllUsers(void){
    	cout <<endl;
    	list<User> want=m_agendaService.listAllUsers();
    	cout << "[list all users]"<<endl;
    	cout << setw(25)<<"name"<<setw(25)<<"password"<<setw(25)<<"email"<<endl;
    	for(auto mid:want){
    		cout << setw(25)<<mid.getName()<<setw(25)<<mid.getPassword()<<setw(25)<<mid.getEmail()<<endl;
    	}
    	cout <<endl;
	}
    void AgendaUI::createMeeting(void){
    	cout << endl;
    	cout << "[create meeting] [the number of participators]" << endl<< "[create meeting] ";
  	  	int num;
  		cin >> num;
  		vector<string> part;
  		for(int i=0;i<num;i++){
  			string name;
  			cin >> name;
  			part.push_back(name);
		}
		cout << "[create meeting] [title]"<< "[start time(yyyy-mm-dd/hh:mm)] [end time(yyyy-mm-dd/hh:mm)]"<< endl;
   		cout << "[create meeting] ";
   		string title,start_time,end_time;
   		cin >>title>> start_time>>end_time;
   		if(m_agendaService.createMeeting(m_userName,title,start_time,end_time,part)){
   			cout <<"[create meeting] "<<"succeed!"<<endl;	
		}
		else{
   			cout <<"[create meeting] "<<"error!"<<endl;				
		}
		cout <<endl;
	}
    void AgendaUI::listAllMeetings(void){
    	cout <<endl;
    	list<Meeting> mid=m_agendaService.listAllMeetings(m_userName);
    	printMeetings(mid);
	}
    void AgendaUI::listAllSponsorMeetings(void){
    	cout <<endl;
		list<Meeting> mid=m_agendaService.listAllSponsorMeetings(m_userName);
    	printMeetings(mid);
	}
    void AgendaUI::listAllParticipateMeetings(void){
    	cout <<endl;
		list<Meeting> mid=m_agendaService.listAllSponsorMeetings(m_userName);
    	printMeetings(mid);
	}
    void AgendaUI::queryMeetingByTitle(void){
    	cout <<endl;
    	cout <<"[query meeting] "<<"[title]:"<<endl;
		cout <<"[query meeting] ";
		string name;
		cin >> name;
		list<Meeting> mid=m_agendaService.meetingQuery(m_userName,name);
	}
    void AgendaUI::queryMeetingByTimeInterval(void){
    	cout <<endl;
    	cout << "[query meetings] [start time(yyyy-mm-dd/hh:mm)] "<< "[end time(yyyy-mm-dd/hh:mm)]" << endl;
    	cout << "[query meetings] ";
		string start_time;
		string end_time;
		cin >> start_time>>end_time;
		list<Meeting> mid=m_agendaService.meetingQuery(m_userName,start_time,end_time);
		printMeetings(mid);
	}
    void AgendaUI::deleteMeetingByTitle(void){
    	cout <<endl;
    	cout <<"[delete meeting] "<<"[title]:"<<endl;
		cout <<"[delete meeting] ";
		string name;
		cin >> name;
		if(m_agendaService.deleteMeeting(m_userName,name)){
			cout <<"[delete meeting] "<<"success!";
		}
		else{
			cout <<"[error] "<<"delete meeting error"<<endl;
		}
		cout <<endl;
	}
    void AgendaUI::deleteAllMeetings(void){
    	cout << endl;
  		if (m_agendaService.deleteAllMeetings(m_userName)) {
  	  	    cout << "[delete all meeting] succeed!" << endl;
  		} 
		else {
  			cout << "[error] delete all meeting fail!" << endl;
  	  	}
    	cout << endl;
	}
    void AgendaUI::printMeetings(std::list<Meeting> t_meetings){
    	list<Meeting> mid=t_meetings;
    	cout << setw(10)<<"title"<< setw(10)<<"sponsor"<< setw(30)<<"start time"<< setw(30)<<"end time"<<setw(20)<<"participators"<<endl;
		for(auto name:mid){
    		cout << setw(10)<<name.getTitle()<< setw(10)<<name.getSponsor()<< setw(30)<<Date::dateToString(name.getStartDate())<< setw(30)<<Date::dateToString(name.getEndDate());
    		cout << setw(30);
    		vector<string> part=name.getParticipator();
    		for(int i=0;i<part.size();i++){
    			cout << part[i];
				if(i!=part.size())cout <<",";
			}
    		cout <<endl;
		}
		cout <<endl;
	}


