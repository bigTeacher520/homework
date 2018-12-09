#include "Meeting.hpp"
#include "Date.hpp"
#include <vector>
#include <string>
 //Meeting(std::string t_sponsor, std::vector<std::string> t_participator, Date t_startTime,
   //       Date t_endTime, std::string t_title);

	Meeting::Meeting(const std::string &t_sponsor, const std::vector<std::string> &t_participator,const  Date &t_startTime,const Date &t_endTime, const std::string &t_title){
		this->m_sponsor=t_sponsor;
		this->m_participators=t_participator;
		this->m_startDate=t_startTime;
		this->m_endDate=t_endTime;
		this->m_title=t_title;
	}
	Meeting::Meeting(const Meeting &t_meeting){
		this->m_sponsor=t_meeting.getSponsor();
		this->m_participators=t_meeting.getParticipator();
		this->m_startDate=t_meeting.getStartDate();
		this->m_endDate=t_meeting.getEndDate();
		this->m_title=t_meeting.getTitle();
	}
	 std::string Meeting::getSponsor(void) const{
		return this->m_sponsor;
	}
	void Meeting::setSponsor(const std::string& t_sponsor){
		this->m_sponsor=t_sponsor;
	}
	std::vector<std::string> Meeting::getParticipator(void) const{
		return this->m_participators;
	}
 	void Meeting::setParticipator(const std::vector<std::string> &t_participators){
		std::vector<std::string> mid=t_participators;
		this->m_participators=mid;
	}
	Date Meeting::getStartDate(void) const{
		return this->m_startDate;
	}
	void Meeting::setStartDate(const Date &t_startTime){
		this->m_startDate=t_startTime;
	}
	Date Meeting::getEndDate(void) const{
		return this->m_endDate;
	}
	void Meeting::setEndDate(const Date& t_endTime){
		this->m_endDate=t_endTime;
	}
	std::string Meeting::getTitle(void) const{
		return this->m_title;
	}
	void Meeting::setTitle(const std::string &t_title){
		this->m_title=t_title;
	}
    void Meeting::removeParticipator(const std::string &t_participator){
       int index;
       for(int i=0;i<this->m_participators.size();i++){
            if(this->m_participators[i]==t_participator){
                index=i;
                break;
            }
            index=-1;
       }
       if(index==-1) return ;
        for(int i=index;i<this->m_participators.size()-1;i++){
            std::string name=this->m_participators[i];
            this->m_participators[i]=this->m_participators[i+1];
            this->m_participators[i+1]=name;
        }

       this->m_participators.pop_back();
    }
    void Meeting::addParticipator(const std::string &t_participator){
        this->m_participators.push_back(t_participator);
    }
	bool Meeting::isParticipator(const std::string &t_username) const{
		for(int i=0;i<this->m_participators.size();i++){
			if(t_username==this->m_participators[i]) return true;
		}
		return false;
	}


