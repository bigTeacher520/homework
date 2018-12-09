#include "Date.hpp"
#include <vector>
Date::Date(){
		this->m_year=0;
    	this->m_month=0;
    	this->m_day=0;
    	this->m_hour=0;
    	this->m_minute=0;
	}
    Date:: Date(int t_year, int t_month, int t_day, int t_hour, int t_minute){

    		this->m_year=t_year;
    		this->m_month=t_month;
    		this->m_day=t_day;
    		this->m_hour=t_hour;
    		this->m_minute=t_minute;

    }
	bool isSmall(int num){
		if(num<10 ) return true;
		return false;
	}
    /*Date::Date(const Date sur){
		this->m_year=sur.getYear();
		this->m_month=sur.getMonth();
		this->m_day=sur.getDay();
		this->m_hour=sur.getHour();
		this->m_minute=sur.getMinute();
    }*/
    Date::Date(const std::string &dateString){
		Date sur=stringToDate(dateString);
		this->m_year=sur.getYear();
		this->m_month=sur.getMonth();
		this->m_day=sur.getDay();
		this->m_hour=sur.getHour();
		this->m_minute=sur.getMinute();
    }
    int Date::getYear(void) const{
    	return this->m_year;
    }
    void Date::setYear(const int t_year){
    	this->m_year=t_year;
    }
    int Date::getMonth(void) const{
     	return this->m_month;
    }
    void Date::setMonth(const int t_month){
    	this->m_month=t_month;
    }
    int Date::getDay(void) const{
    	return this->m_day;
    }
    void Date::setDay(const int t_day){
    	this->m_day=t_day;
    }

    int Date::getHour(void) const{
    	return this->m_hour;
    };
    void Date::setHour(const int t_hour){
    	this->m_hour=t_hour;
    }
    int Date::getMinute(void) const{
    	return this->m_minute;
    }
    void Date::setMinute(const int t_minute){
    	this->m_minute=t_minute;
    }
    bool Date::isValid(const Date &t_date){
		int month=t_date.getMonth();
    	int year=t_date.getYear();
    	int day=t_date.getDay();
    	int hour=t_date.getHour();
    	int minute=t_date.getMinute();
    	if(year<1000 or year >9999) return false;
    	if(month>12 or month<1) return false;
    	int mid_day;
    	if(year%4==0 and year%100 !=0 or year%400==0){
    		mid_day=29;
    	}
    	else mid_day=28;
    	if(month==2){
    		if(day>mid_day or day<1) return false;
    	}
    	if(month==1 or month==3 or month==5 or month==7 or month==8 or month==10 or month==12){
    		if(day>31 or day<1) return false;
    	}
    	if(month==4 or month==6 or month==9 or month==11 ){
    		if(day>30 or day<1) return false;
    	}
    	if(hour>23 or hour <0){
    		return false;
    	}
    	if(minute>59 or minute <0) return false;
    	return true;
    }
    bool isNum(char num){
        if(num>='0' and num <='9') return true;
        return false;
    }
    bool isMywant(char num,const char mid){
        if(num==mid) return true;
        return false;
    }
    Date Date::stringToDate(const std::string &t_dateString){
        Date null_date(0,0,0,0,0);
        Date mid_date(0,0,0,0,0);
        std::string name="";
        int mid;
        int i=0;
        for(;i<4;i++){
            if(isNum(t_dateString[i])) name=name+t_dateString[i];
            else return null_date;
        }
        mid=stoi(name);
       // std::cout<<name<<std::endl;
        name.clear();
        mid_date.setYear(mid);
        if(!(isMywant(t_dateString[i],'-'))) return null_date;
        i++;
        for(;i<7;i++){
            if(isNum(t_dateString[i])) name+=t_dateString[i];
            else return null_date;
        }
        mid=stoi(name);
        //std::cout<<name<<std::endl;

        name.clear();
        mid_date.setMonth(mid);
        if(!(isMywant(t_dateString[i],'-')))return null_date;
         i++;
        for(;i<10;i++){
            if(isNum(t_dateString[i])) name+=t_dateString[i];
            else return null_date;
        }
        mid=stoi(name);
        //std::cout<<name<<std::endl;
        name.clear();
        mid_date.setDay(mid);
        if(!(isMywant(t_dateString[i],'/'))) return null_date;
         i++;
        for(;i<13;i++){
            if(isNum(t_dateString[i])) name+=t_dateString[i];
            else return null_date;
        }
        mid=stoi(name);
        //std::cout<<name<<std::endl;
        name.clear();
        mid_date.setHour(mid);
        if(!(isMywant(t_dateString[i],':'))) return null_date;
        i++;
        for(;i<16;i++){
            if(isNum(t_dateString[i])) name+=t_dateString[i];
            else return null_date;
        }
        mid=stoi(name);
        name.clear();
        mid_date.setMinute(mid);
        return mid_date;

    }
     //static std::string dateToString(const Date &t_date)
    std::string Date::dateToString(const Date &t_date){
    	//2012-07-19/20:51
    	std::string name="";
      if(!isValid(t_date)) return "0000-00-00/00:00";
    	if(t_date.getYear()<1000 and t_date.getYear()>=100){
            name+="0";
        }
        if(t_date.getYear()<100 and t_date.getYear()>=10){
            name+="00";
        }
        if(t_date.getYear()<10){
            name+="000";
        }
        name+=std::to_string(t_date.getYear());

    	name+="-";
    	if(isSmall(t_date.getMonth())){
				name+="0";
		}
		name+=std::to_string(t_date.getMonth());
		name+="-";
		if(isSmall(t_date.getDay())){
				name+="0";
		}
		name+=std::to_string(t_date.getDay());
		name+="/";
		if(isSmall(t_date.getHour())){
				name+="0";
		}
		name+=std::to_string(t_date.getHour());
		name+=":";
		if(isSmall(t_date.getMinute())){
				name+="0";
		}
		name+=std::to_string(t_date.getMinute());
    	return name;
    }
    Date& Date:: operator=(const Date &t_date){
    	this->m_year=t_date.getYear();
    	this->m_month=t_date.getMonth();
    	this->m_day=t_date.getDay();
    	this->m_hour=t_date.getHour();
    	this->m_minute=t_date.getMinute();
    	return *this;
    }
    bool Date::operator==(const Date &t_date) const{
    	if(this->m_year!=t_date.getYear()) return false;
    	if(this->m_month!=t_date.getMonth()) return false;
    	if(this->m_day!=t_date.getDay()) return false;
    	if(this->m_hour!=t_date.getHour()) return false;
    	if(this->m_minute!=t_date.getMinute()) return false;
    	return true;
    }
    bool Date::operator>(const Date &t_date) const{
    	if(this->m_year>t_date.getYear()) return true;
    	else if(this->m_year<t_date.getYear()) return false;
    	else if(this->m_year==t_date.getYear()){
    		if(this->m_month>t_date.getMonth()) return true;
    		else if(this->m_month<t_date.getMonth()) return false;
    		else if(this->m_month==t_date.getMonth()){
    			if(this->m_day>t_date.getDay()) return true;
    			else if(this->m_day<t_date.getDay()) return false;
    			else if(this->m_day==t_date.getDay()){
    				if(this->m_hour>t_date.getHour()) return true;
    				else if(this->m_hour<t_date.getHour()) return false;
    				else if(this->m_hour==t_date.getHour()){
						if(this->m_minute>t_date.getMinute()) return true;
						else if(this->m_minute<=t_date.getMinute()) return false;
    				}
    			}
    		}
    	}
	}
    bool Date::operator<(const Date &t_date) const{
        Date mid(this->m_year,this->m_month,this->m_day,this->m_hour,this->m_minute);
    	if(mid>t_date or mid==t_date) return false;
    	return true;
    }
    bool Date::operator>=(const Date &t_date) const{
        Date mid(this->m_year,this->m_month,this->m_day,this->m_hour,this->m_minute);
    	if(mid<t_date) return false;
    	return true;
    }
    bool Date::operator<=(const Date &t_date) const{
        Date mid(this->m_year,this->m_month,this->m_day,this->m_hour,this->m_minute);
    	if(mid>t_date) return false;
    	return true;
    }



