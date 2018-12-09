#include "Storage.hpp"
#include <fstream>
#include <functional>
#include <list>
#include <iostream>
#include <algorithm>
#include <memory>
#include <cstring>
#include <string>
#include <vector>
#include "Meeting.hpp"
#include "User.hpp"
#include "Date.hpp"
#include "Path.hpp"

    std::shared_ptr<Storage> Storage::m_instance=NULL;
    Storage::Storage(){
        readFromFile();
        m_dirty=false;
    }

    std::vector<std::string> split(std::string line){
    std::string name;
    std::vector<std::string > sur;
    for(int i=0;i<line.length();i++){
        if(line[i]==',' or i==line.length()-1){
        	if(i==line.length()-1) name+=line[line.length()-1];
        	if(name!=""){
        		std::string res;
        		for(int i=1;i<name.length()-1;i++){
        			res+=name[i];
				}
				sur.push_back(res);
			}
        	name.clear();
        	continue;
		}
		name+=line[i];
    }
    return sur;
  }

  std::string construct(std::vector<std::string> name){
    std::string mid;
    for(int i=0;i<name.size();i++){
        mid+=name[i];
        if(i!=name.size()-1) mid+="&";
    }
    return mid;
  }
  std::vector<std::string> split_meeting(std::string line){
    std::vector<std::string> sur;
    std::string name;
    for(int i=0;i<line.length();i++){
        if(line[i]=='&' or i==line.length()-1){
        	if(i==line.length()-1) name+=line[i];
            if(name!=""){
            	sur.push_back(name);
            	name.clear();
			}
			continue;
        }
        name+=line[i];
    }
    return sur;
  }
  bool Storage::readFromFile(){
    std::ifstream get_file;
    if(get_file.fail()) return false;
    get_file.open(Path::userPath);
    if(!get_file.is_open()) {
        get_file.close();
        return false;
    }
    std::string line;
    while(getline(get_file,line)){
        std::vector<std::string> mid=split(line);
        User kk(mid[0],mid[1],mid[2],mid[3]);
        m_userList.push_back(kk);
    }
    get_file.close();

    std::ifstream get_file1;
    if(get_file1.fail()) return false;
    get_file1.open(Path::meetingPath);
    if(!get_file1.is_open()) {
        get_file1.close();
        return false;
    }
    while(getline(get_file1,line)){
        std::vector<std::string> mid=split(line);
        Date mid1(mid[2]);
        Date mid2(mid[3]);
        Meeting kk(mid[0],split_meeting(mid[1]),mid1,mid2,mid[4]);
        m_meetingList.push_back(kk);
    }
    get_file1.close();
    return true;
  }
  bool Storage::writeToFile(){
    std::ofstream out_file;
    std::ofstream out_file2;
    out_file.open(Path::userPath);
    out_file2.open(Path::meetingPath);
    if(!(out_file.is_open() and out_file2.is_open()) ) {
        out_file.close();
        out_file2.close();
        return false;
    }
    for(auto &it:m_userList){
        out_file << "\""<<it.getName()<<"\""<<","<< "\""<<it.getPassword()<<"\""<<","<< "\""<<it.getEmail()<<"\""<<","<< "\""<<it.getPhone()<<"\""<<'\n';
    }
    out_file.close();
    for(std::list<Meeting>::iterator it=m_meetingList.begin();it!=m_meetingList.end();it++){
        out_file2 << "\""<<(*it).getSponsor()<<"\""<<","<< "\""<<construct((*it).getParticipator())<<"\"";
        out_file2 <<","<< "\""<<Date::dateToString((*it).getStartDate())<<"\""<<","<< "\""<<Date::dateToString((*it).getEndDate())<<"\""<<","<< "\""<<(*it).getTitle()<<"\""<<'\n';
    }
    out_file2.close();
    return true;
  }

  std::shared_ptr<Storage> Storage::getInstance(){
    if(m_instance==NULL) Storage::m_instance=std::shared_ptr<Storage>(new Storage());
    return m_instance;
  }



  void Storage::createUser(const User &t_user){
    m_userList.push_back(t_user);
    m_dirty=true;
  }
  std::list<User> Storage::queryUser(std::function<bool(const User &)> filter) const{
    std::list<User> output;
    std::list<User> mid=m_userList;
    int size=mid.size();
    for(int i=0;i<size;i++){
        if(filter(mid.front())) output.push_back(mid.front());
        mid.pop_front();
    }
    return output;
  }
  int Storage::updateUser(std::function<bool(const User &)> filter,std::function<void(User &)> switcher){
    int size=m_userList.size();
    int sum=0;
    for(auto it=m_userList.begin();it!=m_userList.end();it++){
        if(filter(*it)){
            m_dirty=true;
            switcher(*it);
            sum++;
        }
    }
    if(m_dirty) sync();
    return sum;
  }
  int Storage::deleteUser(std::function<bool(const User &)> filter){
   std::list<User>::iterator mid = remove_if(m_userList.begin(),m_userList.end(),filter);
    int dis=distance(mid,m_userList.end());
    if(dis>0) m_dirty=true;
    m_userList.erase(mid,m_userList.end());
    return dis;
  }
  void Storage::createMeeting(const Meeting &t_meeting){
    m_meetingList.push_back(t_meeting);
    m_dirty=true;
  }
  std::list<Meeting> Storage::queryMeeting(std::function<bool(const Meeting &)> filter) const{
    std::list<Meeting> mid;
   // for(std::list<Meeting>::iterator it=m_meetingList.begin();it!=m_meetingList.end();it++){
    for(auto &it:m_meetingList){
        //const Meeting sur=(*it);
        if(filter(it)){
            mid.push_back(it);
        }
    }
    return mid;
  }
  int Storage::updateMeeting(std::function<bool(const Meeting &)> filter,std::function<void(Meeting &)> switcher){
    int sum=0;
    for(std::list<Meeting>::iterator it=m_meetingList.begin();it!=m_meetingList.end();it++){
        if(filter(*it)){
            m_dirty=true;
            switcher(*it);
            sum++;
        }
    }
    if(m_dirty) sync();
    return sum;
  }
  int Storage::deleteMeeting(std::function<bool(const Meeting &)> filter){
    std::list<Meeting>::iterator mid = remove_if(m_meetingList.begin(),m_meetingList.end(),filter);
    int dis=distance(mid,m_meetingList.end());
    if(dis>0) m_dirty=true;
    m_meetingList.erase(mid,m_meetingList.end());
    return dis;
  }
  bool Storage::sync(){
    return writeToFile();
  }
  Storage::~Storage(){
    writeToFile();
    m_instance=NULL;
  }


